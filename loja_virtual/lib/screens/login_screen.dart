import 'package:flutter/material.dart';
import 'package:loja_virtual/models/user_model.dart';
import 'package:loja_virtual/screens/signup_screen.dart';
import 'package:scoped_model/scoped_model.dart';

class LoginScreen extends StatelessWidget {

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Entrar'),
        centerTitle: true,
        actions: <Widget>[
          FlatButton(
            child: Text('CRIAR CONTA', style: TextStyle(fontSize: 15.0)),
            textColor: Colors.white,
            onPressed: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => SignupScreen()));
            }
          )
        ]
      ),
      body: ScopedModelDescendant<UserModel>(
        builder: (context, child, model) {
          if (model.isLoading)
            return Center(child: CircularProgressIndicator());

          return Form(
              key: _formKey,
              child: ListView(
                padding: EdgeInsets.all(16.0),
                children: <Widget>[
                  TextFormField(
                      decoration: InputDecoration(
                          hintText: 'E-mail'
                      ),
                      keyboardType: TextInputType.emailAddress,
                      validator: (text) {
                        if (text.isEmpty || !text.contains('@')) return 'E-mail inválido!';
                      }
                  ),
                  SizedBox(height: 16.0),
                  TextFormField(
                      decoration: InputDecoration(
                          hintText: 'Senha'
                      ),
                      obscureText: true, // Para que o usuário não consiga ver a senha que está sendo digitada,
                      validator: (text) {
                        if (text.isEmpty || text.length < 8) return 'Senha inválida! A senha precisa ter pelo menos 8 caracteres!';
                      }
                  ),
                  Align(
                      alignment: Alignment.centerRight,
                      child: FlatButton(
                          onPressed: () {
                            print('Esqueci minha senha');
                          },
                          child: Text('Esqueci minha senha',
                            textAlign: TextAlign.right,
                            style: TextStyle(fontWeight: FontWeight.w400, color: Colors.grey[850]),
                          ),
                          padding: EdgeInsets.zero
                      )
                  ),
                  SizedBox(height: 16.0),
                  SizedBox(
                      height: 44.0,
                      child: RaisedButton(
                          child: Text('Entrar',
                              style: TextStyle(fontSize: 18.0)
                          ),
                          color: Theme.of(context).primaryColor,
                          textColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4.0),
                              side: BorderSide(color: Colors.teal[800])
                          ),
                          onPressed: () {
                            if (_formKey.currentState.validate()) {

                            }
                            model.signIn();
                          }
                      )
                  )
                ],
              )
          );
        }
      )
    );
  }
}
