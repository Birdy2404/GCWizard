part of 'package:gc_wizard/tools/miscellaneous/gcwizardscript/logic/gcwizard_script.dart';

int _sgn(Object? x) {
  if (_isNotANumber(x)) {
    _handleError(_INVALIDTYPECAST);
    return 0;
  } else if (x as num == 0) {
    return 0;
  } else if (x > 0) {
    return 1;
  } else {
    return -1;
  }
}

num _mod(Object? x, Object? y) {
  num result = 0;
  if (_isNotANumber(x) || _isNotANumber(y)) {
    _handleError(_INVALIDTYPECAST);
  } else
  if (y == 0) {
    _handleError(_DIVISIONBYZERO);
  } else {
    result = ((x as num) % (y as num));
  }
  return result;
}

double _sqrt(Object? x) {
  if (!_isANumber(x)) {
    _handleError(_INVALIDTYPECAST);
    return 0;
  }
  return sqrt(x as num);
}

num _sqr(Object? x) {
  if (!_isANumber(x)) {
    _handleError(_INVALIDTYPECAST);
    return 0;
  }
  return ((x as num) * x);
}

double _exp(Object? x) {
  if (!_isANumber(x)) {
    _handleError(_INVALIDTYPECAST);
    return 0;
  }
  return exp(x as num);
}

double _sin(Object? x) {
  if (!_isANumber(x)) {
    _handleError(_INVALIDTYPECAST);
    return 0;
  }
  return sin(x as num);
}

double _cos(Object? x) {
  if (!_isANumber(x)) {
    _handleError(_INVALIDTYPECAST);
    return 0;
  }
  return cos(x as num);
}

double _tan(Object? x) {
  if (!_isANumber(x)) {
    _handleError(_INVALIDTYPECAST);
    return 0;
  }
  return tan(x as num);
}

double _asin(Object? x) {
  if (!_isANumber(x)) {
    _handleError(_INVALIDTYPECAST);
    return 0;
  }
  return asin(x as num);
}

double _acos(Object? x) {
  if (!_isANumber(x)) {
    _handleError(_INVALIDTYPECAST);
    return 0;
  }
  return acos(x as num);
}

double _atan(Object? x) {
  if (!_isANumber(x)) {
    _handleError(_INVALIDTYPECAST);
    return 0;
  }
  return atan(x as num);
}

double _deg(Object? radian) {
  if (!_isANumber(radian)) {
    _handleError(_INVALIDTYPECAST);
    return 0;
  }
  return (radian as num) * 180 / pi;
}

double _rad(Object? degree) {
  if (!_isANumber(degree)) {
    _handleError(_INVALIDTYPECAST);
    return 0;
  }
  return (degree as num) * pi / 180;
}

int _ceil(Object? x) {
  if (!_isANumber(x)) {
    _handleError(_INVALIDTYPECAST);
    return 0;
  }
  return (x as num).ceil();
}

int _floor(Object? x) {
  if (!_isANumber(x)) {
    _handleError(_INVALIDTYPECAST);
    return 0;
  }
  return (x as num).floor();
}

double _ln(Object? x) {
  if (!_isANumber(x)) {
    _handleError(_INVALIDTYPECAST);
    return 0;
  }
  return log(x as num);
}

double _log10(Object? x) {
  if (!_isANumber(x)) {
    _handleError(_INVALIDTYPECAST);
    return 0;
  }
  return log(x as num) / log(10);
}

double _pi() {
  return pi;
}

double _rnd(Object? x) {
  if (!_isANumber(x)) {
    _handleError(_INVALIDTYPECAST);
    return 0;
  }

  if (x != 0) {
    _state.randomNumber = _random.nextDouble();
    return _state.randomNumber;
  } else {
    return _state.randomNumber;
  }
}

int _fac(Object? x) {
  if (_isNotAInt(x)) {
    _handleError(_INVALIDTYPECAST);
    return 0;
  }

  int result = 1;
  for (int i = 1; i <= (x as num).toInt(); i++) {
    result *= i;
  }
  return result;
}

num _frac(Object? x) {
  if (!_isANumber(x)) {
    _handleError(_INVALIDTYPECAST);
    return 0;
  }
  return ((x as num) - x.truncate());
}

int _trunc(Object? x) {
  if (!_isANumber(x)) {
    _handleError(_INVALIDTYPECAST);
    return 0;
  }
  return (x as num).truncate();
}

num _abs(Object? x) {
  if (!_isANumber(x)) {
    _handleError(_INVALIDTYPECAST);
    return 0;
  }
  return (x as num).abs();
}

num _pow(Object? x, Object? y) {
  if (!_isANumber(x) || !_isANumber(y)) {
    _handleError(_INVALIDTYPECAST);
    return 0;
  }
  return pow(x as num, y as num);
}

int _qsum(Object? x) {
  if (!_isANumber(x)) {
    _handleError(_INVALIDTYPECAST);
    return 0;
  }
  int result = 0;
  x.toString().split('').forEach((digit) {
    result += _isADigit(digit) ? int.parse(digit) : 0;
  });
  return result;
}

int _iqsum(Object? x) {
  if (!_isANumber(x)) {
    _handleError(_INVALIDTYPECAST);
    return 0;
  }
  int result = _qsum(x);
  while (result.toString().length > 1) {
    result = _qsum(result);
  }
  return result;
}

int _ggt(Object? x, Object? y) {
  if (_isNotANumber(x) || _isNotANumber(y)) {
    _handleError(_INVALIDTYPECAST);
    return 0;
  } else {
    int h;

    if (x as num == 0) return (y as num).toInt().abs();
    if (y as num == 0) return x.toInt().abs();

    do {
      h = (x as num).toInt() % (y as num).toInt();
      x = y;
      y = h;
    } while (y != 0);

    return x.toInt().abs();
  }
}

num _kgv(Object? x, Object? y) {
  if (_isNotANumber(x) || _isNotANumber(y)) {
    _handleError(_INVALIDTYPECAST);
    return 0;
  }

  return (((x as num) * (y as num)).abs() / _ggt(x, y));
}

int _gcd(Object? x, Object? y) {
  if (!_isANumber(x) || !_isANumber(y)) {
    _handleError(_INVALIDTYPECAST);
    return 0;
  }
  int h;

  if (x as num == 0) return (y as num).toInt().abs();
  if (y as num == 0) return x.toInt().abs();

  do {
    h = (x as num).toInt() % (y as num).toInt();
    x = y;
    y = h;
  } while (y != 0);

  return x.toInt().abs();
}

num _lcm(Object? x, Object? y) {
  if (!_isANumber(x) || !_isANumber(y)) {
    _handleError(_INVALIDTYPECAST);
    return 0;
  }

  return (((x as num) * (y as num)).abs() / _ggt(x, y));
}

String _convertBase(Object? value, Object? startBase, Object? destinationBase) {
  if (_isANumber(value)) {
    value = value.toString();
  }
  if (_isNotAInt(startBase) || _isNotAInt(destinationBase)) {
    _handleError(_INVALIDTYPECAST);
    return '';
  }
  return convertBase(value as String, startBase as int, destinationBase as int);
}

int _isPrime(Object x){
  if (_isNotAInt(x)) {
    _handleError(_INVALIDTYPECAST);
    return -1;
  }
  if (isPrime(BigInt.from(x as int))) {
    return 1;
  }
  return 0;
}

double _round(Object? x, Object? y){
  if (_isNotANumber(x) || _isNotAInt(y)) {
    _handleError(_INVALIDTYPECAST);
    return 0;
  }
  return double.parse((x as double).toStringAsFixed(y as int));
}

int _isSqr(Object? x){
  if (_isNotAInt(x)) {
    _handleError(_INVALIDTYPECAST);
    return -1;
  }
  if (_frac(sqrt(x as num)) == 0) {
    return 1;
  }
  return 0;
}

int _div(Object? x, Object? y) {
  if (_isNotANumber(x) || _isNotANumber(y)) {
    _handleError(_INVALIDTYPECAST);
    return 0;
  }
  if (y == 0) {
    _handleError(_DIVISIONBYZERO);
    return 0;
  }
  return ((x as num) ~/ (y as num));
}

