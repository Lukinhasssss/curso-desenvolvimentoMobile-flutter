import 'package:flutter/material.dart';
import 'package:loja_virtual/models/user_model.dart';
import 'package:scoped_model/scoped_model.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  final _addessController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Criar Conta'),
          centerTitle: true,
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
                          controller: _nameController,
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
                          controller: _emailController,
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
                          controller: _passController,
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
                          controller: _addessController,
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
                                // FocusScopeNode currentFocus = FocusScope.of(context);
                                // if (!currentFocus.hasPrimaryFocus) { currentFocus.unfocus(); }

                                if (_formKey.currentState.validate()) {
                                  Map<String, dynamic> userData = {
                                    "name": _nameController.text,
                                    "email": _emailController.text,
                                    "Address": _addessController.text
                                  };

                                  model.signUp(
                                      userData: userData,
                                      pass: _passController.text,
                                      onSuccess: _onSuccess,
                                      onFail: _onFail
                                  );
                                }
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

  void _onSuccess() {}

  void _onFail() {}
}