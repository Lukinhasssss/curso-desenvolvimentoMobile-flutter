import 'package:flutter/material.dart';

// import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:chat_online/chat_screen.dart';

void main() async {
  runApp(MyApp());

}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        iconTheme: IconThemeData(
          color: Colors.blue
        )
      ),
      home: ChatScreen(),
      debugShowCheckedModeBanner: false
    );
  }
}

// Firestore.instance.collection('col').document('doc').setData({'texto': 'lucas'});

/*
  QuerySnapshot snapshot = await Firestore.instance.collection('nome da coleção').getDocuments();
  snapshot.documents.forEach((document) {
    print(document.data);
  });
*/

/*
  DocumentSnapshot snapshot = await Firestore.instance.collection('nome da coleção').document('id do documento').get();
  print(snapshot.data);
*/

/*
  QuerySnapshot snapshot = await Firestore.instance.collection('nome da coleção').getDocuments();
  snapshot.documents.forEach((document) {
    document.reference.updateData(data);
  });
*/

/*
  Firestore.instance.collection('nome da coleção').snapshots().listen((event) { // sempre que alguma coisa mudar chama uma função
    event.documents.forEach((document) {
      print(document.data);
    });
  });
*/

/*
  Firestore.instance.collection('nome da coleção').document('id do documento').snapshots().listen((dado) {
    print(dado.data);
  });
*/