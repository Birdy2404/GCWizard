import "package:flutter_test/flutter_test.dart";
import 'package:gc_wizard/logic/tools/science_and_technology/dtmf.dart';

void main() {
  group("DTMF.encodeDTMF:", () {
    List<Map<String, dynamic>> _inputsToExpected = [
      {'input' : '', 'expectedOutput' : ''},
      {'input' : 'A', 'expectedOutput' : '[697, 1633]'},
      {'input' : 's', 'expectedOutput' : ''},
      {'input' : '27', 'expectedOutput' : '[697, 1336]   [852, 1209]'},
      {'input' : '2h6', 'expectedOutput' : '[697, 1336]   [770, 1477]'},
    ];

    _inputsToExpected.forEach((elem) {
      test('input: ${elem['input']}', () {
        var _actual = encodeDTMF(elem['input']);
        expect(_actual, elem['expectedOutput']);
      });
    });
  });

  group("DTMF.decodeDTMF:", () {
    List<Map<String, dynamic>> _inputsToExpected = [
      {'expectedOutput' : '', 'input' : ''},
      {'expectedOutput' : 'A', 'input' : '[697, 1633]'},
      {'expectedOutput' : 'A', 'input' : '(697.1633)'},
      {'expectedOutput' : 'A', 'input' : '697 1633 '},
      {'expectedOutput' : 'A', 'input' : '697.1633.'},
      {'expectedOutput' : '27', 'input' : '697 1336 1209 852 '},
      {'expectedOutput' : '274', 'input' : '697 1336 1209 852 fghi 770 1209 '},
    ];

    _inputsToExpected.forEach((elem) {
      test('input: ${elem['input']}', () {
        var _actual = decodeDTMF(elem['input']);
        expect(_actual, elem['expectedOutput']);
      });
    });
  });
}