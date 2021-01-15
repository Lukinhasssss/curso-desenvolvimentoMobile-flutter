import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {

  final _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return PageView( // Com o PageView é possível alterar de página e manter o menu drawer
      controller: _pageController,
      physics: NeverScrollableScrollPhysics(), // Desta forma é possível controlar o scroll a partir de um código. Para isso é preciso setar um controlador
      children: <Widget>[
        Container(color: Colors.yellow),
        Container(color: Colors.red)
      ], // children -> Receba vários widgets
    );
  }
}
