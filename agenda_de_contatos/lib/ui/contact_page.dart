import 'package:flutter/material.dart';
import 'dart:io';

import 'package:agenda_de_contatos/helpers/contact_helper.dart';
import 'package:image_picker/image_picker.dart';

class ContactPage extends StatefulWidget {

  final Contact contact;

  ContactPage({this.contact}); // Esse constructor vai servir para eu passar o contato que eu quero editar nessa página. As {} servem para deixar o parâmetro como opcional

  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();

  final _nameFocus = FocusNode();

  bool _userEdited = false;

  Contact _editedContact;

  @override
  void initState() {
    super.initState();

    if (widget.contact == null) {
      _editedContact = Contact();
    } else {
      _editedContact = Contact.fromMap(widget.contact.toMap());

      _nameController.text = _editedContact.name;
      _emailController.text = _editedContact.email;
      _phoneController.text = _editedContact.phone;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _requestPop,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          title: Text(_editedContact.name ?? 'Novo Contato'),
          centerTitle: true
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            if (_editedContact.name != null && _editedContact.name.isNotEmpty) {
              Navigator.pop(context, _editedContact); // Vai remover minha tela e voltar para a anterior. Navigator funciona no esquema de "pilha"
            } else {
              FocusScope.of(context).requestFocus(_nameFocus); // Caso eu tente salvar sem o nome, ao invés de salvar irá alterar o foco para o input do nome
            }
          },
          child: Icon(Icons.save),
          backgroundColor: Colors.red
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              GestureDetector(
                child: Container(
                  width: 140.0,
                  height: 140.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: _editedContact.img != null ?
                      FileImage(File(_editedContact.img)) :
                        AssetImage('images/person.png'),
                        fit: BoxFit.cover
                    )
                  ),
                ),
                onTap: () {
                  ImagePicker.pickImage(source: ImageSource.gallery).then((file) {
                    if (file == null) return; // Significa que o usuário abriu a câmera mas fechou sem tirar uma foto
                    setState(() {
                      _editedContact.img = file.path;
                    });
                  });
                }
              ),
              TextField(
                controller: _nameController,
                focusNode: _nameFocus,
                decoration: InputDecoration(labelText: 'Nome'),
                onChanged: (text) {
                  _userEdited = true;
                  setState(() {
                    _editedContact.name = text;
                  });
                }
              ),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
                onChanged: (text) {
                  _userEdited = true;
                  _editedContact.email = text;
                }
              ),
              TextField(
                controller: _phoneController,
                decoration: InputDecoration(labelText: 'Telefone'),
                keyboardType: TextInputType.phone,
                onChanged: (text) {
                  _userEdited = true;
                  _editedContact.phone = text;
                }
              ),
            ]
          ),
        ),
      ),
    );
  }

  Future<bool> _requestPop() {
    if (_userEdited) { // Se o usuário editou algum campo...
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Descartar Alterações?'),
            content: Text('Se sair as alterações serão perdidas.'),
            actions: <Widget>[
              FlatButton(
                child: Text('Cancelar'),
                onPressed: () {
                  Navigator.pop(context); // Para remover o diálogo
                }
              ),
              FlatButton(
                child: Text('Sim'),
                onPressed: () {
                  Navigator.pop(context); // Para remover o diálogo e continuar na contact_page
                  Navigator.pop(context); // Para remover a contact_page e retornar para a home_page
                }
              )
            ],
          );
        }
      );
      return Future.value(false); // Para não deixar o usuário sair automaticamente da tela
    } else {
      return Future.value(true); // Para deixar o usuário sair da tela
    }
  }

}
