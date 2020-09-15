class Pessoa {
  String name;
  int age;
  double height;

  void sleep() {
    print('$name está dormindo!');
  }

  void birthday() {
    age++;
  }
}

void main() {
  // Pessoa pessoa1 = new Pessoa();
  Pessoa pessoa1 = Pessoa();
  pessoa1.name = 'Lucas';
  pessoa1.age = 22;
  pessoa1.height = 1.75;

  Pessoa pessoa2 = Pessoa();
  pessoa2.name = 'Oliver';
  pessoa2.age = 18;
  pessoa2.height = 1.72;

  print(pessoa1.name);
  print(pessoa2.name);

  print(pessoa1.age);
  pessoa1.birthday();
  print(pessoa1.age);

  pessoa2.sleep();
}
