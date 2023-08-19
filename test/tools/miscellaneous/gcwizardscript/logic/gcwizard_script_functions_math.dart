part of 'gcwizard_scipt_test.dart';

List<Map<String, Object?>> _inputsMathToExpected = [
  {'code' : 'print 2 * 3', 'expectedOutput' : '6'},
  {'code' : 'print 3 - 1', 'expectedOutput' : '2'},
  {'code' : 'print 6 / 3', 'expectedOutput' : '2.0'},
  {'code' : 'print 2 + 3', 'expectedOutput' : '5'},
  {'code' : 'print 2.0 * 3', 'expectedOutput' : '6.0'},

  {'code' : 'print MOD(11, 3)', 'expectedOutput' : '2'},
  {'code' : 'print MOD(11.0, 3)', 'expectedOutput' : '2.0'},
  {'code' : 'print MOD(11.0, 3.0)', 'expectedOutput' : '2.0'},
  {'code' : 'print MOD(11, 3.0)', 'expectedOutput' : '2.0'},
  {'code' : 'print MOD(X, 3)', 'expectedOutput' : '0'},
  {'code' : 'print MOD(11, X)', 'expectedOutput' : '0', 'error': 'gcwizard_script_division_by_zero'},
  {'code' : 'print MOD(, X)', 'expectedOutput' : '0', 'error': 'gcwizard_script_casting_error'},
  {'code' : 'print MOD(11, )', 'expectedOutput' : '0', 'error': 'gcwizard_script_casting_error'},
  {'code' : 'print MOD(11)', 'expectedOutput' : '0', 'error': 'gcwizard_script_casting_error'},
  {'code' : 'print MOD(11, 0)', 'expectedOutput' : '0', 'error': 'gcwizard_script_division_by_zero'},
  {'code' : 'print MOD(11, 3, 2)', 'expectedOutput' : '0.0', 'error': 'gcwizard_script_syntax_error'},

  {'code' : 'print SGN(11)', 'expectedOutput' : '1'},
  {'code' : 'print SGN(11.0)', 'expectedOutput' : '1'},
  {'code' : 'print SGN(-11)', 'expectedOutput' : '-1'},
  {'code' : 'print SGN(0)', 'expectedOutput' : '0'},
  {'code' : 'print SGN(-0)', 'expectedOutput' : '0'},
  {'code' : 'print SGN(X)', 'expectedOutput' : '0'},
  {'code' : 'print SGN( )', 'expectedOutput' : '0', 'error': 'gcwizard_script_casting_error'},
  {'code' : 'print SGN(11, 2, 1)', 'expectedOutput' : '0.0', 'error': 'gcwizard_script_casting_error'},

  {'code' : 'print PI()', 'expectedOutput' : '3.141592653589793'},
  {'code' : 'print PI', 'expectedOutput' : '0'},
  {'code' : 'print PI(x)', 'expectedOutput' : '', 'error': 'gcwizard_script_syntax_error'},

  {'code' : 'print TRUNC(3)', 'expectedOutput' : '3'},
  {'code' : 'print TRUNC(3.6)', 'expectedOutput' : '3'},
  {'code' : 'print TRUNC(-2)', 'expectedOutput' : '-2'},
  {'code' : 'print TRUNC(-2.6)', 'expectedOutput' : '-2'},
  {'code' : 'print TRUNC(-2.6, 5)', 'expectedOutput' : '0.0', 'error': 'gcwizard_script_syntax_error'},
  {'code' : 'print TRUNC( )', 'expectedOutput' : '0', 'error': 'gcwizard_script_casting_error'},
  {'code' : 'print TRUNC(X)', 'expectedOutput' : '0'},

  {'code' : 'print GGT(12, 3)', 'expectedOutput' : '3'},
  {'code' : 'print GGT(12.6, 3)', 'expectedOutput' : '3'},
  {'code' : 'print GGT(11, 3)', 'expectedOutput' : '1'},
  {'code' : 'print GGT(3, 11)', 'expectedOutput' : '1'},
  {'code' : 'print GGT(12.0, 3)', 'expectedOutput' : '3'},
  {'code' : 'print GGT(12.0, 3.0)', 'expectedOutput' : '3'},
  {'code' : 'print GGT(0, 3)', 'expectedOutput' : '3'},
  {'code' : 'print GGT(12, 0)', 'expectedOutput' : '12'},
  {'code' : 'print GGT( )', 'expectedOutput' : '0', 'error': 'gcwizard_script_casting_error'},
  {'code' : 'print GGT(3 )', 'expectedOutput' : '0', 'error': 'gcwizard_script_casting_error'},
  {'code' : 'print GGT(X, 3)', 'expectedOutput' : '3'},
  {'code' : 'print GGT(11, X)', 'expectedOutput' : '11'},
  {'code' : 'print GGT(X, X)', 'expectedOutput' : '0'},
  {'code' : 'print GGT(11, )', 'expectedOutput' : '0', 'error': 'gcwizard_script_casting_error'},

  {'code' : 'print KGV(12, 3)', 'expectedOutput' : '12.0'},
  {'code' : 'print KGV(12.6, 3)', 'expectedOutput' : '12.6'},
  {'code' : 'print KGV(11, 3)', 'expectedOutput' : '33.0'},
  {'code' : 'print KGV(3, 11)', 'expectedOutput' : '33.0'},
  {'code' : 'print KGV(12.0, 3)', 'expectedOutput' : '12.0'},
  {'code' : 'print KGV(12.0, 3.0)', 'expectedOutput' : '12.0'},
  {'code' : 'print KGV(0, 3)', 'expectedOutput' : '0.0'},
  {'code' : 'print KGV(12, 0)', 'expectedOutput' : '0.0'},
  {'code' : 'print KGV( )', 'expectedOutput' : '0', 'error': 'gcwizard_script_casting_error'},
  {'code' : 'print KGV(3 )', 'expectedOutput' : '0', 'error': 'gcwizard_script_casting_error'},
  {'code' : 'print KGV(X, 3)', 'expectedOutput' : '0.0'},
  {'code' : 'print KGV(11, X)', 'expectedOutput' : '0.0'},
  {'code' : 'print KGV(X, X)', 'expectedOutput' : 'NaN'},
  {'code' : 'print KGV(11, )', 'expectedOutput' : '0', 'error': 'gcwizard_script_casting_error'},

  {'code' : 'print FAC(3)', 'expectedOutput' : '6'},
  {'code' : 'print FAC(3.6)', 'expectedOutput' : '0', 'error': 'gcwizard_script_casting_error'},
  {'code' : 'print FAC(-2)', 'expectedOutput' : '1'},
  {'code' : 'print FAC(-2.6)', 'expectedOutput' : '0', 'error': 'gcwizard_script_casting_error'},
  {'code' : 'print FAC(-2.6, 5)', 'expectedOutput' : '0.0', 'error': 'gcwizard_script_syntax_error'},
  {'code' : 'print FAC( )', 'expectedOutput' : '0', 'error': 'gcwizard_script_casting_error'},
  {'code' : 'print FAC(X)', 'expectedOutput' : '0'},

  {'code' : 'print FRAC(3)', 'expectedOutput' : '0'},
  {'code' : 'print FRAC(3.6)', 'expectedOutput' : '0.6000000000000001'},
  {'code' : 'print FRAC(-2)', 'expectedOutput' : '0'},
  {'code' : 'print FRAC(-2.6)', 'expectedOutput' : '-0.6000000000000001'},
  {'code' : 'print FRAC(-2.6, 5)', 'expectedOutput' : '0.0', 'error': 'gcwizard_script_syntax_error'},
  {'code' : 'print FRAC( )', 'expectedOutput' : '0', 'error': 'gcwizard_script_casting_error'},
  {'code' : 'print FRAC(X)', 'expectedOutput' : '0'},

  {'code' : 'print SIN(0)', 'expectedOutput' : '0.0'},
  {'code' : 'print SIN(PI()/2)', 'expectedOutput' : '1.0'}, //ToDo problem
  {'code' : 'print SIN(1.570796327)', 'expectedOutput' : '1.0'},
  {'code' : 'print SIN(-2)', 'expectedOutput' : '-0.9092974268256817'},
  {'code' : 'print SIN(-2.6)', 'expectedOutput' : '-0.5155013718214642'},
  {'code' : 'print SIN(-2.6, 5)', 'expectedOutput' : '0.0', 'error': 'gcwizard_script_syntax_error'},
  {'code' : 'print SIN( )', 'expectedOutput' : '0.0', 'error': 'gcwizard_script_casting_error'},
  {'code' : 'print SIN(X)', 'expectedOutput' : '0.0'},

  {'code' : 'print ASIN(0)', 'expectedOutput' : '0.0'},
  {'code' : 'print ASIN(1)', 'expectedOutput' : '1.5707963267948966'},
  {'code' : 'print ASIN(PI()/2)', 'expectedOutput' : 'NaN'}, //ToDo problem
  {'code' : 'print ASIN(1.570796327)', 'expectedOutput' : 'NaN'},
  {'code' : 'print ASIN(-2)', 'expectedOutput' : 'NaN'},
  {'code' : 'print ASIN(-2.6)', 'expectedOutput' : 'NaN'},
  {'code' : 'print ASIN(-2.6, 5)', 'expectedOutput' : '0.0', 'error': 'gcwizard_script_syntax_error'},
  {'code' : 'print ASIN( )', 'expectedOutput' : '0.0', 'error': 'gcwizard_script_casting_error'},
  {'code' : 'print ASIN(X)', 'expectedOutput' : '0.0'},

  {'code' : 'print COS(0)', 'expectedOutput' : '1.0'},
  {'code' : 'print COS(PI()/2)', 'expectedOutput' : '-2.0510342851533115e-10'}, //ToDo problem
  {'code' : 'print COS(1.570796327)', 'expectedOutput' : '-2.0510342851533115e-10'},
  {'code' : 'print COS(-2)', 'expectedOutput' : '-0.4161468365471424'},
  {'code' : 'print COS(-2.6)', 'expectedOutput' : '-0.8568887533689473'},
  {'code' : 'print COS(-2.6, 5)', 'expectedOutput' : '0.0', 'error': 'gcwizard_script_syntax_error'},
  {'code' : 'print COS( )', 'expectedOutput' : '0.0', 'error': 'gcwizard_script_casting_error'},
  {'code' : 'print COS(X)', 'expectedOutput' : '1.0'},

  {'code' : 'print ACOS(0)', 'expectedOutput' : '1.5707963267948966'},
  {'code' : 'print ACOS(PI()/2)', 'expectedOutput' : 'NaN'}, //ToDo problem
  {'code' : 'print ACOS(1.570796327)', 'expectedOutput' : 'NaN'},
  {'code' : 'print ACOS(-2)', 'expectedOutput' : 'NaN'},
  {'code' : 'print ACOS(-2.6)', 'expectedOutput' : 'NaN'},
  {'code' : 'print ACOS(-2.6, 5)', 'expectedOutput' : '0.0', 'error': 'gcwizard_script_syntax_error'},
  {'code' : 'print ACOS( )', 'expectedOutput' : '0.0', 'error': 'gcwizard_script_casting_error'},
  {'code' : 'print ACOS(X)', 'expectedOutput' : '1.5707963267948966'},

  {'code' : 'print TAN(0)', 'expectedOutput' : '0.0'},
  {'code' : 'print TAN(PI()/2)', 'expectedOutput' : '-4875588902.821542'}, //ToDo problem
  {'code' : 'print TAN(1.570796327)', 'expectedOutput' : '-4875588902.821542'},
  {'code' : 'print TAN(-2)', 'expectedOutput' : '2.185039863261519'},
  {'code' : 'print TAN(-2.6)', 'expectedOutput' : '0.6015966130897586'},
  {'code' : 'print TAN(-2.6, 5)', 'expectedOutput' : '0.0', 'error': 'gcwizard_script_syntax_error'},
  {'code' : 'print TAN( )', 'expectedOutput' : '0.0', 'error': 'gcwizard_script_casting_error'},
  {'code' : 'print TAN(X)', 'expectedOutput' : '0.0'},

  {'code' : 'print ATAN(0)', 'expectedOutput' : '0.0'},
  {'code' : 'print ATAN(PI()/2)', 'expectedOutput' : '1.0038848219130392'}, //ToDo problem
  {'code' : 'print ATAN(1.570796327)', 'expectedOutput' : '1.0038848219130392'},
  {'code' : 'print ATAN(-2)', 'expectedOutput' : '-1.1071487177940904'},
  {'code' : 'print ATAN(-2.6)', 'expectedOutput' : '-1.2036224929766774'},
  {'code' : 'print ATAN(-2.6, 5)', 'expectedOutput' : '0.0', 'error': 'gcwizard_script_syntax_error'},
  {'code' : 'print ATAN( )', 'expectedOutput' : '0.0', 'error': 'gcwizard_script_casting_error'},
  {'code' : 'print ATAN(X)', 'expectedOutput' : '0.0'},

  {'code' : 'print EXP(0)', 'expectedOutput' : '1.0'},
  {'code' : 'print EXP(1)', 'expectedOutput' : '2.718281828459045'},
  {'code' : 'print EXP(-2)', 'expectedOutput' : '0.1353352832366127'},
  {'code' : 'print EXP(-2.6)', 'expectedOutput' : '0.07427357821433388'},
  {'code' : 'print EXP(-2.6, 5)', 'expectedOutput' : '0.0', 'error': 'gcwizard_script_syntax_error'},
  {'code' : 'print EXP( )', 'expectedOutput' : '0.0', 'error': 'gcwizard_script_casting_error'},
  {'code' : 'print EXP(X)', 'expectedOutput' : '1.0'},

  {'code' : 'print LOG(0)', 'expectedOutput' : '-Infinity'},
  {'code' : 'print LOG(1)', 'expectedOutput' : '0.0'},
  {'code' : 'print LOG(-2)', 'expectedOutput' : 'NaN'},
  {'code' : 'print LOG(-2.6)', 'expectedOutput' : 'NaN'},
  {'code' : 'print LOG(-2.6, 5)', 'expectedOutput' : '0.0', 'error': 'gcwizard_script_syntax_error'},
  {'code' : 'print LOG( )', 'expectedOutput' : '0.0', 'error': 'gcwizard_script_casting_error'},
  {'code' : 'print LOG(X)', 'expectedOutput' : '-Infinity'},

  {'code' : 'print LN(0)', 'expectedOutput' : '-Infinity'},
  {'code' : 'print LN(1)', 'expectedOutput' : '0.0'},
  {'code' : 'print LN(2)', 'expectedOutput' : '0.6931471805599453'},
  {'code' : 'print LN(-2)', 'expectedOutput' : 'NaN'},
  {'code' : 'print LN(-2.6)', 'expectedOutput' : 'NaN'},
  {'code' : 'print LN(-2.6, 5)', 'expectedOutput' : '0.0', 'error': 'gcwizard_script_syntax_error'},
  {'code' : 'print LN( )', 'expectedOutput' : '0.0', 'error': 'gcwizard_script_casting_error'},
  {'code' : 'print LN(X)', 'expectedOutput' : '-Infinity'},

  {'code' : 'print SQRT(0)', 'expectedOutput' : '0.0'},
  {'code' : 'print SQRT(1)', 'expectedOutput' : '1.0'},
  {'code' : 'print SQRT(2)', 'expectedOutput' : '1.4142135623730951'},
  {'code' : 'print SQRT(-2)', 'expectedOutput' : 'NaN'},
  {'code' : 'print SQRT(-2.6)', 'expectedOutput' : 'NaN'},
  {'code' : 'print SQRT(-2.6, 5)', 'expectedOutput' : '0.0', 'error': 'gcwizard_script_syntax_error'},
  {'code' : 'print SQRT( )', 'expectedOutput' : '0.0', 'error': 'gcwizard_script_casting_error'},
  {'code' : 'print SQRT(X)', 'expectedOutput' : '0.0'},

  {'code' : 'print SQR(0)', 'expectedOutput' : '0'},
  {'code' : 'print SQR(1)', 'expectedOutput' : '1'},
  {'code' : 'print SQR(2)', 'expectedOutput' : '4'},
  {'code' : 'print SQR(-2)', 'expectedOutput' : '4'},
  {'code' : 'print SQR(-2.6)', 'expectedOutput' : '6.760000000000001'},
  {'code' : 'print SQR(-2.6, 5)', 'expectedOutput' : '0.0', 'error': 'gcwizard_script_syntax_error'},
  {'code' : 'print SQR( )', 'expectedOutput' : '0', 'error': 'gcwizard_script_casting_error'},
  {'code' : 'print SQR(X)', 'expectedOutput' : '0.0'},

  {'code' : 'print DEG(0)', 'expectedOutput' : '0.0'},
  {'code' : 'print DEG(1)', 'expectedOutput' : '57.29577951308232'},
  {'code' : 'print DEG(2)', 'expectedOutput' : '114.59155902616465'},
  {'code' : 'print DEG(-2)', 'expectedOutput' : '-114.59155902616465'},
  {'code' : 'print DEG(-2.6)', 'expectedOutput' : '-148.96902673401405'},
  {'code' : 'print DEG(2*PI())', 'expectedOutput' : '360.0'},
  {'code' : 'print DEG(PI())', 'expectedOutput' : '180.0'},
  {'code' : 'print DEG(PI()/2)', 'expectedOutput' : '90.0'},
  {'code' : 'print DEG(-2.6, 5)', 'expectedOutput' : '0.0', 'error': 'gcwizard_script_syntax_error'},
  {'code' : 'print DEG( )', 'expectedOutput' : '0.0', 'error': 'gcwizard_script_casting_error'},
  {'code' : 'print DEG(X)', 'expectedOutput' : '0.0'},

  {'code' : 'print RAD(0)', 'expectedOutput' : '0.0'},
  {'code' : 'print RAD(57.29577951308232)', 'expectedOutput' : '1.0'},
  {'code' : 'print RAD(114.59155902616465)', 'expectedOutput' : '2.0'},
  {'code' : 'print RAD(-114.59155902616465)', 'expectedOutput' : '-2.0'},
  {'code' : 'print RAD(-148.96902673401405)', 'expectedOutput' : '-2.6000000000000005'},
  {'code' : 'print RAD(360)', 'expectedOutput' : '6.283185307179586'},
  {'code' : 'print RAD(180)', 'expectedOutput' : '3.141592653589793'},
  {'code' : 'print RAD(90.0)', 'expectedOutput' : '1.5707963267948966'},
  {'code' : 'print RAD(-2.6, 5)', 'expectedOutput' : '0.0', 'error': 'gcwizard_script_syntax_error'},
  {'code' : 'print RAD( )', 'expectedOutput' : '0.0', 'error': 'gcwizard_script_casting_error'},
  {'code' : 'print RAD(X)', 'expectedOutput' : '0.0'},

  {'code' : 'print RND(0)', 'expectedOutput' : '0.0'},
  {'code' : 'print RND(-2.6, 5)', 'expectedOutput' : '0.0', 'error': 'gcwizard_script_syntax_error'},
  {'code' : 'print RND( )', 'expectedOutput' : '0.0', 'error': 'gcwizard_script_casting_error'},
  {'code' : 'print RND(X)', 'expectedOutput' : '0.0'},

  {'code' : 'print CEIL(0)', 'expectedOutput' : '0'},
  {'code' : 'print CEIL(1)', 'expectedOutput' : '1'},
  {'code' : 'print CEIL(2.0)', 'expectedOutput' : '2'},
  {'code' : 'print CEIL(2.3)', 'expectedOutput' : '3'},
  {'code' : 'print CEIL(2.8)', 'expectedOutput' : '3'},
  {'code' : 'print CEIL(-2)', 'expectedOutput' : '-2'},
  {'code' : 'print CEIL(-2.6)', 'expectedOutput' : '-2'},
  {'code' : 'print CEIL(-2.6, 5)', 'expectedOutput' : '0.0', 'error': 'gcwizard_script_syntax_error'},
  {'code' : 'print CEIL( )', 'expectedOutput' : '0', 'error': 'gcwizard_script_casting_error'},
  {'code' : 'print CEIL(X)', 'expectedOutput' : '0'},

  {'code' : 'print FLOOR(0)', 'expectedOutput' : '0'},
  {'code' : 'print FLOOR(1)', 'expectedOutput' : '1'},
  {'code' : 'print FLOOR(2.0)', 'expectedOutput' : '2'},
  {'code' : 'print FLOOR(2.3)', 'expectedOutput' : '2'},
  {'code' : 'print FLOOR(2.8)', 'expectedOutput' : '2'},
  {'code' : 'print FLOOR(-2)', 'expectedOutput' : '-2'},
  {'code' : 'print FLOOR(-2.6)', 'expectedOutput' : '-3'},
  {'code' : 'print FLOOR(-2.6, 5)', 'expectedOutput' : '0.0', 'error': 'gcwizard_script_syntax_error'},
  {'code' : 'print FLOOR( )', 'expectedOutput' : '0', 'error': 'gcwizard_script_casting_error'},
  {'code' : 'print FLOOR(X)', 'expectedOutput' : '0'},

  {'code' : 'print ABS(0)', 'expectedOutput' : '0'},
  {'code' : 'print ABS(1)', 'expectedOutput' : '1'},
  {'code' : 'print ABS(2.0)', 'expectedOutput' : '2.0'},
  {'code' : 'print ABS(2.3)', 'expectedOutput' : '2.3'},
  {'code' : 'print ABS(2.8)', 'expectedOutput' : '2.8'},
  {'code' : 'print ABS(-2)', 'expectedOutput' : '2'},
  {'code' : 'print ABS(-2.6)', 'expectedOutput' : '2.6'},
  {'code' : 'print ABS(-2.6, 5)', 'expectedOutput' : '0.0', 'error': 'gcwizard_script_syntax_error'},
  {'code' : 'print ABS( )', 'expectedOutput' : '0', 'error': 'gcwizard_script_casting_error'},
  {'code' : 'print ABS(X)', 'expectedOutput' : '0'},

  {'code' : 'print POW(12, 3)', 'expectedOutput' : '1728'},
  {'code' : 'print POW(12.6, 3)', 'expectedOutput' : '2000.3759999999997'},
  {'code' : 'print POW(11, 3)', 'expectedOutput' : '1331'},
  {'code' : 'print POW(3, 11)', 'expectedOutput' : '177147'},
  {'code' : 'print POW(12.0, 3)', 'expectedOutput' : '1728.0'},
  {'code' : 'print POW(12.0, 3.0)', 'expectedOutput' : '1728.0'},
  {'code' : 'print POW(0, 3)', 'expectedOutput' : '0'},
  {'code' : 'print POW(12, 0)', 'expectedOutput' : '1'},
  {'code' : 'print POW( )', 'expectedOutput' : '0', 'error': 'gcwizard_script_casting_error'},
  {'code' : 'print POW(3 )', 'expectedOutput' : '0', 'error': 'gcwizard_script_casting_error'},
  {'code' : 'print POW(X, 3)', 'expectedOutput' : '0'},
  {'code' : 'print POW(11, X)', 'expectedOutput' : '1'},
  {'code' : 'print POW(X, X)', 'expectedOutput' : '1'},
  {'code' : 'print POW(11, )', 'expectedOutput' : '0', 'error': 'gcwizard_script_casting_error'},

  {'code' : 'print QSUM(0)', 'expectedOutput' : '0'},
  {'code' : 'print QSUM(1)', 'expectedOutput' : '1'},
  {'code' : 'print QSUM(2.0)', 'expectedOutput' : '2'},
  {'code' : 'print QSUM(2.3)', 'expectedOutput' : '5'},
  {'code' : 'print QSUM(2.8)', 'expectedOutput' : '10'},
  {'code' : 'print QSUM(-2)', 'expectedOutput' : '2'},
  {'code' : 'print QSUM(-2.65)', 'expectedOutput' : '13'},
  {'code' : 'print QSUM(-2.6, 5)', 'expectedOutput' : '0.0', 'error': 'gcwizard_script_syntax_error'},
  {'code' : 'print QSUM( )', 'expectedOutput' : '0', 'error': 'gcwizard_script_casting_error'},
  {'code' : 'print QSUM(X)', 'expectedOutput' : '0'},

  {'code' : 'print IQSUM(0)', 'expectedOutput' : '0'},
  {'code' : 'print IQSUM(1)', 'expectedOutput' : '1'},
  {'code' : 'print IQSUM(2.0)', 'expectedOutput' : '2'},
  {'code' : 'print IQSUM(2.3)', 'expectedOutput' : '5'},
  {'code' : 'print IQSUM(2.8)', 'expectedOutput' : '1'},
  {'code' : 'print IQSUM(-2)', 'expectedOutput' : '2'},
  {'code' : 'print IQSUM(-2.65)', 'expectedOutput' : '4'},
  {'code' : 'print IQSUM(-2.6, 5)', 'expectedOutput' : '0.0', 'error': 'gcwizard_script_syntax_error'},
  {'code' : 'print IQSUM( )', 'expectedOutput' : '0', 'error': 'gcwizard_script_casting_error'},
  {'code' : 'print IQSUM(X)', 'expectedOutput' : '0'},

  {'code' : 'print CONVERT("42.42", 10, 2)', 'expectedOutput' : '101010.01101011100001010001111010111000010100011110101110'},
  {'code' : 'print CONVERT("42.42", 10, 3)', 'expectedOutput' : '1120.10210001121201222110102100011212012200021021220011'},
  {'code' : 'print CONVERT("42.42", 10, 4)', 'expectedOutput' : '222.122320110132232011013223201'},
  {'code' : 'print CONVERT("42.42", 10, 5)', 'expectedOutput' : '132.20222222222222222222222323441102400343013402001133'},
  {'code' : 'print CONVERT("42.42", 10, 6)', 'expectedOutput' : '110.23041530415304153041533020313211140055225054411010'},
  {'code' : 'print CONVERT("42.42", 10, 7)', 'expectedOutput' : '60.26402640264026402640351514150053441365564663223526'},
  {'code' : 'print CONVERT("42.42", 10, 8)', 'expectedOutput' : '52.327024365605075341'},
  {'code' : 'print CONVERT("42.42", 10, 9)', 'expectedOutput' : '46.37015518733701551465724800440338241104884421633301'},
  {'code' : 'print CONVERT("42.42", 10, 10)', 'expectedOutput' : '42.42'},
  {'code' : 'print CONVERT("a", 16, 10)', 'expectedOutput' : '10'},
];