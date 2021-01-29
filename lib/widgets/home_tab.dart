import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mobile_desk/models/user_model.dart';
import 'package:mobile_desk/screens/categoriaChamado_screen.dart';
import 'package:mobile_desk/screens/login_sreen.dart';

import 'order_tile.dart';

class HomeTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    // Caso o usuário esteja logado
    if(UserModel.of(context).isLoggedIn()){

      String uid = UserModel.of(context).firebaseUser.uid;

      return FutureBuilder<QuerySnapshot>(
        future: Firestore.instance.collection("users").document(uid).collection("orders").getDocuments(),
        builder: (context, snapshot){
          if(!snapshot.hasData)
            return Center(
              child: CircularProgressIndicator(),
            );
          else
            return ListView(
              children: snapshot.data.documents.map((doc) => OrderTile(doc.documentID)).toList(),
            );
        },

      );

    // Caso o usuário não esteja logado
    }else{

      return Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.view_list, size: 80.0,color: Theme.of(context).primaryColor,),
            SizedBox(height: 16.0,),
            Text("Faça login para acompanhar os chamados",
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16.0,),
            RaisedButton(
              child: Text("Entrar", style: TextStyle(fontSize: 18.0),),
              textColor: Colors.white, color: Theme.of(context).primaryColor,
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) =>
                        LoginScreen())
                );
              },
            )
          ],
        ),
      );

    }

  }
}
