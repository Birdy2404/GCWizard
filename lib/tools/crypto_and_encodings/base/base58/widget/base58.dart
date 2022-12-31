import 'package:flutter/material.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/base/logic/base.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/base/widget/base.dart';

class Base58 extends Base {
  Base58({Key key}) : super(key: key, encode: encodeBase58, decode: decodeBase58);
}
