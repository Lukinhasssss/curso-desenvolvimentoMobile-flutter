import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http; // Essa biblioteca permite que as requisições sejam feitas
import 'dart:async'; // Essa biblioteca permite que as requisições sejam feitas sem ter que ficar esperando a resposta dessas requisições
import 'dart:convert'; // Para transformar os dados do request em dados do tipo json
/*
* OBS: UMA REQUISIÇÃO ASSÍNCRONA (async) É UMA REQUISIÇÃO QUE VOCÊ FAZ E NÃO
* FICA ESPERANDO A RESPOSTA. A HORA QUE A RESPOSTA CHEGA VOCÊ FAZ ALGUMA COISA
* MAS O PROGRAMA CONTINUA RODANDO ENQUANTO AS RESPOSTAS NÃO CHEGAM
* */

const request = 'https://api.hgbrasil.com/finance?key=49af6992'; // Para fazer a requisição da minha url

void main() async {
  runApp(MaterialApp(
    home: Home(),
    theme: ThemeData(
      hintColor: Colors.amber,
      primaryColor: Colors.white,
      inputDecorationTheme: InputDecorationTheme(
        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.amber)),
        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
        hintStyle: TextStyle(color: Colors.amber)
      )
    ),
  ));
}

Future<Map> getData() async {  // Função que retorna um dado futuro e por isso precisa ser assíncrona (async)
  http.Response response = await http.get(request);
  return json.decode(response.body); // Pega o corpo da resposta da requisição e converte para JSON
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // Criando controladores para obter o texto dos TextFields
  final realController = TextEditingController(); // Controlador do Real (R$)
  final dolarController = TextEditingController(); // Controlador do Dólar (R$)
  final euroController = TextEditingController(); // Controlador do Euro (R$)

  double dolar;
  double euro;

  void _clearAll() { // Função para apagar todos os campos caso algum deles esteja vazio
    realController.text = '';
    dolarController.text = '';
    euroController.text = '';
  }

  void _realChanged(String text) {
    if (text.isEmpty) {
      _clearAll();
      return;
    }
    double real = double.parse(text);
    dolarController.text = (real / dolar).toStringAsFixed(2);
    euroController.text = (real / euro).toStringAsFixed(2);
  }

  void _dolarChanged(String text) {
    if (text.isEmpty) {
      _clearAll();
      return;
    }
    double dolar = double.parse(text);
    realController.text = (dolar * this.dolar).toStringAsFixed(2);
    euroController.text = (dolar * this.dolar / euro).toStringAsFixed(2); // Aqui eu estou primeiro convertendo para reais e depois dividindo pelo euro
  }

  void _euroChanged(String text) {
    if (text.isEmpty) {
      _clearAll();
      return;
    }
    double euro = double.parse(text);
    realController.text = (euro / this.euro).toStringAsFixed(2);
    dolarController.text = (euro / this.euro / dolar).toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('\$ Conversor \$'), // A barra invertida serve para o $ ser identificado como uma string
        backgroundColor: Colors.amber,
        centerTitle: true,
      ),
      body: FutureBuilder<Map>(
        future: getData(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return Center(
                child: Text('Carregando Dados...',
                  style: TextStyle(
                    color: Colors.amber,
                    fontSize: 25.0),
                textAlign: TextAlign.center)
              );
            default:
              if (snapshot.hasError) {
                return Center(
                    child: Text('Carregando Dados...',
                        style: TextStyle(
                            color: Colors.amber,
                            fontSize: 25.0),
                        textAlign: TextAlign.center)
                );
              } else {
                dolar = snapshot.data['results']['currencies']['USD']['buy'];
                euro = snapshot.data['results']['currencies']['EUR']['buy'];

                return SingleChildScrollView(
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Icon(Icons.monetization_on, size: 150.0, color: Colors.amber),
                      Divider(),
                      buildTextField('Reais', 'R\$', realController, _realChanged),
                      Divider(),
                      buildTextField('Dólares', 'US\$', dolarController, _dolarChanged),
                      Divider(),
                      buildTextField('Euros', '€', euroController, _euroChanged),
                    ],
                  ),
                );
              }
          }
        }
      ),
    );
  }
}

Widget buildTextField(String label, String prefix, TextEditingController currencyControler, Function f) {
  return TextField(
    controller: currencyControler,
    decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.amber),
        border: OutlineInputBorder(),
        prefixText: prefix
    ),
    style: TextStyle(
        color: Colors.amber, fontSize: 25.0
    ),
    keyboardType: TextInputType.numberWithOptions(decimal: true),
    onChanged: f,
  );
}