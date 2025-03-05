import 'dart:math';

void main() {
  print('Hello, Dart!');
  
  int a = 10;
  int b = 20;
  print('Sum: \${add(a, b)}');
  
  List<int> numbers = List.generate(5, (index) => Random().nextInt(100));
  print('Random numbers: \$numbers');
  
  numbers.sort();
  print('Sorted numbers: \$numbers');
}

int add(int x, int y) {
  return x + y;
}
