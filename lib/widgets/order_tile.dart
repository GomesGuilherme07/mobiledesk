import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class OrderTile extends StatelessWidget {

  final String orderId;
  OrderTile(this.orderId);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
      child: Padding(
        padding: EdgeInsets.all(8.0),
        // StreamBuilder serve para acompanhar em tempo real o banco de dados e atualizar a tela
        child: StreamBuilder<DocumentSnapshot>(
          stream: Firestore.instance.collection("orders").document(orderId).snapshots(),
          builder: (context, snapshot){
            // Caso não tenha conteudo
            if(!snapshot.hasData)
              return Center(
                child: CircularProgressIndicator(),
              );
            // Casop tenha conteudo
            else{

              int status =  snapshot.data["status"];

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("Código do chamado: ${snapshot.data.documentID}",
                  style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4.0,),
                  Text(
                      _buildChamadoText(snapshot.data)
                  ),
                  SizedBox(height: 4.0,),
                  Text("Status do chamado: ",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 6.0,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      _statusCircle("1", "Aberto", status+1, 1),
                      // Cria a linha divisoria entre os circulos de status
                      Container(
                        height: 1.0,
                        width: 40.0,
                        color: Colors.grey[500],
                      ),
                      _statusCircle("2", "Na Fila", status+1, 2),
                      // Cria a linha divisoria entre os circulos de status
                      Container(
                        height: 1.0,
                        width: 40.0,
                        color: Colors.grey[500],
                      ),
                      _statusCircle("3", "Em Atendimento", status+1, 3),
                      Container(
                        height: 1.0,
                        width: 40.0,
                        color: Colors.grey[500],
                      ),
                      _statusCircle("4", "Concluído", status+1, 4),
                    ],
                  )
                ],
              );
            }
          },
        ),
      )
    );
  }

  // Retorna o texto apresentado na tela Meus Chamados com a descrição
  String _buildChamadoText(DocumentSnapshot snapshot){

    String text = "Descrição:\n";
    for(LinkedHashMap p in snapshot.data["chamados"]){
      text += "${p["chamado"]["title"]} - ${p["dispositivo"]}\n\nData de abertura: ${p["dia"]}/${p["mes"]}/${p["ano"]} - ${p["hora"]}:${p["minuto"]}\n"
          "Tempo previsto para conclusão: 16 horas\n";
    }
    return text;

  }

  // Retorna o circulo que indica o status do chamado
  Widget _statusCircle(String title, String subtitle, int status, int thisStatus){

    Color backColor;
    Widget child;

    if(status < thisStatus){
      backColor = Colors.grey[500];
      child = Text(title, style: TextStyle(color: Colors.white),);
    } else if (status == thisStatus){
      backColor = Colors.red;
      child = Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Text(title, style: TextStyle(color: Colors.white),),
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          )
        ],
      );
    } else {
      backColor = Colors.green;
      child = Icon(Icons.check, color: Colors.white,);
    }

    return Column(
      children: <Widget>[
        CircleAvatar(
          radius: 20.0,
          backgroundColor: backColor,
          child: child,
        ),
        Text(subtitle, style: TextStyle(fontSize: 10.0),)
      ],
    );

  }

}
