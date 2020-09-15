void main() {
  // Comparadores
  // ----------------------
  // >    maior
  // >=   maior ou igual
  // <    menor
  // <=   menor ou igual
  // ==   igual
  // !=   diferente

  bool testeComp = (10 > 20);
  print("COMP: $testeComp");

  // Operador OR (OU)
  // ----------------------
  // true    true  -> true
  // true    false -> true
  // false   true  -> true
  // false   false -> false

  bool testeOr = (false || true);
  print("OR: $testeOr");

  // Operador AND (E)
  // ----------------------
  // true    true  -> true
  // true    false -> false
  // false   true  -> false
  // false   false -> false

  // ignore: dead_code
  bool testeAnd = (false && true);
  print("AND: $testeAnd");

  bool complexa = (10 > 20) && ((30 < 20) || testeAnd);
  print(complexa);

  // Operador NOT (NÃO/NEGAÇÃO)
  print(!false);
}
