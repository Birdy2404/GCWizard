
import 'dart:math';

import 'package:gc_wizard/logic/tools/crypto_and_encodings/bundeswehr_auth.dart';
import 'package:gc_wizard/utils/constants.dart';

const CODE_RESPONSE_INVALID_CYPHER = 'bundeswehr_code_response_invalid_cypher';

class BundeswehrTalkingBoardCodingOutput {
  final String ResponseCode;
  final String Details;

  BundeswehrTalkingBoardCodingOutput({this.ResponseCode, this.Details});
}

BundeswehrTalkingBoardCodingOutput encodeBundeswehr(String plainText, AuthentificationTable tableEncoding){
  if (tableEncoding == null || tableEncoding.Encoding.isEmpty)
    return BundeswehrTalkingBoardCodingOutput(ResponseCode: AUTH_RESPONSE_INVALID_CUSTOM_NUMERAL_TABLE, Details: '');

  List<String> result = [];
  var random = new Random();
  plainText.split('').forEach((char) {
    if (random.nextInt(100) > 75) {
      result.add(_getObfuscatedTupel(tableEncoding));
    }
    result.add(tableEncoding.Encoding[char][random.nextInt(tableEncoding.Encoding[char].length)]);
  });
  return BundeswehrTalkingBoardCodingOutput(ResponseCode: 'OK',Details: result.join(' '));
}

BundeswehrTalkingBoardCodingOutput decodeBundeswehr(String cypherText, AuthentificationTable tableNumeralCode){
  if (tableNumeralCode.Content.isEmpty)
    return BundeswehrTalkingBoardCodingOutput(ResponseCode: AUTH_RESPONSE_INVALID_CUSTOM_NUMERAL_TABLE, Details: '');

  if (cypherText == null || cypherText == '')
    return BundeswehrTalkingBoardCodingOutput(ResponseCode: 'OK', Details: '');

  String result = '';
  bool invalidCypher = false;
  cypherText.split(' ').forEach((pair) {
    if (pair.length == 2) {
      result = result + _decodeNumeralCode(pair, tableNumeralCode);
    } else {
      result = result + UNKNOWN_ELEMENT;
      invalidCypher = true;
    }
  });
  return BundeswehrTalkingBoardCodingOutput(ResponseCode: invalidCypher ? CODE_RESPONSE_INVALID_CYPHER : 'OK', Details: result);
}

String _decodeNumeralCode(String tupel, AuthentificationTable tableNumeralCode) {
  int index = 0;
  if (tableNumeralCode.xAxis.contains(tupel[0])) {
    if (tableNumeralCode.xAxis.contains(tupel[1])) {
      index = -1;
    } else {
      index = tableNumeralCode.xAxis.indexOf(tupel[0]) + tableNumeralCode.yAxis.indexOf(tupel[1]) * 13;
    }
  } else {
    if (tableNumeralCode.yAxis.contains(tupel[1])) {
      index = -1;
    } else {
      index = tableNumeralCode.xAxis.indexOf(tupel[1]) + tableNumeralCode.yAxis.indexOf(tupel[0]) * 13;
    }
  }
  if (index != -1)
    return tableNumeralCode.Content[index];
  else
    return '';
}

String _getObfuscatedTupel(AuthentificationTable tableNumeralCode){
  var random = new Random();
  if (random.nextInt(100) > 50) {
    return tableNumeralCode.yAxis[random.nextInt(13)] + tableNumeralCode.yAxis[random.nextInt(13)];
  } else {
    return tableNumeralCode.xAxis[random.nextInt(13)] + tableNumeralCode.xAxis[random.nextInt(13)];
  }
}