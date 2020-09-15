class Pessoa {
  String name;
  int age;
  double height;

  /*
   *  Declarando um constructor
  Pessoa(String name, int age, double height) {
    this.name = name;
    this.age = age;
    this.height = height;
  }
  */

  Pessoa(this.name, this.age, this.height); // Este também é um construtor

  Pessoa.nascer(this.name, this.height) { // Esta é mais uma forma de declarar um constructor, é chamado de Named Constructor
    age = 0;
    print('$name nasceu!');
    sleep();
  }

  void sleep() {
    print('$name está dormindo!');
  }

  void birthday() {
    age++;
  }
}

void main() {
  Pessoa pessoa1 = Pessoa('Lucas', 22, 1.75);

  Pessoa pessoa2 = Pessoa('Oliver', 18, 1.72);

  print(pessoa1.name);
  print(pessoa2.name);

  print(pessoa1.age);
  pessoa1.birthday();
  print(pessoa1.age);

  pessoa2.sleep();

  Pessoa nene = Pessoa.nascer('Atreus', 0.30);
  print(nene.name);
  print(nene.age);
}
