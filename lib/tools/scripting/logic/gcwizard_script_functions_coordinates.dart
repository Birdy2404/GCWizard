part of 'package:gc_wizard/tools/scripting/logic/gcwizard_script.dart';

String _wgs84(Object x, Object y) {
  if (_isString(x) || _isString(y)) {
    _handleError(_INVALIDTYPECAST);
    return '';
  }
  var coord = LatLng(x as double, y as double);
  return coord.latitude.toString() + ' ' + coord.longitude.toString();
}

double _getlon() {
  return _state.GCWizardScript_LON;
}

double _getlat() {
  return _state.GCWizardScript_LAT;
}

String _getcoord1() {
  return _state.GCWizardScript_COORD_1;
}

String _getcoord2() {
  return _state.GCWizardScript_COORD_2;
}

String _getcoord3() {
  return _state.GCWizardScript_COORD_3;
}

String _getcoord4() {
  return _state.GCWizardScript_COORD_4;
}

void _setlon(Object x) {
  if (_isString(x)) {
    _handleError(_INVALIDTYPECAST);
  }
  if ((x as num).abs() > 180) {
    _handleError(_INVALIDLONGITUDE);
    _state.GCWizardScript_LON = x as double;
  } else {
    _state.GCWizardScript_LON = x as double;
  }
}

void _setlat(Object x) {
  if (_isString(x)) {
    _handleError(_INVALIDTYPECAST);
  }
  if ((x as num).abs() > 90) {
    _handleError(_INVALIDLATITUDE);
    _state.GCWizardScript_LAT = 0;
  } else {
    _state.GCWizardScript_LAT = x as double;
  }
}

void _setcoord1(Object x) {
  _state.GCWizardScript_COORD_1 = x as String;
}

void _setcoord2(Object x) {
  _state.GCWizardScript_COORD_2 = x as String;
}

void _setcoord3(Object x) {
  _state.GCWizardScript_COORD_3 = x as String;
}

void _setcoord4(Object x) {
  _state.GCWizardScript_COORD_4 = x as String;
}

String _convertto(Object target) {
  if (_isNotNumber(target)) {
    _handleError(_INVALIDTYPECAST);
  }

  LatLng coord = LatLng(_getlat(), _getlon());
  String targetCoord = '';

  if (_GCW_SCRIPT_COORD_CONVERTER[target] != null) {
    targetCoord = formatCoordOutput(
        coord, CoordinateFormat(_GCW_SCRIPT_COORD_CONVERTER[target]!), getEllipsoidByName(ELLIPSOID_NAME_WGS84)!);
  } else {
    _handleError(_INVALIDCOORDINATEFORMAT);
  }

  List<String> targetCoordData = [];
  _setcoord1('');
  _setcoord2('');
  _setcoord3('');
  _setcoord4('');
  switch (target as num) {
    //TODO 'package:prefs/prefs.dart': Failed assertion: line 244 pos 12: '_initCalled': Prefs.init() must be called first in an initState() preferably!
    case _COORD_DMM: //= 1;

    case _COORD_DUTCH_GRID: //= 8;

    case _COORD_GAUSS_KRUEGER_GK1: //= 901;
    case _COORD_GAUSS_KRUEGER_GK2: //= 902;
    case _COORD_GAUSS_KRUEGER_GK3: //= 903;
    case _COORD_GAUSS_KRUEGER_GK4: //= 904;
    case _COORD_GAUSS_KRUEGER_GK5: //= 905;

    case _COORD_LAMBERT93: //= 1093;
    case _COORD_LAMBERT2008: //= 1008;
    case _COORD_ETRS89LCC: //= 1089;
    case _COORD_LAMBERT72: //= 1072;
    case _COORD_LAMBERT93_CC42: //= 1042;
    case _COORD_LAMBERT93_CC43: //= 1043;
    case _COORD_LAMBERT93_CC44: //= 1044;
    case _COORD_LAMBERT93_CC45: //= 1045;
    case _COORD_LAMBERT93_CC46: //= 1046;
    case _COORD_LAMBERT93_CC47: //= 1047;
    case _COORD_LAMBERT93_CC48: //= 1048;
    case _COORD_LAMBERT93_CC49: //= 1049;
    case _COORD_LAMBERT93_CC50: //= 1050;

    case _COORD_SLIPPYMAP_0: //= 1400;
    case _COORD_SLIPPYMAP_1: //= 1401;
    case _COORD_SLIPPYMAP_2: //= 1402;
    case _COORD_SLIPPYMAP_3: //= 1403;
    case _COORD_SLIPPYMAP_4: //= 1404;
    case _COORD_SLIPPYMAP_5: //= 1405;
    case _COORD_SLIPPYMAP_6: //= 1406;
    case _COORD_SLIPPYMAP_7: //= 1407;
    case _COORD_SLIPPYMAP_8: //= 1408;
    case _COORD_SLIPPYMAP_9: //= 1409;
    case _COORD_SLIPPYMAP_10: //= 1410;
    case _COORD_SLIPPYMAP_11: //= 1411;
    case _COORD_SLIPPYMAP_12: //= 1412;
    case _COORD_SLIPPYMAP_13: //= 1413;
    case _COORD_SLIPPYMAP_14: //= 1414;
    case _COORD_SLIPPYMAP_15: //= 1415;
    case _COORD_SLIPPYMAP_16: //= 1416;
    case _COORD_SLIPPYMAP_17: //= 1417;
    case _COORD_SLIPPYMAP_18: //= 1418;
    case _COORD_SLIPPYMAP_19: //= 1419;
    case _COORD_SLIPPYMAP_20: //= 1420;
    case _COORD_SLIPPYMAP_21: //= 1421;
    case _COORD_SLIPPYMAP_22: //= 1422;
    case _COORD_SLIPPYMAP_23: //= 1423;
    case _COORD_SLIPPYMAP_24: //= 1424;
    case _COORD_SLIPPYMAP_25: //= 1425;
    case _COORD_SLIPPYMAP_26: //= 1426;
    case _COORD_SLIPPYMAP_27: //= 1427;
    case _COORD_SLIPPYMAP_28: //= 1428;
    case _COORD_SLIPPYMAP_29: //= 1429;
    case _COORD_SLIPPYMAP_30: //= 1430;
      break;

    case _COORD_DEC: //= 0;
    case _COORD_DMS: //= 2;
      targetCoordData = targetCoord.split('\n');
      _setcoord1(targetCoordData[0]);
      _setcoord2(targetCoordData[1]);
      break;

    case _COORD_UTM: //= 3;
    case _COORD_MGRS: //= 4;
      targetCoordData = targetCoord.split(' ');
      _setcoord1(targetCoordData[0]);
      _setcoord2(targetCoordData[1]);
      _setcoord3(targetCoordData[2]);
      _setcoord4(targetCoordData[3]);
      break;

    case _COORD_XYZ: //= 5;
      targetCoordData = targetCoord.split('\n');
      _setcoord1(targetCoordData[0].split(': ')[1]);
      _setcoord2(targetCoordData[1].split(': ')[1]);
      _setcoord3(targetCoordData[2].split(': ')[1]);
      break;

    case _COORD_SWISS_GRID: //= 6;
    case _COORD_SWISS_GRID_PLUS: //= 7;
    case _COORD_MERCATOR: //= 12;
    case _COORD_NATURAL_AREA_CODE: //= 13;
      targetCoordData = targetCoord.split('\n');
      _setcoord1(targetCoordData[0].split(': ')[1]);
      _setcoord2(targetCoordData[1].split(': ')[1]);
      break;

    case _COORD_MAIDENHEAD: //= 11;
    case _COORD_GEOHASH: //= 15;
    case _COORD_GEO3X3: //= 16;
    case _COORD_GEOHEX: //= 17;
    case _COORD_OPEN_LOCATION_CODE: //= 18;
    case _COORD_MAKANEY: //= 19;
    case _COORD_QUADTREE: //= 20;
      _setcoord1(targetCoord);
      break;

    case _COORD_REVERSE_WIG_WALDMEISTER: //= 21;
      targetCoordData = targetCoord.split('\n');
      _setcoord1(targetCoordData[0]);
      _setcoord2(targetCoordData[1]);
      _setcoord3(targetCoordData[2]);
      break;

    case _COORD_REVERSE_WIG_DAY1976: //= 22;
      targetCoordData = targetCoord.split('\n');
      _setcoord1(targetCoordData[0]);
      _setcoord2(targetCoordData[1]);
      break;

    default:
      _handleError(_INVALIDCOORDINATEFORMAT);
  }

  return targetCoord;
}

void _convertfrom(Object source) {
  if (_isNotNumber(source)) {
    _handleError(_INVALIDTYPECAST);
  }

  late LatLng coord;
  Object coord_1 = _getcoord1();
  Object coord_2 = _getcoord2();
  Object coord_3 = _getcoord3();
  Object coord_4 = _getcoord4();
  // TODO
  switch (source as num) {
    case _COORD_DEC:
      if (_isNotNumber(coord_1)) _handleError(_INVALIDTYPECAST);
      if (_isNotNumber(coord_2)) _handleError(_INVALIDTYPECAST);
      coord = LatLng(coord_1 as double, coord_2 as double);
      break;
    case _COORD_DMM: //= 1;
    case _COORD_DMS: //= 2;
    case _COORD_UTM: //= 3;
    case _COORD_MGRS: //= 4;
    case _COORD_XYZ: //= 5;
    case _COORD_SWISS_GRID: //= 6;
    case _COORD_SWISS_GRID_PLUS: //= 7;
    case _COORD_DUTCH_GRID: //= 8;
    //case _COORD_GAUSS_KRUEGER ://= 9;
    case _COORD_GAUSS_KRUEGER_GK1: //= 901;
    case _COORD_GAUSS_KRUEGER_GK2: //= 902;
    case _COORD_GAUSS_KRUEGER_GK3: //= 903;
    case _COORD_GAUSS_KRUEGER_GK4: //= 904;
    case _COORD_GAUSS_KRUEGER_GK5: //= 905;
    //case _COORD_LAMBERT ://= 10;
    case _COORD_LAMBERT93: //= 1093;
    case _COORD_LAMBERT2008: //= 1008;
    case _COORD_ETRS89LCC: //= 1089;
    case _COORD_LAMBERT72: //= 1072;
    case _COORD_LAMBERT93_CC42: //= 1042;
    case _COORD_LAMBERT93_CC43: //= 1043;
    case _COORD_LAMBERT93_CC44: //= 1044;
    case _COORD_LAMBERT93_CC45: //= 1045;
    case _COORD_LAMBERT93_CC46: //= 1046;
    case _COORD_LAMBERT93_CC47: //= 1047;
    case _COORD_LAMBERT93_CC48: //= 1048;
    case _COORD_LAMBERT93_CC49: //= 1049;
    case _COORD_LAMBERT93_CC50: //= 1050;
    case _COORD_MAIDENHEAD: //= 11;
    case _COORD_MERCATOR: //= 12;
    case _COORD_NATURAL_AREA_CODE: //= 13;
    //case _COORD_SLIPPY_MAP ://= 14;
    case _COORD_SLIPPYMAP_0: //= 1400;
    case _COORD_SLIPPYMAP_1: //= 1401;
    case _COORD_SLIPPYMAP_2: //= 1402;
    case _COORD_SLIPPYMAP_3: //= 1403;
    case _COORD_SLIPPYMAP_4: //= 1404;
    case _COORD_SLIPPYMAP_5: //= 1405;
    case _COORD_SLIPPYMAP_6: //= 1406;
    case _COORD_SLIPPYMAP_7: //= 1407;
    case _COORD_SLIPPYMAP_8: //= 1408;
    case _COORD_SLIPPYMAP_9: //= 1409;
    case _COORD_SLIPPYMAP_10: //= 1410;
    case _COORD_SLIPPYMAP_11: //= 1411;
    case _COORD_SLIPPYMAP_12: //= 1412;
    case _COORD_SLIPPYMAP_13: //= 1413;
    case _COORD_SLIPPYMAP_14: //= 1414;
    case _COORD_SLIPPYMAP_15: //= 1415;
    case _COORD_SLIPPYMAP_16: //= 1416;
    case _COORD_SLIPPYMAP_17: //= 1417;
    case _COORD_SLIPPYMAP_18: //= 1418;
    case _COORD_SLIPPYMAP_19: //= 1419;
    case _COORD_SLIPPYMAP_20: //= 1420;
    case _COORD_SLIPPYMAP_21: //= 1421;
    case _COORD_SLIPPYMAP_22: //= 1422;
    case _COORD_SLIPPYMAP_23: //= 1423;
    case _COORD_SLIPPYMAP_24: //= 1424;
    case _COORD_SLIPPYMAP_25: //= 1425;
    case _COORD_SLIPPYMAP_26: //= 1426;
    case _COORD_SLIPPYMAP_27: //= 1427;
    case _COORD_SLIPPYMAP_28: //= 1428;
    case _COORD_SLIPPYMAP_29: //= 1429;
    case _COORD_SLIPPYMAP_30: //= 1430;
    case _COORD_GEOHASH: //= 15;
    case _COORD_GEO3X3: //= 16;
    case _COORD_GEOHEX: //= 17;
    case _COORD_OPEN_LOCATION_CODE: //= 18;
    case _COORD_MAKANEY: //= 19;
    case _COORD_QUADTREE: //= 20;
    case _COORD_REVERSE_WIG_WALDMEISTER: //= 21;
    case _COORD_REVERSE_WIG_DAY1976: //= 22;
      break;
    default:
      _handleError(_INVALIDCOORDINATEFORMAT);
  }

  List<String> targetCoord =
      formatCoordOutput(coord, CoordinateFormat(_GCW_SCRIPT_COORD_CONVERTER[source]!)).split('\n');
  _setlat(targetCoord[0] as double);
  _setlon(targetCoord[1] as double);
}

double _distance(Object x1, Object y1, Object x2, Object y2) {
  if (_isString(x1) || _isString(y1) || _isString(x2) || _isString(y2)) {
    _handleError(_INVALIDTYPECAST);
  }
  return distanceBearing(LatLng(x1 as double, y1 as double), LatLng(x2 as double, y2 as double),
          const Ellipsoid(ELLIPSOID_NAME_WGS84, 6378137.0, 298.257223563))
      .distance;
}

double _bearing(Object x1, Object y1, Object x2, Object y2) {
  if (_isString(x1) || _isString(y1) || _isString(x2) || _isString(y2)) {
    _handleError(_INVALIDTYPECAST);
  }
  return distanceBearing(LatLng(x1 as double, y1 as double), LatLng(x2 as double, y2 as double), defaultEllipsoid)
      .bearingAToB;
}

void _projection(Object x1, Object y1, Object dist, Object angle) {
  if (_isString(x1) || _isString(y1) || _isString(dist) || _isString(angle)) {
    _handleError(_INVALIDTYPECAST);
  }
  LatLng _currentValues =
      projection(LatLng(x1 as double, y1 as double), angle as double, dist as double, defaultEllipsoid);
  _state.GCWizardScript_LAT = _currentValues.latitude;
  _state.GCWizardScript_LON = _currentValues.longitude;
}

void _centerthreepoints(Object lat1, Object lon1, Object lat2, Object lon2, Object lat3, Object lon3) {
  if (_isString(lat1) || _isString(lon1) || _isString(lat2) || _isString(lon2) || _isString(lat3) || _isString(lon3)) {
    _handleError(_INVALIDTYPECAST);
    return;
  }

  double yDelta_a = (lat2 as double) - (lat1 as double);
  double xDelta_a = (lon2 as double) - (lon1 as double);
  double yDelta_b = (lat3 as double) - (lat2);
  double xDelta_b = (lon3 as double) - (lon2);

  double aSlope = yDelta_a / xDelta_a;
  double bSlope = yDelta_b / xDelta_b;

  _state.GCWizardScript_LON =
      (aSlope * bSlope * (lat1 - lat3) + bSlope * (lon1 + lon2) - aSlope * (lon2 + lon3)) / (2 * (bSlope - aSlope));
  _state.GCWizardScript_LAT = -1 * (_state.GCWizardScript_LON - (lon1 + lon2) / 2) / aSlope + (lat1 + lat2) / 2;
}

void _centertwopoints(Object lat1, Object lon1, Object lat2, Object lon2) {
  if (_isString(lat1) || _isString(lon1) || _isString(lat2) || _isString(lon2)) {
    _handleError(_INVALIDTYPECAST);
    return;
  }
  CenterPointDistance coord = centerPointTwoPoints(
      LatLng(lat1 as double, lon1 as double), LatLng(lat2 as double, lon2 as double), defaultEllipsoid);
  _state.GCWizardScript_LAT = coord.centerPoint.latitude;
  _state.GCWizardScript_LON = coord.centerPoint.longitude;
}
