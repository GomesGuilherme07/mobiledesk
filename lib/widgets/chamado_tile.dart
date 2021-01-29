import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_desk/models/chamado_data.dart';
import 'package:mobile_desk/screens/chamado_screen.dart';

class ChamadoTile extends StatelessWidget {

  final String type;
  final ChamadoData chamado;

  ChamadoTile(this.type, this.chamado);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.of(context).push(MaterialPageRoute(builder: (context)=> ChamadoScreen(chamado)));
      },
      child: Card(
        child: type == "grid" ?
            // Visualização em Grid
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                AspectRatio(
                  aspectRatio: 0.8,
                  child: Image.network(
                    chamado.img,
                    fit: BoxFit.cover,
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      children: <Widget>[
                        Text(chamado.title,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 17.0,
                        ),
                        ),
                        Text("Clique para saber mais",
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 12.0,

                          ),)
                      ],
                    ),
                  ),
                )
            ],)

        //Visualização em List
            : Row(
          children: <Widget>[
            Flexible(
              flex: 1,
              child: Image.network(
                chamado.img,
                fit: BoxFit.cover,
                height: 250.0,
              ),
            ),
            Flexible(
              flex: 1,
              child: Container(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(chamado.title,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 17.0,
                      ),
                    ),
                    Text("Clique para saber mais",
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 12.0,

                      ),)
                  ],
                ),
              ),
            ),
          ],
        )
      ),
    );
  }
}
