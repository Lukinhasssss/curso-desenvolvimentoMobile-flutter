import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual/datas/cart_product.dart';
import 'package:loja_virtual/models/user_model.dart';
import 'package:scoped_model/scoped_model.dart';

class CartModel extends Model {

  UserModel user;

  List<CartProduct> products = [];

  String couponCode;
  int discountPercentage = 0;

  bool isLoading = false;

  CartModel(this.user) {
    if (user.isLoggedIn())
      _loadCartItems();
  }

  static CartModel of(BuildContext context) => ScopedModel.of<CartModel>(context);

  void addCartItem(CartProduct cartProduct) {
    products.add(cartProduct);

    Firestore.instance.collection("users").document(user.firebaseUser.uid).collection("cart").add(cartProduct.toMap()).then((doc) {
      cartProduct.cart_id = doc.documentID;
    });

    notifyListeners();
  }

  void removeCartItem(CartProduct cartProduct) {
    Firestore.instance.collection("users").document(user.firebaseUser.uid).collection("cart").document(cartProduct.cart_id).delete();

    products.remove(cartProduct);

    notifyListeners();
  }

  void decrementProduct(CartProduct cartProduct) {
    cartProduct.quantity--;

    Firestore.instance.collection('users').document(user.firebaseUser.uid).collection("cart")
      .document(cartProduct.cart_id).updateData(cartProduct.toMap());

    notifyListeners();
  }

  void incrementProduct(CartProduct cartProduct) {
    cartProduct.quantity++;

    Firestore.instance.collection('users').document(user.firebaseUser.uid).collection("cart")
        .document(cartProduct.cart_id).updateData(cartProduct.toMap());

    notifyListeners();
  }

  void setCoupon(String couponCode, int discountPercentage) {
    this.couponCode = couponCode;
    this.discountPercentage = discountPercentage;
  }

  void updatePrices() {
    notifyListeners();
  }

  double getProductsPrice() { // Função que vai retornar o subtotal
    double price = 0.0;
    for (CartProduct cartProduct in products) {
      if (cartProduct.productData != null) {
        price += cartProduct.quantity * cartProduct.productData.price;
      }
    }
    return price;
  }

  double getDiscount() {
    return getProductsPrice() * discountPercentage / 100;
  }

  double getShipPrice() { // Função que vai retornar o valor da entrega
    return 3.29;
  }

  Future<void> _loadCartItems() async {
    QuerySnapshot query = await Firestore.instance.collection('users').document(user.firebaseUser.uid).collection("cart").getDocuments();
    
    products = query.documents.map((product) => CartProduct.fromDocument(product)).toList();

    notifyListeners();
  }

}