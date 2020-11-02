import 'package:flutter/material.dart';
import 'dart:io'; // Importa o File
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:chat_online/text_composer.dart';
import 'package:chat_online/chat_message.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

  // Criando sistema de login
  final GoogleSignIn googleSignIn = GoogleSignIn(); // Para fazer login com o google
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  FirebaseUser _currentUser; // Quando logar o _currentUser vai conter o usuário atual e quando deslogar o _currentUser vai ser nulo
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();

    FirebaseAuth.instance.onAuthStateChanged.listen((user) { // Sempre que a autenticação mudar vai chamar essa função anônima com o usuário atual
      setState(() {
        _currentUser = user;
      });
    });
  }

  Future<FirebaseUser> _getUser() async {
    if (_currentUser != null) { // Se o usuário atual for nulo irá fazer o login
      return _currentUser;
    }

    try {
      final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn(); // Retorna a conta da pessoa que fez o Login. E através dessa conta é possível pegar nome, email, foto, etc...

      // Transformando o login do google em um login no firebase
      final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;

      // Fazendo a conexão com o firebase
      final AuthCredential credential = GoogleAuthProvider.getCredential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken
      );
      
      // Fazendo o Login
      final AuthResult authResult = await FirebaseAuth.instance.signInWithCredential(credential);
      final FirebaseUser user = authResult.user;

      return user;

    } catch (error) {
      return null;
    }
  }

  void _sendMessage({String text, File imgFile}) async { // Função que será chamada sempre que clicar em um dos botões de enviar e essa função vai receber o texto que eu digitar

    // Obtendo o usuário atual
    final FirebaseUser user = await _getUser();

    if (user == null) {
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text('Não foi possível fazer o login. Tente novamente!'),
          backgroundColor: Colors.redAccent
        )
      );
    }

    Map<String, dynamic> data = {
      'uid': user.uid,
      'senderName': user.displayName,
      'senderPhotoUrl': user.photoUrl,
      'time': Timestamp.now() // Campo para ordenar as mensagens utilizando a hora atual que elas foram enviadas
    };

    if (text != null) {
      data['text'] = text;
    }

    // Fazendo o upload da imagem para o firebase
    if (imgFile != null) {
      StorageUploadTask task = FirebaseStorage.instance.ref().child(
        // Definindo o nome do meu arquivo
        user.uid + DateTime.now().millisecondsSinceEpoch.toString()
      ).putFile(imgFile);

      setState(() {
        _isLoading = true;
      });

      StorageTaskSnapshot taskSnapshot =  await task.onComplete; // Vai retornar várias imformações da minha task que foi concluída e uma delas é a url de download da minha imagem
      String url = await taskSnapshot.ref.getDownloadURL();
      data['imgUrl'] = url;

      setState(() {
        _isLoading = false;
      });
    }

    // Adicionando os dados no firebase
    Firestore.instance.collection('messages').add(data); // Já cria um documento e adiciona os dados dentro

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(
          _currentUser != null ? 'Olá, ${_currentUser.displayName}' : 'Chat App'
        ),
        centerTitle: true,
        elevation: 0,
        actions: <Widget>[
          _currentUser != null ? IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              FirebaseAuth.instance.signOut(); // Para sair do Firebase (Logout)
              googleSignIn.signOut(); // Para sair do Google (Logout)
              _scaffoldKey.currentState.showSnackBar(
                SnackBar(
                  content: Text('Você saiu com sucesso!')
                )
              );
            },
          ) : Container()
        ],
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: StreamBuilder<QuerySnapshot>( // Sempre que alguma coisa mudar na minha coleção vai refazer o StreamBuilder recriando a minha lista
              stream: Firestore.instance.collection('messages').orderBy('time').snapshots(), // Sempre que tiver alguma modificação na coleção 'messages' vai acionar o stream e refazer tudo o que estiver dentro do meu builder
              builder: (context, snapshot) {
                switch(snapshot.connectionState) {
                  case ConnectionState.none:
                  case ConnectionState.waiting:
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  default:
                    List<DocumentSnapshot> documents = snapshot.data.documents.reversed.toList(); // Para inverter a lista de documentos

                    return ListView.builder(
                      itemCount: documents.length,
                      reverse: true, // reverse --> Para as mensagens aparecerem de baixo para cima
                      itemBuilder: (context, index) {
                        return ChatMessage(
                          documents[index].data,
                          documents[index].data['uid'] == _currentUser?.uid
                        );
                      }
                    );
                }
              }
            )
          ),
          _isLoading ? LinearProgressIndicator() : Container(),
          TextComposer(_sendMessage),
        ],
      ),
    );
  }
}
