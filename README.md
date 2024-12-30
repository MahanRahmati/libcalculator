# LibCalculator

A mathematical expression evaluator for Dart that handles arithmetic operations with proper precedence rules.

## Features

- Evaluates mathematical expressions with support for:
  - Basic arithmetic operations (+, -, \*, /)
  - Parentheses for expression grouping
  - Decimal numbers
  - Proper operator precedence
- Clean error handling for invalid expressions
- Automatic result formatting (integers or decimals)
- Precise calculations with rounding to 10 decimal places

## Getting started

Add this package to your project's dependencies:

```yaml
dependencies:
  libcalculator: ^1.2.0
```

Then run:

```bash
dart pub get
```

## Usage

Simple usage example:

```dart
import 'package:libcalculator/libcalculator.dart';

void main() {
  final calculator = Calculator();

  // Basic arithmetic
  print(calculator.calculate('2 + 3'));  // Output: 5

  // Expression with parentheses
  print(calculator.calculate('2 * (3 + 4)'));  // Output: 14

  // Decimal numbers
  print(calculator.calculate('10 / 3'));  // Output: 3.3333333333

  // Complex expressions
  print(calculator.calculate('(2.5 + 3.5) * (4 - 1) / 2'));  // Output: 9
}
```
