//import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_desk/screens/home_sreen.dart';

class OrderScreen extends StatelessWidget {

  final String orderId;
  OrderScreen(this.orderId);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chamado Aberto"),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.check, color: Theme.of(context).primaryColor, size: 80.0,),
            Text("Chamado aberto com sucesso !!", style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 18.0
            ),
            ),
            Text("ID do chamado: $orderId", style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 40.0,),
            RaisedButton(
              child: Text("Voltar ao Menu"),
              textColor: Colors.white,
              color: Theme.of(context).primaryColor,
              onPressed: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => HomeScreen()));
              },
            ),
          ],
        ),
      ),

    );
  }
}
