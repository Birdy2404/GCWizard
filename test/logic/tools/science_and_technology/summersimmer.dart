import "package:flutter_test/flutter_test.dart";
import 'package:gc_wizard/logic/tools/science_and_technology/summersimmer.dart';
import 'package:gc_wizard/logic/units/temperature.dart';

void main() {
  group("summersimmer.calculate:", () {
    List<Map<String, dynamic>> _inputsToExpected = [
      {'temperature' : 0.0, 'humidity' : 0.0, 'temperatureUnit' : TEMPERATURE_CELSIUS, 'expectedOutput' : '1.580'},
      {'temperature' : 45.0, 'humidity' : 55.0, 'temperatureUnit' : TEMPERATURE_CELSIUS, 'expectedOutput' : '59.976'},
      {'temperature' : 56.0, 'humidity' : 30.0, 'temperatureUnit' : TEMPERATURE_FAHRENHEIT, 'expectedOutput' : '55.575'},
      {'temperature' : 18.0, 'humidity' : 75.0, 'temperatureUnit' : TEMPERATURE_CELSIUS, 'expectedOutput' : '20.522'},
      {'temperature' : 0.0, 'humidity' : 0.0, 'temperatureUnit' : TEMPERATURE_FAHRENHEIT, 'expectedOutput' : '6.332'},
    ];

    _inputsToExpected.forEach((elem) {
      test('temperature: ${elem['temperature']}, humidity: ${elem['humidity']}, temperatureUnit: ${elem['temperatureUnit'].symbol}', () {
        var _actual = calculateSummersimmerIndex(elem['temperature'], elem['humidity'], elem['temperatureUnit']);
        expect(_actual.toStringAsFixed(3), elem['expectedOutput']);
      });
    });
  });
}
