import 'package:flutter/material.dart';

class DrawerTile extends StatelessWidget {

  final IconData icon;
  final String text;
  final PageController controller;
  final int page;

  DrawerTile(this.icon, this.text, this.controller, this.page);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: (){
          Navigator.of(context).pop(); // fecha o drawer
          controller.jumpToPage(page); // troca a página
        },
        child: Container(
          height: 60.0,
          child: Row(
            children: <Widget>[
              Icon(
                icon,
                size: 32.0,
                color: controller.page.round() == page ?
                  Theme.of(context).primaryColor : Colors.grey[700], // condição para verificar qual item do drawer está selecionado
              ),
              SizedBox(width: 32.0,),
              Text(text, style: TextStyle(fontSize: 16.0, color: Colors.black),)
            ],
          ),
        ),
      ),
    );
  }
}
