// Classe que irá armazenar um produto do carrinho, então o carrinho terá uma lista de objetos do tipo cart_product
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loja_virtual/datas/product_data.dart';

class CartProduct {

  String cart_id;
  String category;
  String product_id;
  int quantity;
  String size;

  ProductData productData;

  CartProduct();

  CartProduct.fromDocument(DocumentSnapshot product) {
    cart_id = product.documentID;
    category = product.data["category"];
    product_id = product.data["product_id"];
    quantity = product.data["quantity"];
    size = product.data['size'];
  }

  // Depois de adicionarmos o produto no carrinho é preciso adicioná-lo também no banco de dados
  Map<String, dynamic> toMap() {
    return {
      "category": category,
      "product_id": product_id,
      "quantity": quantity,
      "size": size,
      // "product": productData.toResumedMap()
    };
  }

}