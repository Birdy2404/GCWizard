import "package:flutter_test/flutter_test.dart";
import 'package:gc_wizard/tools/coords/geohashing/logic/geohashing.dart';
import 'package:latlong2/latlong.dart';

void main() {
  group("Parser.geohashing.parse:", () {
    List<Map<String, Object?>> _inputsToExpected = [
      {'text': '2015-03-27 34.123,-111.456', 'expectedOutput': const LatLng(34.77404831931672, -110.00927092789482)},
      {'text': '34.123,-111.456 2015-03-27', 'expectedOutput': const LatLng(34.77404831931672, -110.00927092789482)},
      {'text': '2008-09-10 34.123,-111.456', 'expectedOutput': const LatLng(34.252676119260464, -110.52885673731781)},
      {'text': '2015-05-05 34.123,-111.456', 'expectedOutput': const LatLng(34.89779651276887, -110.45188023531117)},
      {'text': '2015-05-05 34.123, -111.456', 'expectedOutput': const LatLng(34.89779651276887, -110.45188023531117)},
    ];

    for (var elem in _inputsToExpected) {
      test('text: ${elem['text']}', () async {
        var _actual = await Geohashing.parse(elem['text'] as String)?.toLatLng();
        if (_actual == null) {
          expect(null, elem['expectedOutput']);
        } else {
          //print(_actual.toString());
          print(_actual.latitude.toString() + ', ' + _actual.longitude.toString());
          expect((_actual.latitude - ((elem['expectedOutput'] as LatLng).latitude)).abs() < 1e-8, true);
          expect((_actual.longitude - ((elem['expectedOutput'] as LatLng).longitude)).abs() < 1e-8, true);
        }
      });
    }
  });

  group("Parser.geohashing.toLatLon:", () {
    List<Map<String, Object?>> _inputsToExpected = [
      {'input': Geohashing(DateTime.parse('2015-03-27'), 34, -111), 'expectedOutput': const LatLng(34.77404831931672, -110.00927092789482)},
      {'input': Geohashing(DateTime.parse('2008-09-10'), 34,-111), 'expectedOutput': const LatLng(34.252676119260464, -110.52885673731781)},
      {'input': Geohashing(DateTime.parse('2015-05-05'), 34,-111), 'expectedOutput': const LatLng(34.89779651276887, -110.45188023531117)},

      {'input': Geohashing(DateTime.parse('2015-03-27'), 34, -111, dowJonesIndex: 17673.63), 'expectedOutput': const LatLng(34.77404831931672, -110.00927092789482)},
      {'input': Geohashing(DateTime.parse('2008-09-10'), 34,-111, dowJonesIndex: 11233.91), 'expectedOutput': const LatLng(34.252676119260464, -110.52885673731781)},
      {'input': Geohashing(DateTime.parse('2015-05-05'), 34,-111, dowJonesIndex: 18062.53), 'expectedOutput': const LatLng(34.89779651276887, -110.45188023531117)},
    ];

    for (var elem in _inputsToExpected) {
      test('text: ${elem['input']}', () async {
        var _actual = await (elem['input'] as Geohashing).toLatLng();
        if (_actual == null) {
          expect(null, elem['expectedOutput']);
        } else {
          //print(_actual.toString());
          print(_actual.latitude.toString() + ', ' + _actual.longitude.toString());
          expect((_actual.latitude - ((elem['expectedOutput'] as LatLng).latitude)).abs() < 1e-8, true);
          expect((_actual.longitude - ((elem['expectedOutput'] as LatLng).longitude)).abs() < 1e-8, true);
        }
      });
    }
  });

  group("geohashing.dowJonesIndex:", () {
    List<Map<String, Object?>> _inputsToExpected = [
      {'date': DateTime.now().add(const Duration(days: 1)), 'expectedOutput': null},
      {'date': DateTime.parse('1800-03-27'), 'expectedOutput': null},

      {'date': DateTime.parse('2022-03-27'), 'expectedOutput': 34702.39},
      {'date': DateTime.parse('2015-03-27'), 'expectedOutput': 17673.63},
      {'date': DateTime.parse('2008-09-10'), 'expectedOutput': 11233.91},
      {'date': DateTime.parse('2015-05-05'), 'expectedOutput': 18062.53},
    ];

    for (var elem in _inputsToExpected) {
      test('text: ${elem['date']}', () async {
        var _actual = await dowJonesIndex(elem['date'] as DateTime);
        expect(_actual, elem['expectedOutput']);
      });
    }
  });
}