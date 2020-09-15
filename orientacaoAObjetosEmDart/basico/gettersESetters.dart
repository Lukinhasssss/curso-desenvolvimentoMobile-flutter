class Pessoa {
  String nome;
  int _idade; // O _ (underline) significa que o atributo idade só vai poder ser acessado de dentro do objeto
  double _altura;

  /*
   *  Declarando um constructor
  Pessoa(String nome, int idade, double altura) {
    this.nome = nome;
    this.idade = idade;
    this.altura = altura;
  }
  */

  Pessoa(this.nome, this._idade, this._altura); // Este também é um construtor

  Pessoa.nascer(this.nome, this._altura) { // Esta é mais uma forma de declarar um constructor, é chamado de nomed Constructor
    _idade = 0;
    print('$nome nasceu!');
    dormir();
  }

  void dormir() {
    print('$nome está dormindo!');
  }

  void aniversario() {
    _idade++;
  }

  /* Declarando um getter --> Obs: getter é uma proteção de escrita!!! */
  // int get idade {
  //   return _idade;
  // }
  int get idade => _idade;

  // double get altura {
  //   return _altura;
  // }
  double get altura => _altura;

  /* Declarando um setter */
  set altura(double altura) {
    if (altura > 0.0 && altura < 0.3) {
      _altura = altura;
    }
  }
}

void main() {
  Pessoa pessoa1 = Pessoa('Lucas', 22, 1.75);

  Pessoa pessoa2 = Pessoa('Oliver', 18, 1.72);

  print(pessoa1.nome);
  print(pessoa2.nome);

  print(pessoa1.idade);
  pessoa1.aniversario();
  print(pessoa1.idade);

  pessoa2.dormir();

  Pessoa nene = Pessoa.nascer('Atreus', 0.30);
  print(nene.nome);
  print(nene.idade);

  // nene.altura = 2.0;
  nene.altura = 3.2;
  print(nene.altura);
}
