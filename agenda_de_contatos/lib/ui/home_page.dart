import 'package:flutter/material.dart';

import 'dart:io';
import 'package:url_launcher/url_launcher.dart';

import 'package:agenda_de_contatos/helpers/contact_helper.dart';
import 'package:agenda_de_contatos/ui/contact_page.dart';

enum OrderOptions { orderaz, orderza } // enum é um conjunto de constantes

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  // Obtendo o contact_helper
  ContactHelper helper = ContactHelper();

  // Criando a lista de contatos
  List<Contact> contacts = List();

  // Carregando todos os contatos salvos na inicialização do App
  @override
  void initState() {
    super.initState();

    _getAllContacts();
  }

  /*
  @override
  void initState() {
    super.initState();

    Contact c = Contact();
    c.name = 'Lukas';
    c.email = 'lukas@email.com';
    c.phone = '987654321';
    c.img = 'imgtest';

    helper.saveContact(c);

    // helper.getAllContacts().then((list) {
    //   print(list);
    // });

  }
  */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contatos'),
        backgroundColor: Colors.red,
        centerTitle: true,
        actions: <Widget>[
          PopupMenuButton<OrderOptions>(
            itemBuilder: (context) => <PopupMenuEntry<OrderOptions>>[
              const PopupMenuItem<OrderOptions>(
                child: Text('Ordenar de A-Z'),
                value: OrderOptions.orderaz
              ),
              const PopupMenuItem<OrderOptions>(
                child: Text('Ordenar de Z-A'),
                value: OrderOptions.orderza
              )
            ],
            onSelected: _orderList
          )
        ],
      ),
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton( // Botão flutuante para add contatos
        onPressed: () {
          _showContactPage();
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.red
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(10.0),
        itemCount: contacts.length,
        itemBuilder: (context, index) {
          return _contactCard(context, index);
        }
      )
    );
  }

  Widget _contactCard(BuildContext context, int index) {
    return GestureDetector(
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Row(
            children: <Widget>[
              Container(
                width: 80.0,
                height: 80.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: contacts[index].img != null ?
                      FileImage(File(contacts[index].img)) :
                        AssetImage('images/person.png'),
                        fit: BoxFit.cover
                  )
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(contacts[index].name ?? '',
                      style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold)
                    ),
                    Text(contacts[index].email ?? '',
                      style: TextStyle(fontSize: 18.0)
                    ),
                    Text(contacts[index].phone ?? '',
                      style: TextStyle(fontSize: 18.0)
                    )
                  ]
                ),
              )
            ]
          ),
        ),
      ),
      onTap: () {
        _showOptions(context, index);
      }
    );
  }

  void _showOptions(BuildContext context, int index) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return BottomSheet(
          builder: (context) {
            return Container(
              padding: EdgeInsets.all(10.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: FlatButton(
                      child: Text('Ligar', style: TextStyle(color: Colors.red, fontSize: 20.0)),
                      onPressed: () {
                        launch('tel:${contacts[index].phone}'); // Para abrir o app de telefone e ligar
                        Navigator.pop(context); // Para fechar a janelinha de opções
                      }
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: FlatButton(
                      child: Text('Editar', style: TextStyle(color: Colors.red, fontSize: 20.0)),
                      onPressed: () {
                        Navigator.pop(context); // Vai fechar a janelinha de opções e ir para a próxima tela
                        _showContactPage(contact: contacts[index]);
                      }
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: FlatButton(
                      child: Text('Excluir', style: TextStyle(color: Colors.red, fontSize: 20.0)),
                      onPressed: () {
                        helper.deleteContact(contacts[index].id);
                        setState(() {
                          contacts.removeAt(index); // Para remover o contato da lista de contatos
                          Navigator.pop(context); // Para fechar a janelinha de opções
                        });
                      }
                    ),
                  )
                ]
              )
            );
          },
          onClosing: () {},
        );
      }
    );
  }

  void _showContactPage({Contact contact}) async {
    final receiveContact = await Navigator.push(context,
      MaterialPageRoute(builder: (context) => ContactPage(contact: contact))
    );
    if (receiveContact != null) {
      if (contact != null) {
        await helper.updateContact(receiveContact);
      } else {
        await helper.saveContact(receiveContact);
      }
      _getAllContacts();  // Para carregar todos os contatos novamente
    }
  }

  void _getAllContacts() {
    helper.getAllContacts().then((list) {
      setState(() {
        contacts = list;
      });
    });
  }

  void _orderList(OrderOptions result) {
    switch (result) {
      case OrderOptions.orderaz:
        contacts.sort((a, b) {
          return a.name.toLowerCase().compareTo(b.name.toLowerCase());
        });
        break;
      case OrderOptions.orderza:
        contacts.sort((a, b) {
          return b.name.toLowerCase().compareTo(a.name.toLowerCase());
        });
        break;
    }
    setState(() {});
  }

}
