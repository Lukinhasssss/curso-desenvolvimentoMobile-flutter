void main() {
  // criarBotao('BotaoSair', cor: 'Ciano', largura: 15);
  // criarBotao('BotaoSair', botaoCriado);

  criarBotao('BotaoCamera', () {
    print('Botão criado por função anônima');
  });
}

void botaoCriado() {
  print('Botão criado !!!');
}

void criarBotao(String texto, Function criadoFunc,
    {String cor, double largura}) {
  // Desta forma os parâmetros que estão entre chaves são opcionais e o único obrigatório é o texto
  print(texto);
  print(cor ??
      'Preto'); // caso não seja inserida a cor ela recebe 'Preto' por padrão
  print(largura ?? 10.0);
  criadoFunc();
}
