import 'package:flutter/material.dart';
import 'package:gc_wizard/tools/science_and_technology/irrational_numbers/irrationalnumbers_decimalrange/widget/irrationalnumbers_decimalrange.dart';
import 'package:gc_wizard/tools/science_and_technology/irrational_numbers/irrationalnumbers_nthdecimal/widget/irrationalnumbers_nthdecimal.dart';
import 'package:gc_wizard/tools/science_and_technology/irrational_numbers/irrationalnumbers_search/widget/irrationalnumbers_search.dart';
import 'package:gc_wizard/tools/science_and_technology/irrational_numbers/silver_ratio/logic/silver_ratio.dart';

class SilverRatioNthDecimal extends IrrationalNumbersNthDecimal {
  SilverRatioNthDecimal({Key? key}) : super(key: key, irrationalNumber: SilverRatio);
}

class SilverRatioDecimalRange extends IrrationalNumbersDecimalRange {
  SilverRatioDecimalRange({Key? key}) : super(key: key, irrationalNumber: SilverRatio);
}

class SilverRatioSearch extends IrrationalNumbersSearch {
  SilverRatioSearch({Key? key}) : super(key: key, irrationalNumber: SilverRatio);
}
