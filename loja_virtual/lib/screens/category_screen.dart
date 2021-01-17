import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual/datas/product_data.dart';
import 'package:loja_virtual/tiles/product_tile.dart';

class CategoryScreen extends StatelessWidget { // Essa tela será chamada a partir do category_tile

  final DocumentSnapshot snapshot;

  CategoryScreen(this.snapshot);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Quantas tabs a tela terá
      child: Scaffold(
        appBar: AppBar(
          title: Text(snapshot.data['title']),
          centerTitle: true,
          bottom: TabBar(
            indicatorColor: Colors.white,
            tabs: <Widget>[
              Tab(icon: Icon(Icons.grid_on)),
              Tab(icon: Icon(Icons.list))
            ],
          ),
        ),
        body: FutureBuilder<QuerySnapshot>(
          future: Firestore.instance.collection('products').document(snapshot.documentID).collection('items').getDocuments(),
          builder: (context, snapshot) {
            if (!snapshot.hasData)
              return Center(child: CircularProgressIndicator());
            else {
              return TabBarView( // É preciso especificar o que será mostrado em cada uma das tabs
                physics: NeverScrollableScrollPhysics(),
                children: [
                  GridView.builder(
                    padding: EdgeInsets.all(4.0),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(  // gridDelegate --> Quantos itens terão na horizontal e o espaçamento entre eles
                      crossAxisCount: 2,
                      mainAxisSpacing: 4.0,
                      crossAxisSpacing: 4.0,
                      childAspectRatio: 0.65
                    ),
                    itemCount: snapshot.data.documents.length,
                    itemBuilder: (context, index) {
                      return ProductTile('grid', ProductData.fromDocument(snapshot.data.documents[index]));
                    }
                  ),
                  ListView.builder(
                    padding: EdgeInsets.all(4.0),
                    itemCount: snapshot.data.documents.length,
                    itemBuilder: (context, index) {
                      return ProductTile('list', ProductData.fromDocument(snapshot.data.documents[index]));
                    }
                  )
                ],
              );
            }
          }
        ),
      )
    );
  }
}
/*
        DocumentSnapshot X QuerySnapshot

    • DocumentSnapshot: É a "fotografia" de somente 1 documento.
    • QuerySnapshot: É a "fotografia" de uma coleção de documentos. É possível acessar cada um dos documento com o documentsnapshot

 */