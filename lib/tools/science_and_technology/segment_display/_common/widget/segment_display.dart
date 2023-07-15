import 'package:flutter/material.dart';
import 'package:gc_wizard/application/i18n/app_localizations.dart';
import 'package:gc_wizard/application/theme/theme.dart';
import 'package:gc_wizard/common_widgets/buttons/gcw_iconbutton.dart';
import 'package:gc_wizard/common_widgets/dividers/gcw_text_divider.dart';
import 'package:gc_wizard/common_widgets/dropdowns/gcw_dropdown.dart';
import 'package:gc_wizard/common_widgets/gcw_text.dart';
import 'package:gc_wizard/common_widgets/gcw_toolbar.dart';
import 'package:gc_wizard/common_widgets/outputs/gcw_default_output.dart';
import 'package:gc_wizard/common_widgets/switches/gcw_twooptions_switch.dart';
import 'package:gc_wizard/common_widgets/textfields/gcw_textfield.dart';
import 'package:gc_wizard/tools/science_and_technology/segment_display/14_segment_display/widget/14_segment_display.dart';
import 'package:gc_wizard/tools/science_and_technology/segment_display/16_segment_display/widget/16_segment_display.dart';
import 'package:gc_wizard/tools/science_and_technology/segment_display/7_segment_display/widget/7_segment_display.dart';
import 'package:gc_wizard/tools/science_and_technology/segment_display/_common/logic/segment_display.dart';
import 'package:gc_wizard/tools/science_and_technology/segment_display/_common/widget/n_segment_display.dart';
import 'package:gc_wizard/tools/science_and_technology/segment_display/_common/widget/segmentdisplay_output.dart';
import 'package:gc_wizard/tools/symbol_tables/_common/widget/gcw_symbol_container.dart';

class SegmentDisplay extends StatefulWidget {
  final SegmentDisplayType type;

  const SegmentDisplay({Key? key, required this.type}) : super(key: key);

  @override
 _SegmentDisplayState createState() => _SegmentDisplayState();
}

class _SegmentDisplayState extends State<SegmentDisplay> {
  late TextEditingController _inputEncodeController;
  late TextEditingController _inputDecodeController;
  var _currentEncodeInput = '';
  var _currentDecodeInput = '';
  var _currentDisplays = Segments.Empty();
  var _currentMode = GCWSwitchPosition.right;
  var _currentEncryptMode = GCWSwitchPosition.left;
  var _currentType = SegmentDisplayType.SEVEN;

  List<GCWDropDownMenuItem<SegmentDisplayType>> _dropDownList = [];
  List<Widget> _selectedItemList = [];

  @override
  void initState() {
    super.initState();

    switch (widget.type) {
      case SegmentDisplayType.FOURTEEN:
        _currentType = SegmentDisplayType.FOURTEEN;
        break;
      case SegmentDisplayType.SIXTEEN:
        _currentType = SegmentDisplayType.SIXTEEN;
        break;
      default:
        _currentType = SegmentDisplayType.SEVEN;
    }
    _initDropDownList();

    _inputEncodeController = TextEditingController(text: _currentEncodeInput);
    _inputDecodeController = TextEditingController(text: _currentDecodeInput);
  }

  @override
  void dispose() {
    _inputEncodeController.dispose();
    _inputDecodeController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Column(children: <Widget>[
      GCWTwoOptionsSwitch(
        value: _currentMode,
        onChanged: (value) {
          setState(() {
            _currentMode = value;
          });
        },
      ),
      _currentMode == GCWSwitchPosition.left // encrypt
          ? GCWTwoOptionsSwitch(
              value: _currentEncryptMode,
              title: i18n(context, 'segmentdisplay_encodemode'),
              leftValue: i18n(context, 'segmentdisplay_encodemode_text'),
              rightValue: i18n(context, 'segmentdisplay_encodemode_visualsegments'),
              onChanged: (value) {
                setState(() {
                  _initDropDownList();
                  _currentEncryptMode = value;
                  if (_currentEncryptMode == GCWSwitchPosition.right) {
                    _currentDisplays = encodeSegment(_currentEncodeInput, widget.type);
                  }
                });
              },
            )
          : Container(),
      _currentMode == GCWSwitchPosition.left // encrypt
          ? (_currentEncryptMode == GCWSwitchPosition.left
              ? GCWTextField(
                  controller: _inputEncodeController,
                  onChanged: (text) {
                    setState(() {
                      _currentEncodeInput = text;
                    });
                  },
                )
              : _buildVisualEncryption())
          : _buildDectrypt(),
      _buildOutput(),
    ]);
  }

  Widget _buildDectrypt() {
    return Column(
        children: <Widget>[
          GCWTextField(
            controller: _inputDecodeController,
            onChanged: (text) {
              setState(() {
                _currentDecodeInput = text;
              });
            },
          ),
          _buildDropDown()
        ]);
  }

  Widget _buildVisualEncryption() {
    NSegmentDisplay displayWidget;
    var currentDisplay = buildSegmentMap(_currentDisplays);

    onChanged(Map<String, bool> d) {
      setState(() {
        var newSegments = <String>[];
        d.forEach((key, value) {
          if (!value) return;

          newSegments.add(key);
        });

        //sort with dot to end
        var containsDot = newSegments.contains('dp');
        newSegments.remove('dp');

        _currentDisplays.replaceLastSegment(newSegments, trailingDisplay: containsDot ? 'dp' : null);
      });
    }

    switch (widget.type) {
      case SegmentDisplayType.SEVEN:
        displayWidget = SevenSegmentDisplay(
          segments: currentDisplay,
          type: _currentType,
          onChanged: onChanged,
        );
        break;
      case SegmentDisplayType.FOURTEEN:
        displayWidget = FourteenSegmentDisplay(
          segments: currentDisplay,
          type: _currentType,
          onChanged: onChanged,
        );
        break;
      case SegmentDisplayType.SIXTEEN:
        displayWidget = SixteenSegmentDisplay(
          segments: currentDisplay,
          type: _currentType,
          onChanged: onChanged,
        );
        break;
      default:
        return Container();
    }

    return Column(
      children: <Widget>[
        Container(
          width: 180,
          padding: const EdgeInsets.only(top: DEFAULT_MARGIN * 2, bottom: DEFAULT_MARGIN * 4),
          child: Row(
            children: <Widget>[
              Expanded(
                child: displayWidget,
              )
            ],
          ),
        ),
        GCWToolBar(children: [
          GCWIconButton(
            icon: Icons.space_bar,
            onPressed: () {
              setState(() {
                _currentDisplays.addEmptySegment();
              });
            },
          ),
          GCWIconButton(
            icon: Icons.backspace,
            onPressed: () {
              setState(() {
                _currentDisplays.removeLastSegment();
              });
            },
          ),
          GCWIconButton(
            icon: Icons.clear,
            onPressed: () {
              setState(() {
                _currentDisplays = Segments.Empty();
              });
            },
          )
        ]),
        GCWTextDivider(text: i18n(context, 'segmentdisplay_encodemode_visualsegments_input')),
        GCWText(
            text: decodeSegment(
                _currentDisplays.displays.map((character) {
                  return character.join();
                }).join(' '),
                widget.type).text)
      ],
    );
  }

  Widget _buildDigitalOutput(Segments segments) {
    return SegmentDisplayOutput(
        segmentFunction: (displayedSegments, readOnly) {
          switch (widget.type) {
            case SegmentDisplayType.SEVEN:
              return SevenSegmentDisplay(
                segments: displayedSegments,
                type: _currentType,
                readOnly: true,
              );
            case SegmentDisplayType.FOURTEEN:
              return FourteenSegmentDisplay(
                segments: displayedSegments,
                type: _currentType,
                readOnly: true,
              );
            case SegmentDisplayType.SIXTEEN:
              return SixteenSegmentDisplay(
                segments: displayedSegments,
                type: _currentType,
                readOnly: true,
              );
            default:
              return SevenSegmentDisplay(segments: const {});
          }
        },
        segments: segments,
        readOnly: true);
  }

  Widget _buildOutput() {
    if (_currentMode == GCWSwitchPosition.left) {
      Segments segments;
      if (_currentEncryptMode == GCWSwitchPosition.left) {
        segments = encodeSegment(_currentEncodeInput, widget.type);
      } else {
        segments = _currentDisplays;
      }

      var output = segments.displays.map((character) {
        return character.join();
      }).join(' ');

      return Column(
        children: <Widget>[_buildDigitalOutput(segments), GCWDefaultOutput(child: output)],
      );
    } else {
      var segments = decodeSegment(_currentDecodeInput, widget.type);

      return Column(
        children: <Widget>[_buildDigitalOutput(segments), GCWDefaultOutput(child: segments.text)],
      );
    }
  }

  Widget _buildDropDown() {
    return GCWDropDown<SegmentDisplayType>(
      value: _currentType,
      onChanged: (value) {
        setState(() {
          _currentType = value;
        });
      },
      items: _dropDownList,
      selectedItemBuilder: (BuildContext context) {
        return _selectedItemList;
      },
    );
  }

  void _initDropDownList() {
    _dropDownList = [];
    _selectedItemList = [];
    switch (widget.type) {
      case SegmentDisplayType.FOURTEEN:
        _addDropDownEntry('14segment_default.png', 'STANDARD', null, SegmentDisplayType.FOURTEEN);
        _addDropDownEntry('14segment_hij_g1g2_mlk.png', 'HIJ_G1G2_MLK', null, SegmentDisplayType.FOURTEEN_HIJ_G1G2_MLK);
        _addDropDownEntry('14segment_pgh_nj_mlk.png', 'FGH_NJ_MLK', null, SegmentDisplayType.FOURTEEN_FGH_NJ_MLK);
        _addDropDownEntry('14segment_kmn_g1g2_rst.png', 'KMN_G1G2_RST', null, SegmentDisplayType.FOURTEEN_KMN_G1G2_RST);
        _addDropDownEntry('14segment_ghj_pk_nmi.png', 'KMN_G1G2_RST', null, SegmentDisplayType.FOURTEEN_GHJ_PK_NMI);
        _addDropDownEntry('14segment_hjk_g1g2_nml.png', 'HJK_G1G2_NML', null, SegmentDisplayType.FOURTEEN_HJK_G1G2_NML);
        break;
      case SegmentDisplayType.SIXTEEN:
        _addDropDownEntry('16segment_default.png', 'STANDARD', null, SegmentDisplayType.SIXTEEN);
        break;
      default:
        _addDropDownEntry('7segment_default.png', 'STANDARD', null, SegmentDisplayType.SEVEN);
        _addDropDownEntry('7segment_12345678.png', '12345678', null, SegmentDisplayType.SEVEN12345678);
    }
  }

  void _addDropDownEntry(String iconName, String label, String? description, SegmentDisplayType type) {
    _dropDownList.add(GCWDropDownMenuItem(
        value: type,
        child: _buildDropDownMenuItem(iconName, label, description)));

    _selectedItemList.add(_buildDropDownSelectedItem(iconName, label, description));
  }

  Widget _buildDropDownMenuItem(String iconName, String label, String? description) {
    var icon = GCWSymbolContainer(
      symbol: Image.asset('assets/icons/science_and_technology/' + iconName, width: DEFAULT_LISTITEM_SIZE),
    );
    return Row(children: [
      Container(
        margin: const EdgeInsets.only(left: 2, top: 2, bottom: 2, right: 10),
        child: icon, //(icon != null) ? icon : Container(width: 50),
      ),
      Expanded(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: gcwTextStyle()),
                (description != null) ? Text(description, style: gcwDescriptionTextStyle()) : Container(),
              ]))
    ]);
  }

  Widget _buildDropDownSelectedItem(String iconName, String label, String? description) {
    return Align(
        alignment: Alignment.centerLeft,
        child: GCWText(
          text: label,
        )
    );
  }
}
