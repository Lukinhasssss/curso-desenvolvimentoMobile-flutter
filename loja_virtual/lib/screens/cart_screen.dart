import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:loja_virtual/models/cart_model.dart';
import 'package:loja_virtual/models/user_model.dart';
import 'package:loja_virtual/screens/login_screen.dart';
import 'package:loja_virtual/tiles/cart_tile.dart';
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
      body: ScopedModelDescendant<CartModel>(
        builder: (context, child, model) {
          if (model.isLoading && UserModel.of(context).isLoggedIn()) {
            return Center(
              child: CircularProgressIndicator()
            );
          } else if (!UserModel.of(context).isLoggedIn()) {
            return Container(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.remove_shopping_cart, size: 80.0, color: Theme.of(context).primaryColor),
                  SizedBox(height: 16.0),
                  Text('Faça o login para adicionar produtos!',
                    style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center
                  ),
                  SizedBox(height: 16.0),
                  ElevatedButton(
                    child: Text('Entrar', style: TextStyle(fontSize: 18.0)),
                    style: ElevatedButton.styleFrom(
                      primary: Theme.of(context).primaryColor,
                      onPrimary: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4.0),
                        side: BorderSide(color: Colors.teal[800])
                      )
                    ),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginScreen()));
                    }
                  )
                ],
              )
            );
          } else if (model.products == null || model.products.length == 0) {
            return Center(
              child: Text("Nenhum produto no carrinho!",
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center
              )
            );
          } else {
            return ListView(
              children: <Widget>[
                Column(
                  children: model.products.map(
                      (product) {
                        return CartTile(product);
                      }
                  ).toList()
                )
              ],
            );
          }
        }
      )
    );
  }
}
