class CalculatorError implements Exception {
  CalculatorError(this.message);

  final String message;

  @override
  String toString() => message;
}
