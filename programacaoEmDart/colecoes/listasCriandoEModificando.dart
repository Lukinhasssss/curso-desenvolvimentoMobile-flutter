class Pessoa {
  String nome;
  int idade;

  Pessoa(this.nome, this.idade);
}

void main() {
  List<String> nomes = ['Lucas', 'Fernanda', 'Karina'];

  print(nomes[0]);
  nomes.add('Marcia');
  print(nomes);

  print(nomes.length);

  nomes.removeAt(2);
  print(nomes);

  nomes.insert(1, 'Karina');
  print(nomes);

  print(nomes.contains('João'));

  print('-----------------------------------------------');

  List<Pessoa> pessoas = List(); // List() --> Declara uma lista vazia

  pessoas.add(Pessoa('Marcelo', 30));
  pessoas.add(Pessoa('Carlos', 20));

  for(Pessoa pessoa in pessoas) {
    print(pessoa.nome);
  }
}