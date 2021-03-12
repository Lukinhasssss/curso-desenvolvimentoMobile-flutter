 import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual/models/cart_model.dart';

class DiscountCart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: ExpansionTile( // É uma tile que quando você clica no item ela expande
        leading: Icon(Icons.card_giftcard),
        title: Text('Cupom de Desconto',
          textAlign: TextAlign.start,
          style: TextStyle(fontWeight: FontWeight.w500, color: Colors.grey[500]),
        ),
        trailing: Icon(Icons.add),
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Digite seu cupom'
              ),
              initialValue: CartModel.of(context).couponCode ?? '',
              onFieldSubmitted: (text) {
                Firestore.instance.collection('coupons').document(text).get()
                  .then((docSnap) => {
                    if (docSnap.data != null) {
                      CartModel.of(context).setCoupon(text, docSnap.data['percent']),
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Desconto de ${docSnap.data['percent']}% aplicado!'),
                          backgroundColor: Theme.of(context).primaryColor
                        )
                      )
                    } else {
                      CartModel.of(context).setCoupon(null, 0),
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Cupom inválido!'),
                          backgroundColor: Colors.redAccent
                        )
                      )
                    }
                });
              },
            )
          )
        ],
      )
    );
  }
}
