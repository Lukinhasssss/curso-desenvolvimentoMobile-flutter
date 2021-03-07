import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:loja_virtual/datas/cart_product.dart';
import 'package:loja_virtual/datas/product_data.dart';

class CartTile extends StatelessWidget {

  final CartProduct cartProduct;

  CartTile(this.cartProduct);

  @override
  Widget build(BuildContext context) {

    Widget _buildContent() {
      
    }

    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: cartProduct.productData == null ?
        FutureBuilder<DocumentSnapshot>(
          future: Firestore.instance.collection('products').document(cartProduct.category).collection('items').document(cartProduct.product_id).get(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              cartProduct.productData = ProductData.fromDocument(snapshot.data); // Converte o documento que acabamos de receber do Firebase em um ProductData
              return _buildContent();
            } else {
              return Container(
                height: 70.0,
                child: CircularProgressIndicator(),
                alignment: Alignment.center
              );
            }
          }
        ) :
          _buildContent()
    );
  }
}
