class ExampleClass {
  int value = 2;

  void incrementAndPrint(int k) {
    value = value * k;

    print('Incremented Value: $value');
  }
}

void main() {
  // Create an instance of ExampleClass
  ExampleClass instance = ExampleClass();

  // Increment and print values
  instance.incrementAndPrint(1); // Incremented Value: 1
  instance.incrementAndPrint(2); // Incremented Value: 2
  instance.incrementAndPrint(3); // Incremented Value: 3
}
