import 'package:flutter/material.dart';

class DrawerTile extends StatelessWidget {

  final IconData icon;
  final String text;
  final PageController controller;
  final int page;

  DrawerTile(this.icon, this.text, this.controller, this.page);

  @override
  Widget build(BuildContext context) {
    return Material( // Para dar um efeito visual ao clicar no item
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          Navigator.of(context).pop(); // Para fechar o navigation drawer antes de mudar de página
          controller.jumpToPage(page);
        },
        child: Container(
          height: 60.0,
          child: Row(
            children: <Widget>[
              Icon(
                icon, // É o Icon que será recebido como parâmetro no construtor
                size: 32.0,
                color: controller.page.round() == page ? Theme.of(context).primaryColor : Colors.grey[700], // Serve para arredondar o valor do page que aqui é um double com o valor próximo do valor da página
              ),
              SizedBox(width: 32.0), // Para dar um espaçamento entre os itens
              Text(
                text, // É o texto que será recebido como parâmetro no construtor
                style: TextStyle(fontSize: 16.0, color: controller.page.round() == page ? Theme.of(context).primaryColor : Colors.grey[700])
              )
            ],
          )
        )
      )
    );
  }
}
