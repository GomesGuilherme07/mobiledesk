import 'package:cloud_firestore/cloud_firestore.dart';

class ChamadoData{

  String categoria;
  String id;
  String title;
  String descricao;
  String img;
  List dispositivo;

  ChamadoData.fromDocument(DocumentSnapshot snapshot){
    id = snapshot.documentID;
    title = snapshot.data["title"];
    descricao = snapshot.data["descricao"];
    img = snapshot.data["img"];
    dispositivo = snapshot.data["dispositivo"];
  }

  Map<String, dynamic> toResumeMap(){
    return{
      "title": title,
      "descricao": descricao,

    };
  }

}