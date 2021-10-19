import "package:flutter_test/flutter_test.dart";
import 'package:gc_wizard/logic/tools/crypto_and_encodings/homophone.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/substitution.dart';


void main() {
  group("Homophone.encrypt:", () {
    List<Map<String, dynamic>> _inputsToExpected = [

      {'input' : null, 'errorcode': ErrorCode.OK, 'keyType': KeyType.GENERATED, 'alphabet': Alphabet.alphabetGerman1, 'rotation': 1, 'multiplier': 1, 'ownKeys': '', 'expectedOutput' : ''},
      {'input' : '', 'errorcode': ErrorCode.OK, 'keyType': KeyType.GENERATED, 'alphabet': Alphabet.alphabetGerman1, 'rotation': 3, 'multiplier': 1, 'ownKeys': '', 'expectedOutput' : ''},

      {'input' : 'Test', 'errorcode': ErrorCode.OK, 'keyType': KeyType.GENERATED, 'alphabet': Alphabet.alphabetGerman1, 'rotation': 1, 'multiplier': 3, 'ownKeys': '', 'expectedOutput': '58 48 37 58'},
      {'input' : 'TEST', 'errorcode': ErrorCode.OK, 'keyType': KeyType.GENERATED, 'alphabet': Alphabet.alphabetEnglish1, 'rotation': 3, 'multiplier': 7, 'ownKeys': '', 'expectedOutput': '88 40 46 88'},
      {'input' : 'Test', 'errorcode': ErrorCode.OK, 'keyType': KeyType.GENERATED, 'alphabet': Alphabet.alphabetSpanish2, 'rotation': 6, 'multiplier': 99, 'ownKeys': '', 'expectedOutput': '07 72 15 07'},
      {'input' : 'КОНТРОЛЬНАЯ РАБОТА', 'errorcode': ErrorCode.OK, 'keyType': KeyType.GENERATED, 'alphabet': Alphabet.alphabetRussian1, 'rotation': 1, 'multiplier': 9, 'ownKeys': '', 'expectedOutput': '42 04 41 02 21 04 69 55 41 09 91 21 09 72 04 02 09'},

      {'input' : 'Test', 'errorcode': ErrorCode.OK, 'keyType': KeyType.OWN, 'alphabet': Alphabet.alphabetGerman1, 'rotation': 3, 'multiplier': 1,
        'ownKeys': '36 56 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 30 21 22 23 24 25 26 27 28 29 40 31 32 33 34 35 0 37 38 39 20 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 1 57 58 59 60 61 62 63 64 65 66 67 68 69 80 71 72 73 74 75 76 77 78 79 90 81 82 83 84 85 86 87 88 89 70 91 92 93 94 95 96 97 98 99',
        'expectedOutput': '85 15 78 85'},
      {'input' : 'Test', 'errorcode': ErrorCode.OWNKEYCOUNT, 'keyType': KeyType.OWN, 'alphabet': Alphabet.alphabetGerman1, 'rotation': 3, 'multiplier': 7,
        'ownKeys': '36 56 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 30 21 22 23 24 25 26 27 28 29 40 31 32 33 34 35 0 37 38 39 20 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 1 57 58 59 60 61 62 63 64 65 66 67 68 69 80 71 72 73 74 75 76 77 78 79 90 81 82 83 84 85 86 87 88 89 70 91 92 93 94 95 96 97 98 99 99',
        'expectedOutput': ''},
    ];

    _inputsToExpected.forEach((elem) {
      test('input: ${elem['input']}, keyType: ${elem['keyType']}, alphabet: ${elem['alphabet']}, rotation: ${elem['rotation']}, multiplier: ${elem['multiplier']}, ownKeys: ${elem['ownKeys']}', () {
        var _actual;
        _actual = encryptHomophone(elem['input'], elem['keyType'], elem['alphabet'], elem['rotation'], elem['multiplier'], elem['ownKeys']);
        Map<String, String> map ;
        if (elem['keyType'] == KeyType.OWN)
          map = replaceOwnMap(elem['ownKeys'], elem['alphabet']);
        else
          map = replaceMap(elem['rotation'], elem['multiplier'], elem['alphabet']);
        var output = changeOutput(_actual.output, map);
        expect(output, elem['expectedOutput']);
        expect(_actual.errorCode, elem['errorcode']);
      });
    });
  });

  group("Homophone.decrypt:", () {
    List<Map<String, dynamic>> _inputsToExpected = [
      {'input' : null, 'errorcode': ErrorCode.OK, 'keyType': KeyType.GENERATED, 'alphabet': Alphabet.alphabetGerman1, 'rotation': 1, 'multiplier': 1, 'ownKeys': '', 'expectedOutput' : ''},
      {'input' : '', 'errorcode': ErrorCode.OK, 'keyType': KeyType.GENERATED, 'alphabet': Alphabet.alphabetGerman1, 'rotation': 3, 'multiplier': 1, 'ownKeys': '', 'expectedOutput' : ''},
      {'input' : 'T', 'errorcode': ErrorCode.OK, 'keyType': KeyType.GENERATED, 'alphabet': Alphabet.alphabetGerman1, 'rotation': 3, 'multiplier': 1, 'ownKeys': '', 'expectedOutput' : ''},

      {'expectedOutput' : 'TEST', 'errorcode': ErrorCode.OK, 'keyType': KeyType.GENERATED, 'alphabet': Alphabet.alphabetGerman1, 'rotation': 3, 'multiplier': 1, 'ownKeys': '', 'input': '93 24 86 88'},
      {'expectedOutput' : 'TEST', 'errorcode': ErrorCode.OK, 'keyType': KeyType.GENERATED, 'alphabet': Alphabet.alphabetEnglish1, 'rotation': 3, 'multiplier': 7, 'ownKeys': '', 'input': '30 03 74 09'},
      {'expectedOutput' : 'TEST', 'errorcode': ErrorCode.OK, 'keyType': KeyType.GENERATED, 'alphabet': Alphabet.alphabetSpanish2, 'rotation': 6, 'multiplier': 99, 'ownKeys': '', 'input': '05 67 15 06'},
      {'expectedOutput' : 'КОНТРОЛЬНАЯРАБОТА', 'errorcode': ErrorCode.OK, 'keyType': KeyType.GENERATED, 'alphabet': Alphabet.alphabetRussian1, 'rotation': 3, 'multiplier': 3, 'ownKeys': '', 'input': '20 95 65 55 19 77 32 91 65 24 06 13 21 30 95 52 18'},
      {'expectedOutput' : 'ΔΟΚΙΜ', 'errorcode': ErrorCode.OK, 'keyType': KeyType.GENERATED, 'alphabet': Alphabet.alphabetGreek1, 'rotation': 500, 'multiplier': 31, 'ownKeys': '', 'input': '27 60 64 54 19'},

      {'expectedOutput' : 'TEST', 'errorcode': ErrorCode.OK, 'keyType': KeyType.OWN, 'alphabet': Alphabet.alphabetGerman1, 'rotation': 3, 'multiplier': 1,
        'ownKeys': '36 56 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 40 21 22 23 24 25 26 27 28 29 40 31 32 33 34 35 0 37 38 39 20 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 1 57 58 59 60 61 62 63 64 65 66 67 68 69 80 71 72 73 74 75 76 77 78 79 90 81 82 83 84 85 86 87 88 89 70 91 92 93 94 95 96 97 98 99',
        'input': '70 27 81 89'},
      {'expectedOutput' : 'TEST', 'errorcode': ErrorCode.OK, 'keyType': KeyType.OWN, 'alphabet': Alphabet.alphabetGerman1, 'rotation': 3, 'multiplier': 7,
        'ownKeys': '36 56 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 30 21 22 23 24 25 26 27 28 29 40 31 32 33 34 35 0 37 38 39 20 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 1 57 58 59 60 61 62 63 64 65 66 67 68 69 80 71 72 73 74 75 76 77 78 79 90 81 82 83 84 85 86 87 88 89 70 91 92 93 94 95 96 97 98 99',
        'input': '70 27 81 89'},
      {'expectedOutput' : 'TEST', 'errorcode': ErrorCode.OK, 'keyType': KeyType.OWN, 'alphabet': Alphabet.alphabetGerman1, 'rotation': 3, 'multiplier': 7,
        'ownKeys': '36.56 2,3 4 5 6 7 8 9_10 11B12 13 14 15 16 17 18 19 30 21 22 23 24 25 26 27 28 29 40 31 32 33 34 35 0 37 38 39 20 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 1 57 58 59 60 61 62 63 64 65 66 67 68 69 80 71 72 73 74 75 76 77 78 79 90 81 82 83 84 85 86 87 88 89 70 91 92 93 94 95 96 97 98 99',
        'input': '70 27 81 89'},
      {'expectedOutput' : '', 'errorcode': ErrorCode.OWNKEYCOUNT, 'keyType': KeyType.OWN, 'alphabet': Alphabet.alphabetGerman1, 'rotation': 3, 'multiplier': 7,
        'ownKeys': '36 56 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 30 21 22 23 24 25 26 27 28 29 40 31 32 33 34 35 0 37 38 39 20 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 1 57 58 59 60 61 62 63 64 65 66 67 68 69 80 71 72 73 74 75 76 77 78 79 90 81 82 83 84 85 86 87 88 89 70 91 92 93 94 95 96 97 98 99 99',
        'input': '70 27 81 89'},
    ];

    _inputsToExpected.forEach((elem) {
      test('input: ${elem['input']}, keyType: ${elem['keyType']}, alphabet: ${elem['alphabet']}, rotation: ${elem['rotation']}, multiplier: ${elem['multiplier']}, ownKeys: ${elem['ownKeys']}', () {
        var _actual;
        _actual = decryptHomophone(elem['input'], elem['keyType'], elem['alphabet'], elem['rotation'], elem['multiplier'], elem['ownKeys']);
        expect(_actual.output, elem['expectedOutput']);
        expect(_actual.errorCode, elem['errorcode']);
      });
    });
  });
}

Map<String, String> fillMap(int startIndex, int count, int offset, Map<String, String> map){
  for (int i = 1; i <= count; ++i) {
    map.addAll({((startIndex + i * offset) % 100).toString().padLeft(2, '0'): startIndex.toString().padLeft(2, '0') });
  }
  
  return map;
}

Map<String, String> fillMapOwn(int startIndex, int startOffset, int count, int offset, Map<String, String> map){
  for (int i = 1; i <= count; ++i) {
    map.addAll({((startIndex+ startOffset + i * offset) % 100).toString().padLeft(2, '0'): startIndex.toString().padLeft(2, '0') });
  }

  return map;
}

// create substition Table
// to change random number to first number in the row
Map<String, String> replaceMap(int rotation, int multiplier, Alphabet alphabet){
  var map = Map<String, String>();

  switch (alphabet) {
    case Alphabet.alphabetGerman1:
      switch (rotation) {
        case 1:
          switch (multiplier) {
            case 3:
              var offset = multiplier;
              map = fillMap(3, 5, offset, map);
              map = fillMap(21, 1, offset, map);
              map = fillMap(21, 1, offset, map);
              map = fillMap(27, 1, offset, map);
              map = fillMap(33, 4, offset, map);
              map = fillMap(48, 16, offset, map);
              map = fillMap(99, 1, offset, map);
              map = fillMap(5, 2, offset, map);
              map = fillMap(14, 4, offset, map);
              map = fillMap(29, 7, offset, map);
              map = fillMap(59, 2, offset, map);
              map = fillMap(68, 1, offset, map);
              map = fillMap(74, 9, offset, map);
              map = fillMap(4, 1, offset, map);
              map = fillMap(16, 6, offset, map);
              map = fillMap(37, 6, offset, map);
              map = fillMap(58, 5, offset, map);
          };
      };
      break;
    case Alphabet.alphabetEnglish1:
      switch (rotation) {
        case 3:
          switch (multiplier) {
            case 7:
          var offset = multiplier;
            map = fillMap(21, 7, offset, map);
            map = fillMap(77, 1, offset, map);
            map = fillMap(91, 2, offset, map);
            map = fillMap(12, 3, offset, map);
            map = fillMap(40, 11, offset, map);
            map = fillMap(24, 1 , offset, map);
            map = fillMap(38, 1 , offset, map);
            map = fillMap(52, 5 , offset, map);
            map = fillMap(94, 5 , offset, map);
            map = fillMap(50, 3 , offset, map);
            map = fillMap(78, 1 , offset, map);
            map = fillMap(92, 5 , offset, map);
            map = fillMap(34, 6 , offset, map);
            map = fillMap(83, 1 , offset, map);
            map = fillMap(4, 5 , offset, map);
            map = fillMap(46, 5 , offset, map);
            map = fillMap(88, 8 , offset, map);
            map = fillMap(51, 2 , offset, map);
            map = fillMap(79, 1 , offset, map);
            map = fillMap(0, 1 , offset, map);
      };
  };
  break;
  case Alphabet.alphabetRussian1:
        switch (rotation){
          case 1:
            switch (multiplier) {
              case 9:
                var offset = multiplier;
                map = fillMap(09, 6, offset, map);
                map = fillMap(72, 1, offset, map);
                map = fillMap(90, 3, offset, map);
                map = fillMap(35, 2, offset, map);
                map = fillMap(62, 8, offset, map);
                map = fillMap(70, 6, offset, map);
                map = fillMap(42, 2, offset, map);
                map = fillMap(69, 4, offset, map);
                map = fillMap(14, 2, offset, map);
                map = fillMap(41, 6, offset, map);
                map = fillMap(04, 10,offset, map);
                map = fillMap(03, 1, offset, map);
                map = fillMap(21, 3, offset, map);
                map = fillMap(57, 4, offset, map);
                map = fillMap(02, 5, offset, map);
                map = fillMap(56, 1, offset, map);
                map = fillMap(37, 1, offset, map);
                map = fillMap(55, 1, offset, map);
                map = fillMap(91, 1, offset, map);
            };
        };
        break;
    case Alphabet.alphabetSpanish2:
      switch (rotation){
        case 6:
          switch (multiplier) {
            case 99:
              var offset = multiplier;
              map = fillMap(94, 11, offset, map);
              map = fillMap(81, 3 , offset, map);
              map = fillMap(77, 4 , offset, map);
              map = fillMap(72, 12, offset, map);
              map = fillMap(56, 5 , offset, map);
              map = fillMap(48, 4 , offset, map);
              map = fillMap(43, 2 , offset, map);
              map = fillMap(40, 5 , offset, map);
              map = fillMap(33, 7 , offset, map);
              map = fillMap(25, 1 , offset, map);
              map = fillMap(22, 6 ,offset, map);
              map = fillMap(15, 7 , offset, map);
              map = fillMap(07, 3 , offset, map);
              map = fillMap(03, 3 , offset, map);
          };
      };
      break;

    case Alphabet.alphabetGreek1:
      switch (rotation){
        case 500:
          switch (multiplier) {
            case 31:
              var offset = multiplier;
              map = fillMap(00, 12, offset, map);
              map = fillMap(34, 1 , offset, map);
              map = fillMap(96, 1 , offset, map);
              map = fillMap(58, 8 , offset, map);
              map = fillMap(68, 4 , offset, map);
              map = fillMap(54, 8 , offset, map);
              map = fillMap(33, 3 , offset, map);
              map = fillMap(57, 1 , offset, map);
              map = fillMap(19, 2 , offset, map);
              map = fillMap(12, 5 , offset, map);
              map = fillMap(29, 8 ,offset, map);
              map = fillMap(08, 3 , offset, map);
              map = fillMap(32, 3 , offset, map);
              map = fillMap(56, 6 , offset, map);
              map = fillMap(73, 7 , offset, map);
              map = fillMap(21, 3 , offset, map);
              map = fillMap(38, 1 , offset, map);
          };
      };
      break;
  };

  return map;
}

// create substition Table
// to change random number to first number in the row
Map<String, String> replaceOwnMap(String ownKeys, Alphabet alphabet){
  var map = Map<String, String>();

  switch (alphabet) {
    case Alphabet.alphabetGerman1:
      var offset = 1;
      map = fillMap(36, 1, 20, map);
      map = fillMap(36, 1, 20, map);
      map = fillMapOwn(36, 66, 4, offset, map);
      map = fillMap(06, 1, offset, map);
      map = fillMap(08, 1, offset, map);
      map = fillMap(10, 4, offset, map);
      map = fillMap(15, 4, offset, map);
      map = fillMap(15, 1, 15, map);
      map = fillMapOwn(15, 6, 9, offset, map);
      map = fillMap(15, 1, 15, map);
      map = fillMapOwn(15, 16, 1, offset, map);
      map = fillMap(32, 1, offset, map);
      map = fillMap(34, 1, offset, map);
      map = fillMap(34, 1, 66, map);
      map = fillMap(37, 2, offset, map);
      map = fillMap(37, 1, -17, map);
      map = fillMap(37, 1, 4, map);
      map = fillMap(42, 7, offset, map);
      map = fillMap(52, 2, offset, map);
      map = fillMap(55, 1, 46, map);
      map = fillMap(57, 9, offset, map);
      map = fillMap(67, 1, offset, map);
      map = fillMap(71, 6, offset, map);
      map = fillMap(78, 6, offset, map);
      map = fillMap(85, 4, offset, map);
      map = fillMap(85, 1, -15, map);
      map = fillMap(91, 3, offset, map);
      break;
    case Alphabet.alphabetEnglish1:
      break;
    case Alphabet.alphabetRussian1:
      break;
    case Alphabet.alphabetSpanish2:
      break;
  };

  return map;
}

String changeOutput(String input, Map<String, String> replaceNumbers){
  if (replaceNumbers != null)
    replaceNumbers.forEach((key, value){
      input = substitution(input, replaceNumbers);
    });
  return input;
}