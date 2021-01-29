import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mobile_desk/models/chamado_data.dart';
import 'package:mobile_desk/widgets/chamado_tile.dart';

class CategoriaChamadoScreen extends StatelessWidget {

  final DocumentSnapshot snapshot;
  CategoriaChamadoScreen(this.snapshot);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(snapshot.data["title"]),
          centerTitle: true,
          bottom: TabBar(
            indicatorColor: Colors.white,
            tabs: <Widget>[
              Tab(icon: Icon(Icons.grid_on),),
              Tab(icon: Icon(Icons.list),),
            ],
          ),
        ),
        body: FutureBuilder<QuerySnapshot>(
          future: Firestore.instance.collection("chamados").document(snapshot.documentID)
          .collection("items").getDocuments(),
          builder: (context, snapshot){
            if(!snapshot.hasData)
              return Center(child: CircularProgressIndicator(),);
            else
              return TabBarView(
                physics: NeverScrollableScrollPhysics(),
                children: [
                  // Visualização em Grade
                  GridView.builder(
                    padding: EdgeInsets.all(4.0),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 4.0,
                        crossAxisSpacing: 4.0,
                        childAspectRatio: 0.65,
                      ),
                      itemCount: snapshot.data.documents.length,
                      itemBuilder: (context, index){

                        ChamadoData data = ChamadoData.fromDocument(snapshot.data.documents[index]);
                        data.categoria = this.snapshot.documentID;

                        return ChamadoTile("grid", data);
                      }
                  ),

                  // Visualização em Lista
                  ListView.builder(
                      padding: EdgeInsets.all(4.0),
                      itemCount: snapshot.data.documents.length,
                      itemBuilder: (context, index){

                        ChamadoData data = ChamadoData.fromDocument(snapshot.data.documents[index]);
                        data.categoria = this.snapshot.documentID;

                        return ChamadoTile("list", data);
                      }
                  )
                ],
              );
          },
        )
      ),

    );
  }
}
