/// A calculator library that provides mathematical expression evaluation.
///
/// This library implements a complete expression parser and evaluator that
/// supports:
/// - Basic arithmetic operations (+, -, *, /)
/// - Parentheses for grouping expressions
/// - Decimal numbers
/// - Error handling for invalid expressions
///
/// Example usage:
/// ```dart
/// import 'package:libcalculator/libcalculator.dart';
///
/// void main() {
///   final calculator = Calculator();
///   final result = calculator.calculate('2 * (3 + 4)');
///   print(result); // 14
/// }
/// ```
library;

export 'src/calculator.dart';
