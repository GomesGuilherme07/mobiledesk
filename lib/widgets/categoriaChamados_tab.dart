import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mobile_desk/widgets/categoria_tile.dart';

class CategoriaChamados extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
      future: Firestore.instance.collection("chamados").getDocuments(),
      builder: (context, snapshot){
        if(!snapshot.hasData)
          return Center(child: CircularProgressIndicator(),);
        else{
          var dividedTiles = ListTile.divideTiles(
              tiles: snapshot.data.documents.map((doc){
                return CategoriaTile(doc);
              }
          ).toList(),
          color: Colors.grey[700]).toList();

          return ListView(
            children: dividedTiles,
          );
        }
      },
    );
  }
}
