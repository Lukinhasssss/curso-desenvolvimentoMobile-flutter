class InfoPessoa {
  int idade;
  InfoPessoa(this.idade);
}

void main() {
  // Chave    Valor
  // Nome     Lucas
  // Cidade   Diadema

  Map<int, String> ddds = Map();
  ddds[11] = 'São Paulo';
  ddds[19] = 'Campinas';
  ddds[21] = 'Rio de Janeiro';
  print(ddds.keys);
  print(ddds.values);
  ddds.remove(21);
  print(ddds);

  print('-----------------------------------------------');

  Map<String, dynamic> pessoa = Map();
  pessoa['nome'] = 'Lucas';
  pessoa['idade'] = 22;
  pessoa['altura'] = 1.75;
  print(pessoa);
  print(pessoa.keys);
  print(pessoa.values);

  print('-----------------------------------------------');

  Map<String, InfoPessoa> pessoas = Map();
  pessoas['Guilherme'] = InfoPessoa(30);
  pessoas['Marcia'] = InfoPessoa(32);

}