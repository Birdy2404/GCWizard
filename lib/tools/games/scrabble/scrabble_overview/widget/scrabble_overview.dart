import 'package:flutter/material.dart';
import 'package:gc_wizard/application/i18n/app_localizations.dart';
import 'package:gc_wizard/common_widgets/dropdowns/gcw_dropdown.dart';
import 'package:gc_wizard/common_widgets/outputs/gcw_columned_multiline_output.dart';
import 'package:gc_wizard/common_widgets/outputs/gcw_default_output.dart';
import 'package:gc_wizard/tools/games/scrabble/logic/scrabble_sets.dart';

class ScrabbleOverview extends StatefulWidget {
  @override
  ScrabbleOverviewState createState() => ScrabbleOverviewState();
}

class ScrabbleOverviewState extends State<ScrabbleOverview> {
  var _currentScrabbleVersion = scrabbleID_EN;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GCWDropDown<String>(
          value: _currentScrabbleVersion,
          onChanged: (value) {
            setState(() {
              _currentScrabbleVersion = value;
              _calculateOutput();
            });
          },
          items: scrabbleSets.entries.map((set) {
            return GCWDropDownMenuItem(
              value: set.key,
              child: i18n(context, set.value.i18nNameId),
            );
          }).toList(),
        ),
        GCWDefaultOutput(child: _calculateOutput()),
      ],
    );
  }

  Widget _calculateOutput() {
    var data = <List<Object>>[
      [
        i18n(context, 'common_letter'),
        i18n(context, 'common_value'),
        i18n(context, 'scrabble_mode_frequency'),
      ]
    ];
    var set = scrabbleSets[_currentScrabbleVersion];
    if (set != null) {
      data.addAll(set.letters.entries.map((entry) {
        return [entry.key.replaceAll(' ', String.fromCharCode(9251)), entry.value.value, entry.value.frequency];
      }).toList());
    }
    return GCWColumnedMultilineOutput(
        data: data,
        hasHeader: true,
        copyColumn: 0
    );
  }
}
