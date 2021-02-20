import 'package:flutter/material.dart';

class SignupScreen extends StatelessWidget {

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text('Criar Conta'),
            centerTitle: true,
        ),
        body: Form(
            key: _formKey,
            child: ListView(
              padding: EdgeInsets.all(16.0),
              children: <Widget>[
                TextFormField(
                    decoration: InputDecoration(
                        hintText: 'Nome Completo'
                    ),
                    keyboardType: TextInputType.name,
                    validator: (text) {
                      if (text.isEmpty) return 'Nome inválido!';
                    }
                ),
                SizedBox(height: 16.0),
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
                SizedBox(height: 16.0),
                TextFormField(
                    decoration: InputDecoration(
                        hintText: 'Endereço'
                    ),
                    keyboardType: TextInputType.streetAddress,
                    validator: (text) {
                      if (text.isEmpty) return 'Endereço inválido';
                    }
                ),
                SizedBox(height: 16.0),
                SizedBox(
                    height: 44.0,
                    child: RaisedButton(
                        child: Text('Criar Conta',
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
                        }
                    )
                )
              ],
            )
        )
    );
  }
}
