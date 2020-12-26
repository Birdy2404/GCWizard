import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/coords/data/coordinates.dart';
import 'package:gc_wizard/logic/tools/coords/parser/variable_latlon.dart';
import 'package:gc_wizard/logic/tools/coords/utils.dart';
import 'package:gc_wizard/logic/common/units/length.dart';
import 'package:gc_wizard/logic/common/units/unit_category.dart';
import 'package:gc_wizard/persistence/formula_solver/model.dart' as formula_base;
import 'package:gc_wizard/persistence/variable_coordinate/json_provider.dart';
import 'package:gc_wizard/persistence/variable_coordinate/model.dart';
import 'package:gc_wizard/theme/theme.dart';
import 'package:gc_wizard/theme/theme_colors.dart';
import 'package:gc_wizard/widgets/common/base/gcw_dialog.dart';
import 'package:gc_wizard/widgets/common/base/gcw_iconbutton.dart';
import 'package:gc_wizard/widgets/common/base/gcw_output_text.dart';
import 'package:gc_wizard/widgets/common/base/gcw_text.dart';
import 'package:gc_wizard/widgets/common/base/gcw_textfield.dart';
import 'package:gc_wizard/widgets/common/gcw_onoff_switch.dart';
import 'package:gc_wizard/widgets/common/gcw_submit_button.dart';
import 'package:gc_wizard/widgets/common/gcw_text_divider.dart';
import 'package:gc_wizard/widgets/common/gcw_twooptions_switch.dart';
import 'package:gc_wizard/widgets/common/units/gcw_unit_dropdownbutton.dart';
import 'package:gc_wizard/widgets/tools/coords/base/gcw_coords_output.dart';
import 'package:gc_wizard/widgets/tools/coords/base/gcw_coords_outputformat.dart';
import 'package:gc_wizard/widgets/tools/coords/base/gcw_map_geometries.dart';
import 'package:gc_wizard/widgets/tools/coords/base/utils.dart';
import 'package:gc_wizard/widgets/utils/textinputformatter/coords_text_variablecoordinate_textinputformatter.dart';
import 'package:flutter/material.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/hashes/hashes.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/hashes/hash_breaker.dart';
import 'package:gc_wizard/widgets/common/base/gcw_textfield.dart';
import 'package:gc_wizard/widgets/common/gcw_default_output.dart';
import 'package:gc_wizard/widgets/common/base/gcw_dropdownbutton.dart';

class HashBreaker extends StatefulWidget {
  final Function hashFunction;

  const HashBreaker({Key key, this.hashFunction}) : super(key: key);

  @override
  _HashBreakerState createState() => _HashBreakerState();
}

class _HashBreakerState extends State<HashBreaker> {
  var _fromController;
  var _toController;
  var _inputController;
  var _maskController;

  var _currentInput = '';
  var _currentMask = '';
  var _currentFromInput = '';
  var _currentToInput = '';

  var _currentEditedKey = '';
  var _currentEditedValue = '';
  var _currentEditId;
  var _editKeyController;
  var _editValueController;

  var _currentIdCount = 0;

  var _currentOutput = '';
  var _currentHashFunction = md5Digest;
  var _currentSubstitutions = <int, Map<String, String>>{};

  @override
  void initState() {
    super.initState();

    _inputController = TextEditingController(text: _currentInput);
    _maskController = TextEditingController(text: _currentMask);
    _fromController = TextEditingController(text: _currentFromInput);
    _toController = TextEditingController(text: _currentToInput);

    _editKeyController = TextEditingController(text: _currentEditedKey);
    _editValueController = TextEditingController(text: _currentEditedValue);
  }

  @override
  void dispose() {
    _inputController.dispose();
    _maskController.dispose();
    _fromController.dispose();
    _toController.dispose();
    _editKeyController.dispose();
    _editValueController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GCWTextField(
          hintText: i18n(context, 'hashes_hashbreaker_hashtobreak'),
          controller: _inputController,
          onChanged: (value) {
            _currentInput = value;
          },
        ),
        GCWTextDivider(
          text: i18n(context, 'hashes_hashbreaker_searchconfiguration'),
        ),
        GCWDropDownButton(
          value: _currentHashFunction,
          onChanged: (newValue) {
            setState(() {
              _currentHashFunction = newValue;
            });
          },
          items: HASH_FUNCTIONS.entries.map((hashFunction) {
            return GCWDropDownMenuItem(
              value: hashFunction.value,
              child: i18n(context, hashFunction.key + '_title'),
            );
          }).toList(),
        ),
        GCWTextField(
          hintText: i18n(context, 'hashes_hashbreaker_searchconfiguration_searchmask'),
          controller: _maskController,
          onChanged: (value) {
            _currentMask = value;
          },
        ),
        _buildVariablesInput(),
        _buildSubstitutionList(context),
        GCWSubmitFlatButton(
          onPressed: () {
            setState(() {
              _calculateOutput();
            });
          },
        ),
        GCWDefaultOutput(
          child: _currentOutput
        )
      ],
    );
  }

  _calculateOutput({calculateAll = false}) {
    var _substitutions = <String, String>{};
    _currentSubstitutions.entries.forEach((entry) {
      _substitutions.putIfAbsent(entry.value.keys.first, () => entry.value.values.first);
    });

    if (calculateAll == false) {
      var preCheckResult = preCheck(_substitutions);
      if (preCheckResult == null || preCheckResult['status'] == null) {
        _currentOutput = i18n(context, 'hashes_hashbreaker_solutionnotfound');
        return;
      }

      if (preCheckResult['status'] == 'high_count') {
        showGCWAlertDialog(
          context,
          i18n(context, 'hashes_hashbreaker_alert_range_title'),
          i18n(context, 'hashes_hashbreaker_alert_range_text', parameters: [preCheckResult['count']]),
          () {
            setState(() {
              _calculateOutput(calculateAll: true);
            });
          },
        );

        _currentOutput = '';
        return;
      }
    }

    Map<String, dynamic> output = breakHash(_currentInput, _currentMask, _substitutions, _currentHashFunction);
    if (output == null || output['state'] == null || output['state'] == 'not_found') {
      _currentOutput = i18n(context, 'hashes_hashbreaker_solutionnotfound');
      return;
    }

    _currentOutput = output['text'];
  }

  _buildVariablesInput() {
    return Column(
      children: [
        GCWTextDivider(
          text: i18n(context, 'coords_variablecoordinate_variables'),
        ),
        Row(
          children: <Widget>[
            Expanded(
                child: GCWTextField(
                  hintText: i18n(context, 'coords_variablecoordinate_variable'),
                  controller: _fromController,
                  onChanged: (text) {
                    _currentFromInput = text;
                  },
                ),
                flex: 1
            ),
            Icon(
              Icons.arrow_forward,
              color: themeColors().mainFont(),
            ),
            Expanded(
              child: GCWTextField(
                hintText: i18n(context, 'coords_variablecoordinate_possiblevalues'),
                controller: _toController,
                inputFormatters: [CoordsTextVariableCoordinateTextInputFormatter()],
                onChanged: (text) {
                  _currentToInput = text;
                },
              ),
              flex: 2,
            ),
            GCWIconButton(
              iconData: Icons.add,
              onPressed: () {
                setState(() {
                  if (_currentFromInput.length > 0) {
                    _currentSubstitutions.putIfAbsent(++_currentIdCount, () => {_currentFromInput: _currentToInput});

                    _fromController.clear();
                    _toController.clear();
                    _currentFromInput = '';
                    _currentToInput = '';
                  }
                });
              },
            )
          ],
        ),
      ],
    );
  }

  _buildSubstitutionList(BuildContext context) {
    var odd = true;
    var rows = _currentSubstitutions.entries.map((substitution) {
      Widget output;

      var row = Container(
          child: Row (
            children: <Widget>[
              Expanded(
                child: Container(
                  child: _currentEditId == substitution.key
                    ? GCWTextField (
                      controller: _editKeyController,
                      onChanged: (text) {
                        setState(() {
                          _currentEditedKey = text;
                        });
                      },
                    )
                    : GCWText (
                      text: substitution.value.keys.first
                    ),
                  margin: EdgeInsets.only(left: 10),
                ),
                flex: 1,
              ),
              Icon(
                Icons.arrow_forward,
                color: themeColors().mainFont(),
              ),
              Expanded(
                  child: Container(
                    child: _currentEditId == substitution.key
                      ? GCWTextField(
                        controller: _editValueController,
                        autofocus: true,
                        onChanged: (text) {
                          setState(() {
                            _currentEditedValue = text;
                          });
                        },
                      )
                      : GCWText (
                        text: substitution.value.values.first
                      ),
                    margin: EdgeInsets.only(left: 10),
                  ),
                  flex: 3
              ),
              _currentEditId == substitution.key
                ? GCWIconButton(
                    iconData: Icons.check,
                    onPressed: () {

                      _currentSubstitutions[_currentEditId] = {_currentEditedKey: _currentEditedValue};

                      setState(() {
                        _currentEditId = null;
                        _editKeyController.clear();
                        _editValueController.clear();
                      });
                    },
                  )
                : GCWIconButton(
                    iconData: Icons.edit,
                    onPressed: () {
                      setState(() {
                        _currentEditId = substitution.key;
                        _editKeyController.text = substitution.value.keys.first;
                        _editValueController.text = substitution.value.values.first;
                        _currentEditedKey = substitution.value.keys.first;
                        _currentEditedValue = substitution.value.values.first;
                      });
                    },
                  ),
              GCWIconButton(
                iconData: Icons.remove,
                onPressed: () {
                  setState(() {
                    _currentSubstitutions.remove(substitution.key);
                  });
                },
              )
            ],
          )
      );

      if (odd) {
        output = Container(
          color: themeColors().outputListOddRows(),
          child: row
        );
      } else {
        output = Container(
            child: row
        );
      }
      odd = !odd;

      return output;
    }).toList();

    return Container(
      child: Column(
        children: rows
      ),
      padding: EdgeInsets.only(
        top: 10
      ),
    );
  }
}