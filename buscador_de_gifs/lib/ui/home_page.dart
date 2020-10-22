import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:share/share.dart';
import 'package:transparent_image/transparent_image.dart';

import 'package:buscador_de_gifs/ui/gif_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  String _search;
  int _offset = 0;

  Future<Map> _getGifs() async { // Essa função vai fazer uma requisição http para obter os dados
    http.Response response;

    if (_search == null)
      response = await http.get('https://api.giphy.com/v1/gifs/trending?api_key=MIF2YqAoJ0B2o0QjgUonuHT9AJI33GBx&limit=20&rating=g');
    else
      response = await http.get('https://api.giphy.com/v1/gifs/search?api_key=MIF2YqAoJ0B2o0QjgUonuHT9AJI33GBx&q=$_search&limit=19&offset=$_offset&rating=g&lang=pt');

    return json.decode(response.body); // Para retornar o conteúdo do corpo da requisição
  }

  @override
  void initState() {
    super.initState();

    // _getGifs().then((map) {
    //   print(map);
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Image.network('https://developers.giphy.com/static/img/dev-logo-lg.7404c00322a8.gif'),
        centerTitle: true
      ),
      backgroundColor: Colors.black,
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(10.0), // Vai dar um padding de 10 em todos os lados
            child: TextField(
              decoration: InputDecoration(
                labelText: "Pesquise Aqui!",
                labelStyle: TextStyle(color: Colors.white),
                border: OutlineInputBorder()
              ),
              style: TextStyle(color: Colors.white, fontSize: 18.0),
              textAlign: TextAlign.center,
              onSubmitted: (text) { // Quando dar o submit vai chamar essa função passando o texto que foi escrito no TextField
                setState(() { // O setState da um "refresh" na aplicação, ou seja, vai reconstruir a tela
                  _search = text;
                  _offset = 0; // Para resetar os gifs caso alguma pesquisa já tenha sido feita
                });
              },
            ),
          ),
          Expanded( // Para o Widget saber exatamente qual espaço ele irá ocupar
            child: FutureBuilder(
              future: _getGifs(),
              builder: (context, snapshot) { //Função que vai criar o layout dependendo do status do Future
                switch(snapshot.connectionState) {
                  case ConnectionState.waiting:
                  case ConnectionState.none:
                    return Container(
                      width: 200.0,
                      height: 200.0,
                      alignment: Alignment.center,
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        strokeWidth: 5.0
                      ),
                    );
                  default:
                    if (snapshot.hasError) return Container();
                    else return _createGifTable(context, snapshot);
                }
              }
            ),
          )
        ],
      ),
    );
  }

  int _getCount(List data) {
    if (_search == null  || _search.isEmpty) { // Ou seja, se eu não estiver pesquisando...
      return data.length;
    } else {
      return data.length + 1;
    }
  }

  /// Widget para criar a tabela de gifs
  Widget _createGifTable(BuildContext context, AsyncSnapshot snapshot) {
    return GridView.builder(
      padding: EdgeInsets.all(10.0),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount( // Mostra como os dados vão ser organizados na tela
        crossAxisCount: 2, // Quantos itens ele poderá ter na horizontal
        crossAxisSpacing: 10.0, // Espaçamento entre os itens na horizontal
        mainAxisSpacing: 10.0 // Espaçamento na vertical
      ),
      itemCount: _getCount(snapshot.data['data']), // Quantidade de gifs que aparecerá na tela
      itemBuilder: (context, index) { // Retorna o Widget que colocaremos na posição(index) definida
        if (_search == null || index < snapshot.data['data'].length)
          return GestureDetector( // Para que seja capaz de clicarmos na imagem
            child: FadeInImage.memoryNetwork(
              placeholder: kTransparentImage,
              image: snapshot.data['data'][index]['images']['fixed_height']['url'],
              height: 300.0,
              fit: BoxFit.cover
            ),
            onTap: () {
              Navigator.push(context,
                MaterialPageRoute(builder: (context) => GifPage(snapshot.data['data'][index]))
              );
            },
            onLongPress: () {
              Share.share(snapshot.data['data'][index]['images']['fixed_height']['url']);
            },
          );
        else
          return Container(
            child: GestureDetector(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 70.0
                  ),
                  Text('Carregar mais...',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22.0
                    )
                  )
                ],
              ),
              onTap: () {
                setState(() {
                  _offset += 19; // Para pesquisar os próximos 19 itens
                });
              },
            ),
          );
      }
    );
  }

}
