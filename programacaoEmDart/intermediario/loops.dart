void main() {
  /* for */
  for (int i = 1; i <= 10; i++) {
    for (int j = 1; j <= 10; j++) {
      print('$i x $j = ${i * j}');
    }
  }

  print('-----------------------------');

  /* while */
  int k = 1;
  while (k <= 10) {
    print(k);
    k++;
  }

  print('-----------------------------');

  /* do while --> Executa o código pelo menos uma vez mesmo se a condição não for válida */
  int l = 1;
  do {
    print(l);
    l++;
  } while (l <= 10);
}
