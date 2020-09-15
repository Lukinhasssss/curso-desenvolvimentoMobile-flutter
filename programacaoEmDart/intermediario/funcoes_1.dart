void main() {
  saudacao();

  calcSoma(10.0, 17.2);

  double resultMult = calcMult(2.3, 7.8);
  print(resultMult);

  print(calcAreaCirculo(5));
}

/* Definindo uma função */
void saudacao() {
  print('Seja bem-vindo(a)!');
}

void calcSoma(double n1, double n2) {
  double result = n1 + n2;
  print(result);
}

double calcMult(double n1, double n2) {
  double result = n1 * n2;
  return result;
}

double calcAreaCirculo(double raio) => 3.14 * (raio * raio);
