import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:loja_virtual/models/cart_model.dart';
import 'package:scoped_model/scoped_model.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meu Carrinho'),
        centerTitle: true,
        actions: <Widget>[
          Container(
            padding: EdgeInsets.only(right: 8.0),
            alignment: Alignment.center,
            child: ScopedModelDescendant<CartModel>(
              builder: (context, child, model) {
                int products = model.products.length; // Pega o tamanho da lista de produtos
                return Text(
                  '${products ?? 0} ${products == 1 ? 'ITEM' : 'ITEMS'}', // Se products for null vai retornar 0, caso contrário vai retornar o próprio valor de products
                  style: TextStyle(fontSize: 17.0)
                );
              }
            )
          )
        ]
      ),
    );
  }
}
