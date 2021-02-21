import 'package:scoped_model/scoped_model.dart';

class UserModel extends Model {

  bool isLoading = false;

  void signUp() {}

  void signIn() async {
    isLoading = true;
    notifyListeners();

    await Future.delayed(Duration(seconds: 3));

    isLoading = false;
    notifyListeners();
  }

  void recoverPass() {}

}

/*
    O que é um model ???

      Model é um objeto que guarda estados de alguma coisa (neste caso será o estado do login deste app), então
    aqui ele irá armazenar o usuário atual e irá também ter todas as funções que irão modificar o usuário atual,
    ou seja, o estado e as funções que irão modificar este estado.
 */