import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Home()
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  /* Criando os controladores (controllers) */
  TextEditingController weightController = TextEditingController(); // Controlador do peso
  TextEditingController heightController = TextEditingController(); // Controlador da altura

  /* Criando GlobalKey para validação do formulário */
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  /* Modificando o texto que dará o resultado do IMC */
  String _infoText = 'Informe seus dados!';

  /* Criando função para o botão de reset que irá resetar os campos 'peso' e 'altura' */
  void _resetFields() {
    weightController.text = '';
    heightController.text = '';
    setState(() { // !!!!!!!!!!OBS: É SEMPRE IMPORTANTE UTILIZAR O 'setState' PARA INFORMAR QUE OUVE MUDANÇAS NO LAYOUT
      _infoText = 'Informe seus dados!';
      _formKey = GlobalKey<FormState>();
    });
  }

  /* Criando a função que irá calcular o IMC */
  void _calculateIMC() {
    setState(() {
      double weight = double.parse(weightController.text); // Pega o texto que será digitado no peso e transforma em um double
      double height = double.parse(heightController.text) / 100; // Dividi por 100 pois a altura é em centímetros

      double imc = weight / pow(height, 2); // IMC = peso * altura ao quadrado
      print(imc);
      if (imc < 18.6) {
        _infoText = 'Abaixo do Peso (${imc.toStringAsFixed(2)})'; // Também pode ser utilizada a 'toStringAsFixed()'
      } else if (imc >= 18.6 && imc < 24.9) {
        _infoText = 'Peso Ideal (${imc.toStringAsFixed(2)})';
      } else if (imc >= 24.9 && imc < 29.9) {
        _infoText = 'Levemente do Peso (${imc.toStringAsFixed(2)})';
      } else if (imc >= 29.9 && imc < 34.9) {
        _infoText = 'Obesidade Grau I (${imc.toStringAsFixed(2)})';
      } else if (imc >= 34.9 && imc < 39.9) {
        _infoText = 'Obesidade Grau II (${imc.toStringAsFixed(2)})';
      } else if (imc >= 40) {
        _infoText = 'Obesidade Grau III (${imc.toStringAsFixed(2)})';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculadora de IMC'),
        centerTitle: true,
        backgroundColor: Colors.green,
        actions: [
          IconButton(icon: Icon(Icons.refresh), onPressed: _resetFields,)
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch, // sempre tenta preencher toda a largura, mas como a imagem já tem uma largura definida ela fica centralizada no meio
            children: <Widget>[
              Icon(Icons.person_outline, size: 120.0, color: Colors.green),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: 'Peso (kg)',
                    labelStyle: TextStyle(color: Colors.green)),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.green, fontSize: 25.0),
                controller: weightController,
                validator: (value) { // recebe como parâmetro o valor do meu campo
                  if (value.isEmpty) {
                    return 'Insira seu Peso!';
                  }
                },
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: 'Altura (cm) ',
                    labelStyle: TextStyle(color: Colors.green)),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.green, fontSize: 25.0),
                controller: heightController,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Insira sua Altura!';
                  }
                },
              ),
              Padding(
                padding: EdgeInsets.only(top: 25.0, bottom: 10.0),
                child: Container(
                  height: 50.0,
                  child: RaisedButton(
                    onPressed: () {
                      if (_formKey.currentState.validate()) { // Se o formulário for validado eu chamo a função _calculateIMC
                        _calculateIMC();
                      }
                    },
                    child: Text('Calcular',
                        style: TextStyle(color: Colors.white, fontSize: 25.0)),
                    color: Colors.green,
                  ),
                ),
              ),
              Text(_infoText,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.green, fontSize: 25.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
