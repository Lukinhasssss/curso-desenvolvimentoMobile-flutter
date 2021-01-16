import 'package:flutter/material.dart';

class DrawerTile extends StatelessWidget {

  final IconData icon;
  final String text;

  DrawerTile(this.icon, this.text);

  @override
  Widget build(BuildContext context) {
    return Material( // Para dar um efeito visual ao clicar no item
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          print(text);
        },
        child: Container(
          height: 60.0,
          child: Row(
            children: <Widget>[
              Icon(
                icon, // É o Icon que será recebido como parâmetro no construtor
                size: 32.0,
                color: Colors.black,
              ),
              SizedBox(width: 32.0), // Para dar um espaçamento entre os itens
              Text(
                text, // É o texto que será recebido como parâmetro no construtor
                style: TextStyle(fontSize: 16.0, color: Colors.black)
              )
            ],
          )
        )
      )
    );
  }
}
