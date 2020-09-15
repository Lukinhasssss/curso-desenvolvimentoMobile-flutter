class Valores {
  static int vezesClicado; // Dessa forma está variável não será mais do objeto e sim uma variável da classe e não será mais necessário instânciar um objeto para acessar essa variável
}

class Pessoa {

}

void main() {
  Valores.vezesClicado = 2;

  const numero = 3;
  print(numero);

  // ignore: unused_local_variable
  final Pessoa pessoa = Pessoa(); // Desta forma não poderei colocar outro objeto dentro de 'pessoa'
}