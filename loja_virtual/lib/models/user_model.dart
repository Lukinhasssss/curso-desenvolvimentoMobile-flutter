import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class UserModel extends Model {

  FirebaseAuth _auth = FirebaseAuth.instance; // Obs: FirebaseAuth é um Singleton, então só tem uma instância no app inteiro

  FirebaseUser firebaseUser;
  Map<String, dynamic> userData = Map(); // Aqui é onde terá os dados mais importantes do usuário

  bool isLoading = false;

  void signUp({@required Map<String, dynamic> userData, @required String pass, @required VoidCallback onSuccess, @required VoidCallback onFail}) {
    isLoading = true;
    notifyListeners();
    
    _auth.createUserWithEmailAndPassword(
        email: userData["email"],
        password: pass
    ).then((auth) async {
      firebaseUser = auth.user;

      await _saveUserData(userData);

      onSuccess();
      isLoading = false;
      notifyListeners();
    }).catchError((e) {
      onFail();
      isLoading = false;
      notifyListeners();
    });
  }

  void signIn() async {
    isLoading = true;
    notifyListeners();

    await Future.delayed(Duration(seconds: 3));

    isLoading = false;
    notifyListeners();
  }

  void recoverPass() {}

  Future<Null> _saveUserData(Map<String, dynamic> userData) async {
    this.userData = userData;
    await Firestore.instance.collection("users").document(firebaseUser.uid).setData(userData);
  }

}

/*
    O que é um model ???

      Model é um objeto que guarda estados de alguma coisa (neste caso será o estado do login deste app), então
    aqui ele irá armazenar o usuário atual e irá também ter todas as funções que irão modificar o usuário atual,
    ou seja, o estado e as funções que irão modificar este estado.
 */