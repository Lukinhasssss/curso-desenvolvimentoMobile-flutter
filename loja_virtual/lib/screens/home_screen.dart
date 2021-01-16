import 'package:flutter/material.dart';

import 'package:loja_virtual/tabs/home_tab.dart';
import 'package:loja_virtual/widgets/custom_drawer.dart';

class HomeScreen extends StatelessWidget {

  final _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return PageView( // Com o PageView é possível alterar de página e manter o menu drawer
      controller: _pageController,
      physics: NeverScrollableScrollPhysics(), // Desta forma é possível controlar o scroll a partir de um código. Para isso é preciso setar um controlador
      children: <Widget>[
        Scaffold(
          body: HomeTab(),
          drawer: CustomDrawer(),
        )
      ], // children -> Receba vários widgets
    );
  }
}
