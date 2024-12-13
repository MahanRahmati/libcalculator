import 'package:libcalculator/libcalculator.dart';

void main() {
  final Calculator calculator = Calculator();

  // Basic operations
  print('2 + 3 * 4 = ${calculator.calculate('2+3*4')}');
  print('10 / 2 + 3 = ${calculator.calculate('10/2+3')}');
  print('5 * 2 - 3 = ${calculator.calculate('5*2-3')}');

  // Parentheses examples
  print('(2 + 3) * 4 = ${calculator.calculate('(2+3)*4')}');
  print('2 * (3 + 4) = ${calculator.calculate('2*(3+4)')}');
  print('((1 + 2) * 3) + 4 = ${calculator.calculate('((1+2)*3)+4')}');

  // Decimal operations
  print('3.5 + 2.1 = ${calculator.calculate('3.5+2.1')}');
  print('(2.5 + 1.5) * 2 = ${calculator.calculate('(2.5+1.5)*2')}');
}
