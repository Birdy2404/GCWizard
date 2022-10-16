import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/numeral_words.dart';
import 'package:gc_wizard/theme/theme_colors.dart';
import 'package:gc_wizard/utils/common_utils.dart';
import 'package:gc_wizard/utils/settings/preferences.dart';
import 'package:gc_wizard/widgets/common/base/gcw_dropdownbutton.dart';
import 'package:gc_wizard/widgets/common/base/gcw_output_text.dart';
import 'package:gc_wizard/widgets/common/base/gcw_textfield.dart';
import 'package:gc_wizard/widgets/common/gcw_default_output.dart';
import 'package:gc_wizard/widgets/common/gcw_twooptions_switch.dart';
import 'package:gc_wizard/widgets/utils/common_widget_utils.dart';
import 'package:prefs/prefs.dart';
import 'package:code_text_field/code_text_field.dart';
import 'package:flutter_highlight/themes/atom-one-dark.dart';
import 'package:flutter_highlight/themes/atom-one-light.dart';
import 'package:gc_wizard/widgets/common/gcw_expandable.dart';

class NumeralWordsTextSearch extends StatefulWidget {
  @override
  NumeralWordsTextSearchState createState() => NumeralWordsTextSearchState();
}

class NumeralWordsTextSearchState extends State<NumeralWordsTextSearch> {
  TextEditingController _decodeController;
  var _codeControllerHighlighted;
  var _SourceCode = '';

  var _currentDecodeInput = '';
  GCWSwitchPosition _currentDecodeMode = GCWSwitchPosition.left;
  var _currentLanguage = NumeralWordsLanguage.ALL;

  Map<String, NumeralWordsLanguage> _languageList;

  @override
  void initState() {
    super.initState();
    _decodeController = TextEditingController(text: _currentDecodeInput);
    _codeControllerHighlighted = CodeController(
      text: _SourceCode,
      theme: Prefs.getString(PREFERENCE_THEME_COLOR) == ThemeType.DARK.toString() ? atomOneDarkTheme : atomOneLightTheme,
      stringMap: _numeralWordsHiglightMap(),
    );
  }

  @override
  void dispose() {
    _decodeController.dispose();
    _codeControllerHighlighted.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_languageList == null) {
      var sorted = SplayTreeMap<String, NumeralWordsLanguage>.from(
          switchMapKeyValue(NUMERALWORDS_LANGUAGES).map((key, value) => MapEntry(i18n(context, key), value)));

      _languageList = {i18n(context, 'numeralwords_language_all'): NumeralWordsLanguage.ALL};
      _languageList.addAll(sorted);
    }

    return Column(
      children: <Widget>[
        GCWDropDownButton(
          value: _currentLanguage,
          onChanged: (value) {
            setState(() {
              _currentLanguage = value;
            });
          },
          items: _languageList.entries.map((mode) {
            return GCWDropDownMenuItem(
              value: mode.value,
              child: mode.key,
            );
          }).toList(),
        ),
        GCWTextField(
          controller: _decodeController,
          onChanged: (text) {
            setState(() {
              _currentDecodeInput = text;
            });
          },
        ),
        GCWTwoOptionsSwitch(
          value: _currentDecodeMode,
          leftValue: i18n(context, 'numeralwords_decodemode_left'),
          rightValue: i18n(context, 'numeralwords_decodemode_right'),
          onChanged: (value) {
            setState(() {
              _currentDecodeMode = value;
            });
          },
        ),
        GCWDefaultOutput(
          child: _buildOutput(context),
        )
      ],
    );
  }

  Widget _buildOutput(BuildContext context) {
    List<NumeralWordsDecodeOutput> detailedOutput;
    String output = '';
    detailedOutput = decodeNumeralwords(removeAccents(_currentDecodeInput.toLowerCase()), _currentLanguage,
        (_currentDecodeMode == GCWSwitchPosition.left));
    for (int i = 0; i < detailedOutput.length; i++) {
      if (detailedOutput[i].number != '') if (detailedOutput[i].number.startsWith('numeralwords_'))
        output = output + ' ' + i18n(context, detailedOutput[i].number);
      else
        output = output + detailedOutput[i].number;
    }

    List<List<String>> columnData = new List<List<String>>();
    var flexData;
    String columnDataRowNumber;
    String columnDataRowNumWord;
    String columnDataRowLanguage;
    if (_currentLanguage == NumeralWordsLanguage.ALL) {
      for (int i = 0; i < detailedOutput.length; i++) {
        if (detailedOutput[i].number.startsWith('numeralwords_'))
          columnDataRowNumber = i18n(context, detailedOutput[i].number);
        else
          columnDataRowNumber = detailedOutput[i].number;
        if (detailedOutput[i].numWord.startsWith('numeralwords_'))
          columnDataRowNumWord = i18n(context, detailedOutput[i].numWord);
        else
          columnDataRowNumWord = detailedOutput[i].numWord;
        columnDataRowLanguage = i18n(context, detailedOutput[i].language);
        int j = i + 1;
        while (j < detailedOutput.length && detailedOutput[j].number == '') {
          columnDataRowNumber = columnDataRowNumber + '\n' + '';
          columnDataRowNumWord = columnDataRowNumWord + '\n' + detailedOutput[j].numWord;
          columnDataRowLanguage = columnDataRowLanguage + '\n' + i18n(context, detailedOutput[j].language);
          j++;
        }
        i = j - 1;
        columnData.add([columnDataRowNumber, columnDataRowNumWord, columnDataRowLanguage]);
      }
      flexData = [1, 3, 1];
    } else {
      for (int i = 0; i < detailedOutput.length; i++) {
        if (detailedOutput[i].number.startsWith('numeralwords_'))
          columnDataRowNumber = i18n(context, detailedOutput[i].number);
        else
          columnDataRowNumber = detailedOutput[i].number;
        if (detailedOutput[i].numWord.startsWith('numeralwords_'))
          columnDataRowNumWord = i18n(context, detailedOutput[i].numWord);
        else
          columnDataRowNumWord = detailedOutput[i].numWord;
        columnData.add([columnDataRowNumber, columnDataRowNumWord]);
      }
      flexData = [1, 2];
    }

    _codeControllerHighlighted = CodeController(
      text: '',
      theme: Prefs.getString(PREFERENCE_THEME_COLOR) == ThemeType.DARK.toString() ? atomOneDarkTheme : atomOneLightTheme,
      patternMap: _numeralWordsHiglightMap(),
    );
    if (_currentDecodeMode == GCWSwitchPosition.left)
      _codeControllerHighlighted.text = _currentDecodeInput.toLowerCase();
    else
      _codeControllerHighlighted.text = _currentDecodeInput.toLowerCase().replaceAll(RegExp(r'[^a-z0-9]'), '');

    return Column(
      children: <Widget>[
        GCWOutputText(
          text: output,
        ),
        output.length == 0
            ? Container()
            : GCWExpandableTextDivider(
                text: i18n(context, 'common_outputdetail'),
                expanded: false,
                child:
                    Column(children: columnedMultiLineOutput(context, columnData, flexValues: flexData, copyColumn: 1)),
              ),
        GCWExpandableTextDivider (
          text: i18n(context, 'numeralwords_syntax_highlight'),
          child: CodeField(
            controller: _codeControllerHighlighted,
            wrap: true,
            textStyle: TextStyle(fontFamily: 'SourceCode'),
            lineNumberStyle: LineNumberStyle(width: 0.0),
          ),
        )
      ],
    );
  }

  Map<String, TextStyle> _numeralWordsHiglightMap(){
    Map<String, TextStyle> result = {};
    if (_currentLanguage != NumeralWordsLanguage.ALL){
      NumWords[_currentLanguage].forEach((key, value) {
        if (int.tryParse(value) == null)
          if (value.startsWith('numeral'))
            result[r'' + key + ''] = TextStyle(color: Colors.blue);
          else
            result[r'' + key + ''] = TextStyle(color: Colors.green);
        else
          if (int.parse(value) < 10)
            result[r'' + key + ''] = TextStyle(color: Colors.red);
          else
            result[r'' + key + ''] = TextStyle(color: Colors.orange);
      });
    }
    return result;
  }
}
