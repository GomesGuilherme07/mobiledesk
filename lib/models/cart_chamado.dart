import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobile_desk/models/chamado_data.dart';

// classe para armazenar os produtos dentro do carrinho
class CartChamado {

  String cid; // id da categoria
  String category;
  String pid; // id do chamado
  String dispositivo;

  static DateTime data = new DateTime.now();
  int ano = data.year;
  int mes = data.month;
  int dia = data.day;
  int hora = data.hour;
  int minuto = data.minute;

  ChamadoData chamadoData;

  CartChamado();

  CartChamado.fromDocument(DocumentSnapshot document){
    cid = document.documentID;
    category = document.data["category"];
    pid = document.data["pid"];
    dispositivo = document.data["dispositivo"];
    //data = document.data["data"];
    ano = document.data["ano"];
    mes = document.data["mes"];
    dia = document.data["dia"];
    hora = document.data["hora"];
    minuto = document.data["minuto"];
  }

  Map<String, dynamic> toMap(){
    return{
      "category": category,
      "pid": pid,
      "dispositivo": dispositivo,
      //"data": data,
      "ano": ano,
      "mes": mes,
      "dia": dia,
      "hora": hora,
      "minuto": minuto,
      "chamado": chamadoData.toResumeMap()
    };
  }

}