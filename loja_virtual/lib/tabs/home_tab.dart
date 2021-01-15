import 'package:cloud_firestore/cloud_firestore.dart';
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
            ),
            FutureBuilder<QuerySnapshot>(
              future: Firestore.instance.collection("home").orderBy("pos").getDocuments(),
              builder: (context, snapshot) { // builder --> É a função que vai criar algo na tela dependendo do que o Future trazer
                if (!snapshot.hasData)
                  return SliverToBoxAdapter(
                    child: Container(
                      height: 200.0,
                      alignment: Alignment.center,
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      )
                    )
                  );
                else {
                  print(snapshot.data.documents.length);
                  return SliverToBoxAdapter(
                      child: Container(
                          height: 200.0,
                          alignment: Alignment.center,
                          child: Container()
                      )
                  );
                }
              }
            )
          ],
        )
      ],
    );
  }
}
