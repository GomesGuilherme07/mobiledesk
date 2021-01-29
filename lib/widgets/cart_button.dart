import 'package:flutter/material.dart';
import 'package:mobile_desk/screens/cart_screen.dart';

class CartButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.list, color: Colors.white,),
      onPressed: (){
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context)=> CartScreen())
        );
      },
      backgroundColor: Theme.of(context).primaryColor,
    );
  }
}
