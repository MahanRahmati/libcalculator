import 'package:libcalculator/libcalculator.dart';
import 'package:test/test.dart';

void main() {
  group('Calculator', () {
    final Calculator calculator = Calculator();

    test('Basic operations', () {
      expect(calculator.calculate('2+2'), '4');
      expect(calculator.calculate('3-1'), '2');
      expect(calculator.calculate('4*5'), '20');
      expect(calculator.calculate('8/2'), '4');
    });

    test('Decimal operations', () {
      expect(calculator.calculate('3/2'), '1.5');
      expect(calculator.calculate('5/2'), '2.5');
      expect(calculator.calculate('1/4'), '0.25');
      expect(calculator.calculate('7/2'), '3.5');
    });

    test('Operator precedence', () {
      expect(calculator.calculate('2+3*4'), '14');
      expect(calculator.calculate('10/2+3'), '8');
      expect(calculator.calculate('5*2-3'), '7');
      expect(calculator.calculate('6+8/4'), '8');
    });

    test('Multiple operations', () {
      expect(calculator.calculate('2+3+4'), '9');
      expect(calculator.calculate('10-5-2'), '3');
      expect(calculator.calculate('2*3*4'), '24');
      expect(calculator.calculate('24/2/3'), '4');
    });

    test('Mixed operations with decimals', () {
      expect(calculator.calculate('2+3*4-6/2'), '11');
      expect(calculator.calculate('10/2+3*4-5'), '12');
      expect(calculator.calculate('5/2*3'), '7.5');
      expect(calculator.calculate('3*5/2'), '7.5');
    });

    test('Empty string', () {
      expect(calculator.calculate(''), '');
    });

    test('Error handling', () {
      expect(calculator.calculate('5/0'), startsWith('Error:'));
      expect(calculator.calculate('2+a'), startsWith('Error:'));
      expect(calculator.calculate('2++3'), startsWith('Error:'));
    });

    test('Decimal number operations', () {
      expect(calculator.calculate('3.5+1.5'), '5');
      expect(calculator.calculate('2.5*2'), '5');
      expect(calculator.calculate('10.5-3.2'), '7.3');
      expect(calculator.calculate('15.5/5'), '3.1');
      expect(calculator.calculate('0.1+0.2'), '0.3');
      expect(calculator.calculate('1.5*1.5'), '2.25');
    });

    test('Parentheses operations', () {
      expect(calculator.calculate('(2+3)*4'), '20');
      expect(calculator.calculate('2*(3+4)'), '14');
      expect(calculator.calculate('(1+2)*(3+4)'), '21');
      expect(calculator.calculate('((1+2)*3)+4'), '13');
    });

    test('Nested parentheses with decimals', () {
      expect(calculator.calculate('(2.5+1.5)*(3+1)'), '16');
      expect(calculator.calculate('2*((3+1)/2)'), '4');
    });

    test('Invalid parentheses', () {
      expect(calculator.calculate('(2+3'), startsWith('Error:'));
      expect(calculator.calculate('2+3)'), startsWith('Error:'));
      expect(calculator.calculate('((2+3)'), startsWith('Error:'));
    });
  });
}
