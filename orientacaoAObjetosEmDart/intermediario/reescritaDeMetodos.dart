class Animal {
  String nome;
  double peso;

  Animal(this.nome, this.peso);

  void comer() {
    print('$nome comeu!');
  }

  void fazerSom() {
    print('$nome fez algum som!');
  }
}


class Cachorro extends Animal {
  int fofura;

  Cachorro(String nome, double peso, this.fofura) : super(nome, peso);

  void brincar() {
    fofura += 10;
    print('Fofura do $nome aumentou para $fofura!!!');
  }

  @override
  void fazerSom() {
    print('${nome} fez au au!');
  }

  @override
  String toString() {
    return 'Cachorro | Nome: ${nome}, Peso: ${peso}, Fofura: ${fofura}';
  }
}

class Gato extends Animal {
  Gato(String nome, double peso) : super(nome, peso);

  bool estaAmigavel() {
    return true;
  }

  @override
  void fazerSom() {
    print('${nome} fez miau!');
  }
}

void main() {
  Cachorro cachorro = Cachorro('Akamaru', 10.0, 100);
  cachorro.fazerSom();
  cachorro.comer();
  cachorro.brincar();
  print(cachorro); // Com a reescrita do toString

  print('-----------------------------------------------');

  Gato gato = Gato('Bills', 57.0);
  gato.fazerSom();
  gato.comer();
  print('${gato.nome} está amigável? ${gato.estaAmigavel()}');
  print(gato); // Sem a reescrita do toString
}

// OBS: O print CHAMA O toString DIRETAMENTE QUANDO PASSAMOS UM OBJETO