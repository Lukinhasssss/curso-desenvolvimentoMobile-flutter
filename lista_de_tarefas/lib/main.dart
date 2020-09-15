import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

import 'dart:io';
import 'dart:convert';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final _toDoController = TextEditingController(); // Este controlador serve para pegar os valores do Input

  List _toDoList = [];  // Lista que vai armazenar as tarefas
  Map<String, dynamic> _lastRemoved;
  int _lastRemovedPos;

  // Lendo os dados quando o App abre
  @override
  void initState() {
    super.initState();

    _readData().then((data) {
      setState(() {
        _toDoList = json.decode(data);
      });
    });
  }

  // Função para adicionar itens na lista
  void _addToDo() {
    setState(() { // O setState serve para atualizar o estado(state) da tela
      Map<String, dynamic> newToDo = Map();
      newToDo['title'] = _toDoController.text;
      _toDoController.text = '';
      newToDo['ok'] = false;
      _toDoList.add(newToDo);

      _saveData();
    });
  }

  Future<Null> _refresh() async {
    await Future.delayed(Duration(seconds: 1));

    setState(() {
      _toDoList.sort((a, b) {
        if (a['ok'] && !b['ok']) return 1;
        else if (!a['ok'] && b['ok']) return -1;
        else return 0;
      });

      _saveData();
    });

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Tarefas'),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(17.0, 1.0, 7.0, 1.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: _toDoController,
                    decoration: InputDecoration(
                      labelText: 'Nova Tarefa',
                      labelStyle: TextStyle(color: Colors.blueAccent)
                    )
                  ),
                ),
                RaisedButton(
                  color: Colors.blueAccent,
                  child: Text('ADD'),
                  textColor: Colors.white,
                  onPressed: _addToDo,
                ),
              ],
            ),
          ),
          Expanded(
            child: RefreshIndicator(
              child: ListView.builder(
                  padding: EdgeInsets.only(top: 10.0),
                  itemCount: _toDoList.length, // itemCount --> Qtd de itens que terá na lista
                  itemBuilder: buildItem
              ),
              onRefresh: _refresh
            )
          )
        ],
      ),
    );
  }

  // Criando a função buildItem...
  Widget buildItem(BuildContext context, int index) { // O index é o elemento da lista que está sendo renderizado no momento
    return Dismissible ( // Widget que permite arrastar o item para a direita para poder deletá-lo
      key: Key(DateTime.now().millisecondsSinceEpoch.toString()), // A key serve para eu saber exatamente qual elemento está sendo deslizado
      background: Container(
        color: Colors.red,
        child: Align(
          alignment: Alignment(-0.9, 0.0), // Os valores vão de -1 à 1
          child: Icon(Icons.delete, color: Colors.white),
        ),
      ),
      direction: DismissDirection.startToEnd, // A direção que o item deverá ser arrastado
      child: CheckboxListTile(
        title: Text(_toDoList[index]['title']),
        value: _toDoList[index]['ok'],
        secondary: CircleAvatar(
            child: Icon(_toDoList[index]['ok'] ? Icons.check : Icons.error)
        ),
        onChanged: (check) {
          setState(() {
            _toDoList[index]['ok'] = check;
            _saveData();
          });
        },
      ),
      onDismissed: (direction) {
        setState(() {
          _lastRemoved = Map.from(_toDoList[index]);
          _lastRemovedPos = index; // Para salvar a posição que removemos
          _toDoList.removeAt(index);

          _saveData();

          final snack = SnackBar(
            content: Text('Tarefa \"${_lastRemoved['title']}\" removida'),
            action: SnackBarAction(
              label: 'Desfazer',
              onPressed: () {
                setState(() { // O setState deve ser utilizado sempre que for atualizar alhguma coisa na tela
                  _toDoList.insert(_lastRemovedPos, _lastRemoved);
                  _saveData();
                });
              },
            ),
            duration: Duration(seconds: 2)
          );

          Scaffold.of(context).removeCurrentSnackBar();
          Scaffold.of(context).showSnackBar(snack);

        });
      },
    );
  }

  // Função para obter o arquivo
  Future<File> _getFile() async {
    final directory = await getApplicationDocumentsDirectory(); // Essa função pega o diretório onde eu posso armazenar os documentos do meu APP
    return File('${directory.path}/data.json'); // data.json é o nome que darei para o arquivo
  }

  // Função para salvar algum dado no arquivo
  Future<File> _saveData() async {
    String data = json.encode(_toDoList);

    final file = await _getFile();
    return file.writeAsString(data);
  }

  // Função para ler os dados do arquivo
  Future<String> _readData() async {
    try {
      final file = await _getFile();

      return file.readAsString();
    } catch (e) {
      return null;
    }
  }
}