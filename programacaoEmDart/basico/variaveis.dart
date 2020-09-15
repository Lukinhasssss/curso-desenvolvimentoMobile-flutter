void main() {
  String nome = 'Lojinha do Lucas';
  int laranjas = 5;
  double preco = 10.50;
  bool aindaTem = true;

  print("O nome da lojinha é: $nome");
  print("A $nome tem $laranjas laranjas");
  print(preco);
  print(aindaTem);

  print('-------------------------');

  dynamic teste = 1;
  print(teste);
  teste = 'Um';
  print(teste);
}
