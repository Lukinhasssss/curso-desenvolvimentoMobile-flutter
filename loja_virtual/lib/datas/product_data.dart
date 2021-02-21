import 'package:cloud_firestore/cloud_firestore.dart';

class ProductData { // Essa classe serve apenas para armazenar os dados do produto

  String category;
  String id;
  String title;
  String description;
  double price;

  List images;
  List sizes;

  ProductData.fromDocument(DocumentSnapshot snapshot) {
    id = snapshot.documentID;
    title = snapshot.data['title'];
    description = snapshot.data['description'];
    price = snapshot.data['price'] + 0.0; // Para forçar o preço a ser um double
    images = snapshot.data['images'];
    sizes = snapshot.data['sizes'];
  }

  Map<String, dynamic> toResumedMap() {
    return {
      'title': title,
      'description': description,
      "price": price
    };
  }

}