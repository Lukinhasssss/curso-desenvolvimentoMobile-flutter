import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CategoryTile extends StatelessWidget {

  final DocumentSnapshot snapshot;

  CategoryTile(this.snapshot); // Construtor que recebe os dados da categoria

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar( // É o icone que fica na esquerda
        radius: 25.0,
        backgroundColor: Colors.transparent,
        backgroundImage: NetworkImage(snapshot.data['icon'])
      ),
      title: Text(snapshot.data['title']),
      trailing: Icon(Icons.keyboard_arrow_right), // É a setinha que vai ficar no final
      onTap: () {
        print("It's working. Category = ${snapshot.data['title']}");
      },
    );
  }
}