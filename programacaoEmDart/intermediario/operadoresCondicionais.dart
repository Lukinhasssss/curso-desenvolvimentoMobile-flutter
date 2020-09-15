void main() {
  double nota = 10.0;

  if (nota < 5.0) {
    print('Exame! :(');
  } else if (nota == 10.0) {
    print('Sucesso total!');
  } else if (nota == 9.9) {
    print('Quase sucesso total');
  } else {
    print('Sucesso! :)');
  }

  bool aprovado = true;
  String info;

  /*
  if (aprovado) {
    info = 'Aprovado!!!';
  } else {
    info = 'Reprovado!!!';
  }
  */

  info = aprovado ? 'Aprovado!!!' : 'Reprovado!!!';
  print(info);

  String nome;
  String info2 = nome ??
      "Não informado!"; /* Caso a variável nome não esteja setada ela vai receber "Não informado como valor padrão" */
  print(info2);

  print("Fim!");
}
