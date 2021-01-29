import 'package:flutter/material.dart';
import 'package:mobile_desk/models/cart_model.dart';
import 'package:mobile_desk/models/user_model.dart';
import 'package:mobile_desk/screens/login_sreen.dart';
import 'package:mobile_desk/screens/order_screen.dart';
import 'package:mobile_desk/widgets/cart_tile.dart';
import 'package:scoped_model/scoped_model.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Finalizar"),
        centerTitle: true,
        actions: <Widget>[
          Container(
            padding: EdgeInsets.only(right: 8.0),
            alignment: Alignment.center,
            child: ScopedModelDescendant<CartModel>(
              builder: (context, child, model) {
                int p = model.listChamados.length;
                return Text(
                  "${p ?? 0} ${p == 1 ? "ITEM" : "ITENS"}",
                  style: TextStyle(fontSize: 17.0),
                );
              },
            ),
          )
        ],
      ),
      body: ScopedModelDescendant<CartModel>(
          builder: (context, child, model) {
            if (model.isLoading && UserModel.of(context).isLoggedIn()) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (!UserModel.of(context).isLoggedIn()) {
              return Container(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.error_outline,
                      size: 80.0,
                      color: Theme
                          .of(context)
                          .primaryColor,),
                    SizedBox(height: 16.0,),
                    Text("Faça login para abrir chamados!",
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 16.0,),
                    RaisedButton(
                      child: Text("Entrar", style: TextStyle(fontSize: 18.0),),
                      textColor: Colors.white,
                      color: Theme
                          .of(context)
                          .primaryColor,
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
            } else
            if (model.listChamados == null || model.listChamados.length == 0) {
              return Center(
                child: Text("Nenhum chamado!",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,),
              );
            } else {
              return ListView(
                children: <Widget>[
                  Column(
                    children: model.listChamados.map(
                        (c){
                          return CartTile(c);
                        }
                    ).toList(),
                  ),
                  Card(
                    color: Colors.white,
                    margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                    child: Container(
                      padding: EdgeInsets.all(16.0),
                      child: RaisedButton(
                        child: Text("Finalizar Solicitação"),
                        textColor: Colors.white,
                        color: Theme.of(context).primaryColor,
                        onPressed: () async {
                          String orderId = await model.finishOrder();
                          if(orderId != null)
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(builder: (context) => OrderScreen(orderId))
                            );
                        },
                      ),
                    ),

                  )

                ],
              );
            }
          }
      ),
    );
  }
}