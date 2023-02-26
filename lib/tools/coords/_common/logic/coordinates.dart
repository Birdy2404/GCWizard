import 'dart:math';

import 'package:gc_wizard/tools/coords/_common/logic/coordinate_format.dart';
import 'package:gc_wizard/tools/coords/_common/logic/coordinate_format_constants.dart';
import 'package:gc_wizard/tools/coords/format_converter/logic/dec.dart';
import 'package:gc_wizard/tools/coords/format_converter/logic/dmm.dart';
import 'package:gc_wizard/tools/coords/format_converter/logic/dms.dart';
import 'package:gc_wizard/tools/coords/format_converter/logic/dutchgrid.dart';
import 'package:gc_wizard/tools/coords/format_converter/logic/gauss_krueger.dart';
import 'package:gc_wizard/tools/coords/format_converter/logic/geo3x3.dart';
import 'package:gc_wizard/tools/coords/format_converter/logic/geohash.dart';
import 'package:gc_wizard/tools/coords/format_converter/logic/geohex.dart';
import 'package:gc_wizard/tools/coords/format_converter/logic/lambert.dart';
import 'package:gc_wizard/tools/coords/format_converter/logic/maidenhead.dart';
import 'package:gc_wizard/tools/coords/format_converter/logic/makaney.dart';
import 'package:gc_wizard/tools/coords/format_converter/logic/mercator.dart';
import 'package:gc_wizard/tools/coords/format_converter/logic/mgrs.dart';
import 'package:gc_wizard/tools/coords/format_converter/logic/natural_area_code.dart';
import 'package:gc_wizard/tools/coords/format_converter/logic/open_location_code.dart';
import 'package:gc_wizard/tools/coords/format_converter/logic/quadtree.dart';
import 'package:gc_wizard/tools/coords/format_converter/logic/reverse_wherigo_day1976.dart';
import 'package:gc_wizard/tools/coords/format_converter/logic/reverse_wherigo_waldmeister.dart';
import 'package:gc_wizard/tools/coords/format_converter/logic/slippy_map.dart';
import 'package:gc_wizard/tools/coords/format_converter/logic/swissgrid.dart';
import 'package:gc_wizard/tools/coords/format_converter/logic/utm.dart';
import 'package:gc_wizard/tools/coords/format_converter/logic/xyz.dart';
import 'package:gc_wizard/tools/coords/_common/logic/default_coord_getter.dart';
import 'package:gc_wizard/tools/coords/_common/logic/ellipsoid.dart';
import 'package:gc_wizard/utils/collection_utils.dart';
import 'package:gc_wizard/utils/complex_return_types.dart';
import 'package:gc_wizard/utils/constants.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';

abstract class BaseCoordFormatKey{}

const keyCoordsALL = 'coords_all';

String _dmmAndDMSNumberFormat([int precision = 6]) {
  var formatString = '00.';
  if (precision < 0) precision = 0;

  if (precision <= 3) formatString += '0' * precision;
  if (precision > 3) formatString += '000' + '#' * (precision - 3);

  return formatString;
}

String _getCoordinateSignString(int sign, bool isLatitude) {
  var _sign = '';

  if (isLatitude) {
    _sign = (sign >= 0) ? 'N' : 'S';
  } else {
    _sign = (sign >= 0) ? 'E' : 'W';
  }

  return _sign;
}

int getCoordinateSignFromString(String text, bool isLatitude) {
  int _sign = 0;

  if (isLatitude) {
    _sign = (text == 'N') ? 1 : -1;
  } else {
    _sign = (text == 'E') ? 1 : -1;
  }

  return _sign;
}

class BaseCoordinates {
  CoordinateFormatKey get key => CoordinateFormatKey.BASE_FORMAT;

  late double _latitude;
  late double _longitude;

  BaseCoordinates ([double? latitude, double? longitude]) {
    if (latitude == null)
      _latitude = defaultCoordinate.latitude;
    if (longitude == null)
      _longitude = defaultCoordinate.longitude;
  }

  LatLng toLatLng() {
    return LatLng(_latitude, _longitude);
  }

  @override
  String toString() {
    return LatLng(_latitude, _longitude).toString();
  }
}

class DEC extends BaseCoordinates {
  @override
  CoordinateFormatKey get key => CoordinateFormatKey.DEC;
  double latitude;
  double longitude;

  DEC(this.latitude, this.longitude);

  @override
  LatLng toLatLng() {
    return decToLatLon(this);
  }

  static DEC fromLatLon(LatLng coord) {
    return latLonToDEC(coord);
  }

  static DEC? parse(String input, {bool wholeString = false}) {
    return parseDEC(input, wholeString: wholeString);
  }

  @override
  String toString([int precision = 10]) {
    if (precision < 1) precision = 1;

    String fixedDigits = '0' * min(precision, 3);
    String variableDigits = precision > 3 ? '#' * (precision - 3) : '';

    return '${NumberFormat('00.' + fixedDigits + variableDigits).format(latitude)}\n${NumberFormat('000.' + fixedDigits + variableDigits).format(longitude)}';
  }
}

class FormattedDMMPart {
  IntegerText sign;
  String degrees, minutes;

  FormattedDMMPart(this.sign, this.degrees, this.minutes);

  @override
  String toString() {
    return sign.text + ' ' +  degrees +  '° ' +  minutes + '\'';
  }
}

class DMMPart {
  CoordinateFormatKey get key => CoordinateFormatKey.DMM;

  int sign;
  int degrees;
  double minutes;

  DMMPart(this.sign, this.degrees, this.minutes);

  FormattedDMMPart _formatParts(bool isLatitude, [int precision = 10]) {
    var _minutesStr = NumberFormat(_dmmAndDMSNumberFormat(precision)).format(minutes);
    var _degrees = degrees;
    var _sign = _getCoordinateSignString(sign, isLatitude);

    //Values like 59.999999999' may be rounded to 60.0. So in that case,
    //the degree has to be increased while minutes should be set to 0.0
    if (_minutesStr.startsWith('60')) {
      _minutesStr = '00.000';
      _degrees += 1;
    }

    String _degreesStr = _degrees.toString().padLeft(isLatitude ? 2 : 3, '0');

    return FormattedDMMPart(IntegerText(_sign, sign), _degreesStr, _minutesStr);
  }

  String _format(bool isLatitude, [int precision = 10]) {
    var formattedParts = _formatParts(isLatitude, precision);

    return formattedParts.toString();
  }

  @override
  String toString() {
    return 'sign: $sign, degrees: $degrees, minutes: $minutes';
  }
}

class DMMLatitude extends DMMPart {
  DMMLatitude(int sign, int degrees, double minutes) : super(sign, degrees, minutes);

  static DMMLatitude from(DMMPart dmmPart) {
    return DMMLatitude(dmmPart.sign, dmmPart.degrees, dmmPart.minutes);
  }

  FormattedDMMPart formatParts([int precision = 10]) {
    return super._formatParts(true, precision);
  }

  String format([int precision = 10]) {
    return super._format(true, precision);
  }
}

class DMMLongitude extends DMMPart {
  DMMLongitude(int sign, int degrees, double minutes) : super(sign, degrees, minutes);

  static DMMLongitude from(DMMPart dmmPart) {
    return DMMLongitude(dmmPart.sign, dmmPart.degrees, dmmPart.minutes);
  }

  FormattedDMMPart formatParts([int precision = 10]) {
    return super._formatParts(false, precision);
  }

  String format([int precision = 10]) {
    return super._format(false, precision);
  }
}

class DMM extends BaseCoordinates {
  @override
  CoordinateFormatKey get key => CoordinateFormatKey.DMM;
  DMMLatitude latitude;
  DMMLongitude longitude;

  DMM(this.latitude, this.longitude);

  @override
  LatLng toLatLng() {
    return dmmToLatLon(this);
  }

  static DMM fromLatLon(LatLng coord) {
    return latLonToDMM(coord);
  }

  static DMM? parse(String text, {bool leftPadMilliMinutes = false, bool wholeString = false}) {
    return parseDMM(text, leftPadMilliMinutes: leftPadMilliMinutes, wholeString: wholeString);
  }

  @override
  String toString([int precision = 10]) {
    return '${latitude.format(precision)}\n${longitude.format(precision)}';
  }
}

class FormattedDMSPart {
  IntegerText sign;
  String degrees, minutes, seconds;

  FormattedDMSPart(this.sign, this.degrees, this.minutes, this.seconds);

  @override
  String toString() {
    return sign.text + ' ' +  degrees +  '° ' +  minutes + '\' ' + seconds + '"';
  }
}

class DMSPart {
  int sign;
  int degrees;
  int minutes;
  double seconds;

  DMSPart(this.sign, this.degrees, this.minutes, this.seconds);

  FormattedDMSPart _formatParts(bool isLatitude, [int precision = 10]) {
    var _sign = _getCoordinateSignString(sign, isLatitude);
    var _secondsStr = NumberFormat(_dmmAndDMSNumberFormat(precision)).format(seconds);
    var _minutes = minutes;

    //Values like 59.999999999 may be rounded to 60.0. So in that case,
    //the greater unit (minutes or degrees) has to be increased instead
    if (_secondsStr.startsWith('60')) {
      _secondsStr = '00.000';
      _minutes += 1;
    }

    var _degrees = degrees;

    var _minutesStr = _minutes.toString().padLeft(2, '0');
    if (_minutesStr.startsWith('60')) {
      _minutesStr = '00';
      _degrees += 1;
    }

    var _degreesStr = _degrees.toString().padLeft(isLatitude ? 2 : 3, '0');

    return FormattedDMSPart(IntegerText(_sign, sign), _degreesStr, _minutesStr, _secondsStr);
  }

  String _format(bool isLatitude, [int precision = 10]) {
    var formattedParts = _formatParts(isLatitude, precision);

    return formattedParts.toString();
  }

  @override
  String toString() {
    return 'sign: $sign, degrees: $degrees, minutes: $minutes, seconds: $seconds';
  }
}

class DMSLatitude extends DMSPart {
  DMSLatitude(int sign, int degrees, int minutes, double seconds) : super(sign, degrees, minutes, seconds);

  static DMSLatitude from(DMSPart dmsPart) {
    return DMSLatitude(dmsPart.sign, dmsPart.degrees, dmsPart.minutes, dmsPart.seconds);
  }

  FormattedDMSPart formatParts([int precision = 10]) {
    return super._formatParts(true, precision);
  }

  String format([int precision = 10]) {
    return super._format(true, precision);
  }
}

class DMSLongitude extends DMSPart {
  DMSLongitude(int sign, int degrees, int minutes, double seconds) : super(sign, degrees, minutes, seconds);

  static DMSLongitude from(DMSPart dmsPart) {
    return DMSLongitude(dmsPart.sign, dmsPart.degrees, dmsPart.minutes, dmsPart.seconds);
  }

  FormattedDMSPart formatParts([int precision = 10]) {
    return super._formatParts(false, precision);
  }

  String format([int precision = 10]) {
    return super._format(false, precision);
  }
}

class DMS extends BaseCoordinates {
  @override
  CoordinateFormatKey get key => CoordinateFormatKey.DMS;

  DMSLatitude latitude;
  DMSLongitude longitude;

  DMS(this.latitude, this.longitude);

  @override
  LatLng toLatLng() {
    return dmsToLatLon(this);
  }

  static DMS fromLatLon(LatLng coord) {
    return latLonToDMS(coord);
  }

  static DMS parse(String input, {bool wholeString = false}) {
    return parseDMS(input, wholeString: wholeString);
  }

  @override
  String toString([int precision = 10]) {
    return '${latitude.format(precision)}\n${longitude.format(precision)}';
  }
}

enum HemisphereLatitude { North, South }

enum HemisphereLongitude { East, West }

// UTM with latitude Zones; Normal UTM is only separated into Hemispheres N and S
class UTMREF extends BaseCoordinates {
  @override
  CoordinateFormatKey get key => CoordinateFormatKey.UTM;

  UTMZone zone;
  double easting;
  double northing;

  UTMREF(this.zone, this.easting, this.northing);

  HemisphereLatitude get hemisphere {
    return 'NPQRSTUVWXYZ'.contains(zone.latZone) ? HemisphereLatitude.North : HemisphereLatitude.South;
  }

  @override
  LatLng toLatLng({Ellipsoid? ells}) {
    if (ells == null) ells = defaultEllipsoid();
    return UTMREFtoLatLon(this, ells);
  }

  static UTMREF fromLatLon(LatLng coord, Ellipsoid ells) {
    return latLonToUTM(coord, ells);
  }

  static UTMREF parse(String input) {
    return parseUTM(input);
  }

  @override
  String toString() {
    return '${zone.lonZone} ${zone.latZone} ${doubleFormat.format(easting)} ${doubleFormat.format(northing)}';
  }
}

class UTMZone {
  int lonZone;
  int lonZoneRegular; //the real lonZone differs from mathematical because of two special zones around norway
  String latZone;

  UTMZone(this.lonZoneRegular, this.lonZone, this.latZone);
}

class MGRS extends BaseCoordinates {
  @override
  CoordinateFormatKey get key => CoordinateFormatKey.MGRS;

  UTMZone utmZone;
  String digraph;
  double easting;
  double northing;

  MGRS(this.utmZone, this.digraph, this.easting, this.northing);

  @override
  LatLng toLatLng({Ellipsoid? ells}) {
    if (ells == null) ells = defaultEllipsoid();
    return mgrsToLatLon(this, ells);
  }

  static MGRS fromLatLon(LatLng coord, Ellipsoid ells) {
    return latLonToMGRS(coord, ells);
  }

  static MGRS parse(String text) {
    return parseMGRS(text);
  }

  @override
  String toString() {
    return '${utmZone.lonZone}${utmZone.latZone} $digraph ${doubleFormat.format(easting)} ${doubleFormat.format(northing)}';
  }
}

class SwissGrid extends BaseCoordinates {
  @override
  CoordinateFormatKey get key => CoordinateFormatKey.SWISS_GRID;

  double easting;
  double northing;

  SwissGrid(this.easting, this.northing);

  @override
  LatLng toLatLng({Ellipsoid? ells}) {
    if (ells == null) ells = defaultEllipsoid();
    return swissGridToLatLon(this, ells);
  }

  static SwissGrid fromLatLon(LatLng coord, Ellipsoid ells) {
    return latLonToSwissGrid(coord, ells);
  }

  static SwissGrid parse(String input) {
    return parseSwissGrid(input);
  }

  @override
  String toString() {
    return 'Y: $easting\nX: $northing';
  }
}

class SwissGridPlus extends SwissGrid {
  @override
  CoordinateFormatKey get key => CoordinateFormatKey.SWISS_GRID_PLUS;

  SwissGridPlus(double easting, double northing) : super(easting, northing);

  @override
  LatLng toLatLng({Ellipsoid? ells}) {
    if (ells == null) ells = defaultEllipsoid();
    return swissGridPlusToLatLon(this, ells);
  }

  static SwissGridPlus fromLatLon(LatLng coord, Ellipsoid ells) {
    return latLonToSwissGridPlus(coord, ells);
  }

  static SwissGridPlus parse(String input) {
    return parseSwissGridPlus(input);
  }
}

class DutchGrid extends BaseCoordinates {
  @override
  CoordinateFormatKey get key => CoordinateFormatKey.DUTCH_GRID;

  double x;
  double y;

  DutchGrid(this.x, this.y);

  @override
  LatLng toLatLng() {
    return dutchGridToLatLon(this);
  }

  static DutchGrid fromLatLon(LatLng coord) {
    return latLonToDutchGrid(coord);
  }

  static DutchGrid parse(String input) {
    return parseDutchGrid(input);
  }

  @override
  String toString() {
    return 'X: $x\nY: $y';
  }
}

class GaussKrueger extends BaseCoordinates {
  @override
  CoordinateFormatKey get key => CoordinateFormatKey.GAUSS_KRUEGER;

  CoordinateFormatKey subtype;
  double easting;
  double northing;

  GaussKrueger(this.subtype, this.easting, this.northing) {
    if (!isSubtypeOfCoordinateFormat(CoordinateFormatKey.GAUSS_KRUEGER, this.subtype))
      throw Exception('No valid GaussKrueger subtype given');
  }

  @override
  LatLng toLatLng({Ellipsoid? ells}) {
    if (ells == null) ells = defaultEllipsoid();
    return gaussKruegerToLatLon(this, ells);
  }

  static GaussKrueger fromLatLon(LatLng coord, CoordinateFormatKey subtype, Ellipsoid ells) {
    return latLonToGaussKrueger(coord, subtype, ells);
  }

  static GaussKrueger parse(String input, {CoordinateFormatKey gaussKruegerCode = defaultGaussKruegerType}) {
    return parseGaussKrueger(input, gaussKruegerCode: gaussKruegerCode);
  }

  @override
  String toString() {
    return 'R: $easting\nH: $northing';
  }
}

class Lambert extends BaseCoordinates {
  @override
  CoordinateFormatKey get key => CoordinateFormatKey.LAMBERT;

  CoordinateFormatKey subtype;
  double easting;
  double northing;

  Lambert(this.subtype, this.easting, this.northing) {
    if (!isSubtypeOfCoordinateFormat(CoordinateFormatKey.LAMBERT, this.subtype))
      throw Exception('No valid Lambert subtype given.');
  }

  @override
  LatLng toLatLng({Ellipsoid? ells}) {
    if (ells == null) ells = defaultEllipsoid();
    return lambertToLatLon(this, ells);
  }

  static Lambert fromLatLon(LatLng coord, CoordinateFormatKey subtype, Ellipsoid ells) {
    return latLonToLambert(coord, subtype, ells);
  }

  static Lambert parse(String input, {CoordinateFormatKey type = defaultLambertType}) {
    return parseLambert(input, type: type);
  }

  @override
  String toString() {
    return 'X: $easting\nY: $northing';
  }
}

class Mercator extends BaseCoordinates {
  @override
  CoordinateFormatKey get key => CoordinateFormatKey.MERCATOR;

  double easting;
  double northing;

  Mercator(this.easting, this.northing);

  @override
  LatLng toLatLng({Ellipsoid? ells}) {
    if (ells == null) ells = defaultEllipsoid();
    return mercatorToLatLon(this, ells);
  }

  static Mercator fromLatLon(LatLng coord, Ellipsoid ells) {
    return latLonToMercator(coord, ells);
  }

  static Mercator parse(String input) {
    return parseMercator(input);
  }

  @override
  String toString() {
    return 'Y: $easting\nX: $northing';
  }
}

class NaturalAreaCode extends BaseCoordinates {
  @override
  CoordinateFormatKey get key => CoordinateFormatKey.NATURAL_AREA_CODE;

  String x; //east
  String y; //north

  NaturalAreaCode(this.x, this.y);

  @override
  LatLng toLatLng() {
    return naturalAreaCodeToLatLon(this);
  }

  static NaturalAreaCode fromLatLon(LatLng coord, {int precision = 8}) {
    return latLonToNaturalAreaCode(coord, precision: precision);
  }

  static NaturalAreaCode parse(String input) {
    return parseNaturalAreaCode(input);
  }

  @override
  String toString() {
    return 'X: $x\nY: $y';
  }
}

class SlippyMap extends BaseCoordinates {
  @override
  CoordinateFormatKey get key => CoordinateFormatKey.SLIPPY_MAP;

  double x;
  double y;
  double zoom;

  SlippyMap(this.x, this.y, this.zoom);

  @override
  LatLng toLatLng() {
    return slippyMapToLatLon(this);
  }

  static SlippyMap fromLatLon(LatLng coord, CoordinateFormatKey subtype) {
    return latLonToSlippyMap(coord, switchMapKeyValue(SLIPPY_MAP_ZOOM)[subtype]!.toDouble());
  }

  static SlippyMap parse(String input, CoordinateFormatKey subtype) {
    return parseSlippyMap(input, zoom: switchMapKeyValue(SLIPPY_MAP_ZOOM)[subtype]!.toDouble());
  }

  @override
  String toString() {
    return 'X: $x\nY: $y\nZoom: $zoom';
  }
}

class ReverseWherigoWaldmeister extends BaseCoordinates {
  @override
  CoordinateFormatKey get key => CoordinateFormatKey.REVERSE_WIG_WALDMEISTER;

  String a, b, c;

  ReverseWherigoWaldmeister(this.a, this.b, this.c);

  @override
  LatLng toLatLng() {
    return reverseWIGWaldmeisterToLatLon(this);
  }

  static ReverseWherigoWaldmeister fromLatLon(LatLng coord) {
    return latLonToReverseWIGWaldmeister(coord);
  }

  static ReverseWherigoWaldmeister parse(String input) {
    return parseReverseWherigoWaldmeister(input);
  }

  @override
  String toString() {
    return '$a\n$b\n$c';
  }
}

class ReverseWherigoDay1976 extends BaseCoordinates {
  @override
  CoordinateFormatKey get key => CoordinateFormatKey.REVERSE_WIG_DAY1976;

  String s, t;

  ReverseWherigoDay1976(this.s, this.t);

  @override
  LatLng toLatLng() {
    return reverseWIGDay1976ToLatLon(this);
  }

  static ReverseWherigoDay1976 fromLatLon(LatLng coord) {
    return latLonToReverseWIGDay1976(coord);
  }

  static ReverseWherigoDay1976 parse(String input) {
    return parseReverseWherigoDay1976(input);
  }

  @override
  String toString() {
    return '$s\n$t';
  }
}

class XYZ extends BaseCoordinates {
  @override
  CoordinateFormatKey get key => CoordinateFormatKey.XYZ;

  double x, y, z;

  XYZ(this.x, this.y, this.z);

  @override
  LatLng toLatLng({Ellipsoid? ells}) {
    if (ells == null) ells = defaultEllipsoid();
    return xyzToLatLon(this, ells);
  }

  static XYZ fromLatLon(LatLng coord, Ellipsoid ells, {double h = 0.0}) {
    return latLonToXYZ(coord, ells, h: h);
  }

  static XYZ parse(String input) {
    return parseXYZ(input);
  }

  @override
  String toString() {
    var numberFormat = NumberFormat('0.######');
    return 'X: ${numberFormat.format(x)}\nY: ${numberFormat.format(y)}\nZ: ${numberFormat.format(z)}';
  }
}

class Maidenhead extends BaseCoordinates {
  @override
  CoordinateFormatKey get key => CoordinateFormatKey.MAIDENHEAD;

  String text;

  Maidenhead(this.text);

  @override
  LatLng toLatLng() {
    return maidenheadToLatLon(this);
  }

  static Maidenhead fromLatLon(LatLng coord) {
    return latLonToMaidenhead(coord);
  }

  static Maidenhead parse(String input) {
    return parseMaidenhead(input);
  }

  @override
  String toString() {
    return text;
  }
}

class Makaney extends BaseCoordinates {
  @override
  CoordinateFormatKey get key => CoordinateFormatKey.MAKANEY;

  String text;

  Makaney(this.text);

  @override
  LatLng toLatLng() {
    return makaneyToLatLon(this);
  }

  static Makaney fromLatLon(LatLng coord) {
    return latLonToMakaney(coord);
  }

  static Makaney parse(String input) {
    return parseMakaney(input);
  }

  @override
  String toString() {
    return text;
  }
}

class Geohash extends BaseCoordinates {
  @override
  CoordinateFormatKey get key => CoordinateFormatKey.GEOHASH;

  String text;

  Geohash(this.text);

  @override
  LatLng toLatLng() {
    return geohashToLatLon(this);
  }

  static Geohash fromLatLon(LatLng coord, int geohashLength) {
    return latLonToGeohash(coord, geohashLength);
  }

  static Geohash parse(String input) {
    return parseGeohash(input);
  }

  @override
  String toString() {
    return text;
  }
}

class GeoHex extends BaseCoordinates {
  @override
  CoordinateFormatKey get key => CoordinateFormatKey.GEOHEX;

  String text;

  GeoHex(this.text);

  @override
  LatLng toLatLng() {
    return geoHexToLatLon(this);
  }

  static GeoHex fromLatLon(LatLng coord, int precision) {
    return latLonToGeoHex(coord, precision);
  }

  static GeoHex parse(String input) {
    return parseGeoHex(input);
  }

  @override
  String toString() {
    return text;
  }
}

class Geo3x3 extends BaseCoordinates {
  @override
  CoordinateFormatKey get key => CoordinateFormatKey.GEO3X3;

  String text;

  Geo3x3(this.text);

  @override
  LatLng toLatLng() {
    return geo3x3ToLatLon(this);
  }

  static Geo3x3 fromLatLon(LatLng coord, int level) {
    return latLonToGeo3x3(coord, level);
  }

  static Geo3x3 parse(String input) {
    return parseGeo3x3(input);
  }

  @override
  String toString() {
    return text.toUpperCase();
  }
}

class OpenLocationCode extends BaseCoordinates {
  @override
  CoordinateFormatKey get key => CoordinateFormatKey.OPEN_LOCATION_CODE;

  String text;

  OpenLocationCode(this.text);

  @override
  LatLng toLatLng() {
    return openLocationCodeToLatLon(this);
  }

  static OpenLocationCode fromLatLon(LatLng coord, {int codeLength = 14}) {
    return latLonToOpenLocationCode(coord, codeLength: codeLength);
  }

  static OpenLocationCode parse(String input) {
    return parseOpenLocationCode(input);
  }

  @override
  String toString() {
    return text;
  }
}

class Quadtree extends BaseCoordinates {
  @override
  CoordinateFormatKey get key => CoordinateFormatKey.QUADTREE;

  List<int> coords;

  Quadtree(this.coords);

  @override
  LatLng toLatLng() {
    return quadtreeToLatLon(this);
  }

  static Quadtree parse(String input) {
    return parseQuadtree(input);
  }

  static Quadtree fromLatLon(LatLng coord, {int precision = 40}) {
    return latLonToQuadtree(coord, precision: precision);
  }

  @override
  String toString() {
    return coords.join();
  }
}
