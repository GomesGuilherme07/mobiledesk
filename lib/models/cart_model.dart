import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobile_desk/models/user_model.dart';
import 'package:scoped_model/scoped_model.dart';

import 'cart_chamado.dart';

class CartModel extends Model{

  UserModel user;

  List<CartChamado> listChamados = [];

  bool isLoading = false;

  CartModel(this.user){
    if(user.isLoggedIn())
      _loadCartItems();
  }

  static CartModel of(BuildContext context) => ScopedModel.of<CartModel>(context);

  // Função para adicionar um chamado no carrinho
  void addCartItem(CartChamado cartChamado){
    listChamados.add(cartChamado);

    Firestore.instance.collection("users").document(user.firebaseUser.uid)
        .collection("cart").add(cartChamado.toMap()).then((doc){
          cartChamado.cid = doc.documentID;
    });

    notifyListeners();
  }

  // Função para remover um chamado do carrinho
  void removeCardItem(CartChamado cartChamado){
    Firestore.instance.collection("users").document(user.firebaseUser.uid)
        .collection("cart").document(cartChamado.cid).delete();

    listChamados.remove(cartChamado);

    notifyListeners();

  }

  // Função para carregar os produtos no carinho
  void _loadCartItems() async {

    QuerySnapshot query = await Firestore.instance.collection("users").document(user.firebaseUser.uid)
        .collection("cart").getDocuments();

    listChamados = query.documents.map((doc) => CartChamado.fromDocument(doc)).toList();
    notifyListeners();
  }

  Future<String> finishOrder() async {

    if(listChamados.length == 0) return null;

    isLoading == true;
    notifyListeners();

    DocumentReference refOrder = await Firestore.instance.collection("orders").add(
      {
        "clientID":user.firebaseUser.uid,
        "chamados": listChamados.map((cartChamado)=> cartChamado.toMap()).toList(),
        "status": 1
      }
    );

    await Firestore.instance.collection("users").document(user.firebaseUser.uid)
    .collection("orders").document(refOrder.documentID).setData(
      {
        "orderID": refOrder.documentID
      }
    );
    
    QuerySnapshot query = await Firestore.instance.collection("users")
        .document(user.firebaseUser.uid).collection("cart").getDocuments();

    for(DocumentSnapshot doc in query.documents){
      doc.reference.delete();
    }

    listChamados.clear();
    isLoading = false;
    notifyListeners();

    return refOrder.documentID;


  }

}