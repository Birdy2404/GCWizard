import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/enigma/logic/enigma.dart';
import 'package:gc_wizard/theme/theme.dart';
import 'package:gc_wizard/utils/alphabets.dart';
import 'package:gc_wizard/common_widgets/base/gcw_output_text/gcw_output_text.dart';
import 'package:gc_wizard/common_widgets/base/gcw_textfield/gcw_textfield.dart';
import 'package:gc_wizard/common_widgets/gcw_columned_multiline_output/gcw_columned_multiline_output.dart';
import 'package:gc_wizard/common_widgets/gcw_dropdown_spinner/gcw_dropdown_spinner.dart';
import 'package:gc_wizard/common_widgets/gcw_integer_spinner/gcw_integer_spinner.dart';
import 'package:gc_wizard/common_widgets/gcw_multiple_output/gcw_multiple_output.dart';
import 'package:gc_wizard/common_widgets/gcw_onoff_switch/gcw_onoff_switch.dart';
import 'package:gc_wizard/common_widgets/gcw_text_divider/gcw_text_divider.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/enigma/enigma/widget/gcw_enigma_rotor_dropdownbutton.dart';
import 'package:gc_wizard/tools/utils/textinputformatter/wrapper_for_masktextinputformatter/widget/wrapper_for_masktextinputformatter.dart';

class Enigma extends StatefulWidget {
  @override
  EnigmaState createState() => EnigmaState();
}

class EnigmaState extends State<Enigma> {
  var _inputController;
  var _plugboardController;

  String _currentInput = '';
  String _currentPlugboard = '';

  var _currentEntryRotorMode = true;
  var _currentReflectorMode = true;
  var _currentEntryRotor = EnigmaRotorConfiguration(getEnigmaRotorByName(defaultRotorEntryRotor));
  var _currentReflector = EnigmaRotorConfiguration(getEnigmaRotorByName(defaultRotorReflector));

  var _isTextChange = false;

  var _currentNumberRotors = 3;
  List<GCWEnigmaRotorDropDownButton> _currentRotors = [];
  List<EnigmaRotorConfiguration> _currentRotorsConfigurations = [];

  var _currentRotorInformation = 0;

  var _plugboardMaskFormatter =
      WrapperForMaskTextInputFormatter(mask: '## ' * 25 + '##', filter: {"#": RegExp(r'[A-Za-z]')});

  @override
  void initState() {
    super.initState();

    _inputController = TextEditingController(text: _currentInput);
    _plugboardController = TextEditingController(text: _currentPlugboard);
  }

  @override
  void dispose() {
    _inputController.dispose();
    _plugboardController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GCWTextDivider(
          text: i18n(context, 'enigma_input'),
          suppressTopSpace: true,
        ),
        GCWTextField(
          controller: _inputController,
          onChanged: (text) {
            setState(() {
              _isTextChange = true;
              _currentInput = text;
            });
          },
        ),
        GCWTextDivider(text: i18n(context, 'enigma_reflector')),
        Row(
          children: <Widget>[
            Expanded(
                child: GCWOnOffSwitch(
                  notitle: true,
                  value: _currentReflectorMode,
                  onChanged: (value) {
                    setState(() {
                      _currentReflectorMode = value;
                    });
                  },
                ),
                flex: 1),
            Expanded(
                child: _currentReflectorMode
                    ? GCWEnigmaRotorDropDownButton(
                        type: EnigmaRotorType.REFLECTOR,
                        onChanged: (value) {
                          setState(() {
                            _currentReflector = value['rotorConfiguration'];
                          });
                        },
                      )
                    : Container(),
                flex: 4)
          ],
        ),
        GCWTextDivider(text: i18n(context, 'enigma_rotors')),
        GCWIntegerSpinner(
          title: i18n(context, 'enigma_numberrotors'),
          min: 1,
          max: 10,
          value: _currentNumberRotors,
          onChanged: (value) {
            setState(() {
              _currentNumberRotors = value;
            });
          },
        ),
        _buildRotors(),
        GCWTextDivider(text: i18n(context, 'enigma_entryrotor')),
        Row(
          children: <Widget>[
            Expanded(
                child: GCWOnOffSwitch(
                  notitle: true,
                  value: _currentEntryRotorMode,
                  onChanged: (value) {
                    setState(() {
                      _currentEntryRotorMode = value;
                    });
                  },
                ),
                flex: 1),
            Expanded(
                child: _currentEntryRotorMode
                    ? GCWEnigmaRotorDropDownButton(
                        type: EnigmaRotorType.ENTRY_ROTOR,
                        onChanged: (value) {
                          setState(() {
                            _currentEntryRotor = value['rotorConfiguration'];
                          });
                        },
                      )
                    : Container(),
                flex: 4)
          ],
        ),
        GCWTextDivider(text: i18n(context, 'enigma_plugboard')),
        GCWTextField(
          controller: _plugboardController,
          hintText: 'AB CD EF...',
          inputFormatters: [_plugboardMaskFormatter],
          onChanged: (text) {
            setState(() {
              _isTextChange = true;
              _currentPlugboard = _plugboardMaskFormatter.getMaskedText();
            });
          },
        ),
        _buildOutput(),
        _buildRotorInformation()
      ],
    );
  }

  _rotorType(EnigmaRotorType type) {
    switch (type) {
      case EnigmaRotorType.ENTRY_ROTOR:
        return i18n(context, 'enigma_rotortype_entryrotor');
      case EnigmaRotorType.REFLECTOR:
        return i18n(context, 'enigma_rotortype_reflector');
      case EnigmaRotorType.STANDARD:
        return i18n(context, 'enigma_rotortype_standard');
    }
  }

  Widget _buildRotorInformation() {
    List<EnigmaRotorConfiguration> _allRotors = [];
    if (_currentReflectorMode) _allRotors.add(_currentReflector);

    _allRotors.addAll(_currentRotorsConfigurations);

    if (_currentEntryRotorMode) _allRotors.add(_currentEntryRotor);

    if (_allRotors.length == 0) return Container();

    if (_currentRotorInformation >= _allRotors.length) _currentRotorInformation = 0;

    var currentRotor = _allRotors[_currentRotorInformation].rotor;

    return Column(
      children: [
        GCWTextDivider(text: i18n(context, 'enigma_rotorinfo')),
        GCWDropDownSpinner(
          index: _currentRotorInformation,
          items: _allRotors.map((EnigmaRotorConfiguration e) => e.rotor.name).toList(),
          onChanged: (value) {
            setState(() {
              _currentRotorInformation = value;
            });
          },
        ),
        GCWOutputText(
          style: gcwMonotypeTextStyle(),
          text: alphabet_AZ.keys.join() + '\n' + currentRotor.alphabet,
          copyText: currentRotor.alphabet,
        ),
        GCWColumnedMultilineOutput(
          data: [
            [i18n(context, 'common_type'), _rotorType(currentRotor.type)],
            [
              i18n(context, 'enigma_turnovers'),
              (currentRotor.turnovers ?? '').isEmpty ? i18n(context, 'common_none') : currentRotor.turnovers
            ]
          ]
        ),
      ],
    );
  }

  Widget _buildRotors() {
    while (_currentRotors.length < _currentNumberRotors) {
      _currentRotors.add(GCWEnigmaRotorDropDownButton(
        position: _currentRotors.length,
        onChanged: (value) {
          setState(() {
            _currentRotorsConfigurations[value['position']] = value['rotorConfiguration'];
          });
        },
      ));
      _currentRotorsConfigurations
          .add(EnigmaRotorConfiguration(getEnigmaRotorByName(defaultRotorStandard), offset: 1, setting: 1));
    }

    while (_currentRotors.length > _currentNumberRotors) {
      _currentRotors.removeLast();
      _currentRotorsConfigurations.removeLast();
    }

    return Padding(
      child: Column(
        children: _currentRotors,
      ),
      padding: EdgeInsets.only(top: 10),
    );
  }

  Widget _buildOutput() {
    if (!_isTextChange) {
      FocusScope.of(context).requestFocus(new FocusNode());
    } else {
      _isTextChange = false;
    }

    List<EnigmaRotorConfiguration> rotorConfigurations = [];
    if (_currentEntryRotorMode) rotorConfigurations.add(_currentEntryRotor);

    rotorConfigurations.addAll((_currentRotorsConfigurations.reversed).map((configuration) {
      return configuration.clone();
    }).toList());

    if (_currentReflectorMode) rotorConfigurations.add(_currentReflector);

    var key = EnigmaKey(rotorConfigurations,
        plugboard: Map.fromIterable(_currentPlugboard.split(' ').where((digraph) => digraph.length == 2),
            key: (digraph) => digraph[0], value: (digraph) => digraph[1]));

    var results = calculateEnigmaWithMessageKey(_currentInput, key);

    var output = [];

    results.forEach((result) {
      output.add(result['text']);

      var rotorSettings = result['rotorSettingAfter'] as List<int>;

      var stripHead = _currentEntryRotorMode ? 1 : 0;
      var stripTail = _currentReflectorMode ? 1 : 0;

      var rotorSetting = rotorSettings
          .sublist(stripHead, rotorSettings.length - stripTail)
          .reversed
          .map((setting) => alphabet_AZIndexes[setting + 1]);

      output.add(GCWOutputText(
        text: i18n(context, 'enigma_output_rotorsettingafter') + ': ' + rotorSetting.join(' - '),
        copyText: rotorSetting.join(),
      ));
    });

    if (results.length == 2) output.insert(2, GCWTextDivider(text: i18n(context, 'enigma_usedmessagekey')));

    return GCWMultipleOutput(children: output);
  }
}
