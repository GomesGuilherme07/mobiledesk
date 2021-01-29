import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mobile_desk/models/cart_chamado.dart';
import 'package:mobile_desk/models/cart_model.dart';
import 'package:mobile_desk/models/chamado_data.dart';

class CartTile extends StatelessWidget {

  final CartChamado cartChamado;
  CartTile(this.cartChamado);

  @override
  Widget build(BuildContext context) {

    Widget _buildContent(){
      return Row(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(8.0),
            width: 120.0,
            child: Image.network(
              cartChamado.chamadoData.img,
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  Text("${cartChamado.chamadoData.title}",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 17.0),
                  ),
                  Text("Descrição: ${cartChamado.dispositivo}",
                  style: TextStyle(fontWeight: FontWeight.w300),),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      FlatButton(
                        child: Text("Remover"),
                        textColor: Theme.of(context).primaryColor,
                        onPressed: (){
                          CartModel.of(context).removeCardItem(cartChamado);
                        },
                      )
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      );
    }

    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: cartChamado.chamadoData == null ?
      FutureBuilder<DocumentSnapshot>(
        future: Firestore.instance.collection("chamados").document(cartChamado.category)
        .collection("items").document(cartChamado.pid).get(),
        builder: (context, snapshot){
          if(snapshot.hasData){
            cartChamado.chamadoData = ChamadoData.fromDocument(snapshot.data);
            return _buildContent();
          } else {
            return Container(
              height: 70.0,
              child: CircularProgressIndicator(),
              alignment: Alignment.center,
            );
          }
        },
      ) :
          _buildContent()
    );
  }
}
