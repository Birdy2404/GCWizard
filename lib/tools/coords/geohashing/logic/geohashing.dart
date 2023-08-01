import 'dart:convert';
import 'dart:math';

import 'package:gc_wizard/tools/coords/_common/logic/coordinates.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/hashes/logic/hashes.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';
import 'package:collection/collection.dart';
import 'package:http/http.dart' as http;

const _VALID_CHARS = '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ';
const _domain = 'http://geo.crox.net/djia';

class Geohashing {
  int latitude;
  int longitude;
  DateTime date;
  double dowJonesIndex;
  LatLng? location;

  Geohashing(this.date, this.latitude, this.longitude, {this.dowJonesIndex = 0}) {
    //_format = CoordinateFormat(CoordinateFormatKey.GEOHASHING);
  }

  Future<LatLng?> toLatLng() async {
    location = await geohashingToLatLon(this);
    return location;
  }

  static Geohashing? parse(String input) {
    return parseGeohashing(input);
  }

  String toString([int? precision]) {
    var format = NumberFormat('0.0000000000');
    return (format.format(location?.latitude ?? 0) ) + ',, ' + (format.format(location?.longitude ?? 0) ) + ' ' + DateFormat('yyyy-dd-MM').format(date);
    //return location.toString() + ' ' + DateFormat('yyyy-dd-MM').format(date);
  }
}


Future<LatLng?> geohashingToLatLon(Geohashing geohashing) async {
  if (geohashing.dowJonesIndex == 0) {
    geohashing.dowJonesIndex = await dowJonesIndex(geohashing.date) ?? 0;
  }
  if (geohashing.dowJonesIndex == 0) return null;

  var _date = geohashing.date;
  if (_W30RuleNecessary(geohashing)) {
    _date = _date.add(const Duration (days: -1));
  }

  var date = DateFormat('yyyy-dd-MM').format(_date);
  var format = NumberFormat('0.00');
  var md5 = md5Digest(date + '-' + format.format(geohashing.dowJonesIndex));
  var lat = _hexToDec(md5.substring(0, 15));
  var lng = _hexToDec(md5.substring(16));

  return LatLng(geohashing.latitude.truncateToDouble() + lat,
                geohashing.longitude.truncateToDouble() + lng);
}

Geohashing? parseGeohashing(String input) {
  var regExp = RegExp(r'(\d{4})-(\d{2})-(\d{2})');
  if (regExp.hasMatch(input)) {
    var match = regExp.firstMatch(input);
    var decString = input.substring(0, match!.start);
    var dec = DEC.parse(decString, wholeString: false); // test before date

    if (dec == null) {
      decString = input.substring(match.end);
      dec = DEC.parse(decString, wholeString: false); // test after date
    }
    if (dec != null) {
      return Geohashing(DateTime (
            int.parse(match.group(1)!),
            int.parse(match.group(2)!),
            int.parse(match.group(3)!)),
            dec.latitude.truncate(),
            dec.longitude.truncate());
    }
  }
  return null;
}

Future<double?> dowJonesIndex(DateTime date) async {
  if (DateTime.now().difference(date).isNegative) return null;

  var uri = Uri.parse(_domain + '/' + DateFormat('yyyy-MM-dd').format(date));
  var encoding = Encoding.getByName('utf-8');

  http.Response response = await http.post(
    uri,
    encoding: encoding,
  );

  if (response.statusCode != 200) return null;

  return double.parse(response.body);
}

/// For every location east of Longitude -30
/// (Europe, Africa, Asia, and Australia), use the Dow opening from
/// the previous day — even if a new one becomes available
bool _W30RuleNecessary(Geohashing geohashing) {
  return geohashing.longitude > -30;
}

double _hexToDec(String input) {
  var t = _toValidChars(input).split('').toList()
      .mapIndexed((index, char) => _charToValue(char, index))
      .reduce((memo, element) => memo + element);

  return t;
}

String _toValidChars(String input) {
  return input = input.toUpperCase().replaceAll(RegExp('[^' + _VALID_CHARS +']'), '');
}

double _charToValue (String char, int index) {
  return _VALID_CHARS.indexOf(char) * pow(16, -(index + 1)).toDouble();
}
