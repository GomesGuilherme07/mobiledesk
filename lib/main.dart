import 'package:flutter/material.dart';
import 'package:mobile_desk/screens/cadastro_sreen.dart';
import 'package:mobile_desk/screens/home_sreen.dart';
import 'package:mobile_desk/screens/login_sreen.dart';
import 'package:scoped_model/scoped_model.dart';

import 'models/cart_model.dart';
import 'models/user_model.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModel<UserModel>(
      model: UserModel(),
      child: ScopedModelDescendant<UserModel>(
        builder: (context, child, model){
          return ScopedModel<CartModel>(
            model: CartModel(model),
            child: MaterialApp(
              title: "MOBILE DESK",
              theme: ThemeData(
                  primarySwatch: Colors.red,
                  primaryColor: Color.fromARGB(255, 255, 0, 0)
              ),
              debugShowCheckedModeBanner: false,
              home: HomeScreen(),
            ),
          );
        },
      )
    );
  }
}
