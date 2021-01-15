import 'package:flutter/material.dart';

class HomeTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    Widget _builderBodyBack() => Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color.fromARGB(255, 211, 118, 130), Color.fromARGB(255, 253, 181, 168)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight
        ),
      ),
    );

    return Stack( // O Stack coloca um conteúdo acima do outro. | O Stack coloca o conteúdo acima do fundo
      children: <Widget>[
        _builderBodyBack(),
        CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              floating: true,
              snap: true, // Significa que quando puxar para baixo a barra vai sumir e quando puxar para cima a barra vai reaparecer
              backgroundColor: Colors.transparent, // É a cor que vai ficar por baixo do texto
              elevation: 0.0,
              flexibleSpace: FlexibleSpaceBar(
                title: const Text('Novidades'), // O title é const pois o texto vai ser fixo e nunca vai alterar
                centerTitle: true,
              ),
            )
          ],
        )
      ],
    );
  }
}
