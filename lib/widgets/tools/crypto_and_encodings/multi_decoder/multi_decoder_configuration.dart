import 'package:flutter/material.dart';
import 'package:gc_wizard/widgets/common/base/gcw_button.dart';
import 'package:gc_wizard/widgets/common/base/gcw_iconbutton.dart';
import 'package:gc_wizard/widgets/common/base/gcw_textfield.dart';
import 'package:gc_wizard/persistence/multi_decoder/json_provider.dart';
import 'package:gc_wizard/persistence/multi_decoder/model.dart';
import 'package:gc_wizard/widgets/utils/no_animation_material_page_route.dart';
import 'package:gc_wizard/widgets/common/gcw_tool.dart';
import 'package:gc_wizard/widgets/common/gcw_text_divider.dart';
import 'package:gc_wizard/widgets/common/base/gcw_dropdownbutton.dart';
import 'package:gc_wizard/widgets/common/base/gcw_text.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/multi_decoder/tools/md_tools.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/multi_decoder/gcw_multi_decoder_tool.dart';
import 'package:gc_wizard/theme/theme.dart';
import 'package:gc_wizard/widgets/common/gcw_delete_alertdialog.dart';
import 'package:gc_wizard/theme/theme_colors.dart';

class MultiDecoderConfiguration extends StatefulWidget {
  @override
  MultiDecoderConfigurationState createState() => MultiDecoderConfigurationState();
}

class MultiDecoderConfigurationState extends State<MultiDecoderConfiguration> {
  TextEditingController _editingToolNameController;

  int _currentChosenTool = 0;
  String _editingToolName = '';

  int _currentEditId;

  List<GCWMultiDecoderTool> mdtTools;

  @override
  void initState() {
    super.initState();
    _editingToolNameController = TextEditingController(text: _editingToolName);

    refreshMultiDecoderTools();
  }

  @override
  void dispose() {
    _editingToolNameController.dispose();

    super.dispose();
  }

  _nameExists(name) {
    return mdtTools.indexWhere((tool) => tool.name == name) >= 0;
  }

  String _createName(String chosenInternalName) {
    var baseName = i18n(context, chosenInternalName + '_title');
    var name = baseName;

    int nameCounter = 1;
    while (_nameExists(name)) {
      name = '$baseName ${++nameCounter}';
    }

    return name;
  }

  _addNewTool() {
    var chosenInternalName = mdtToolsRegistry[_currentChosenTool];
    var name = _createName(chosenInternalName);

    print(mdtTools.map((e) => e.name).toList());
    var nameOccurrences = mdtTools.where((tool) => tool.name == name).length;
    if (nameOccurrences > 0)
      name = '$name ${nameOccurrences + 1}';

    MultiDecoderTool tool = MultiDecoderTool(
      name,
      chosenInternalName,
    );
    _currentEditId = insertMultiDecoderTool(tool);
    _editingToolNameController.text = name;
    _editingToolName = name;

    mdtTools.insert(0, multiDecoderToolToGCWMultiDecoderTool(tool));
  }

  _updateTool(GCWMultiDecoderTool tool) {
    var multiDecoderTool = findMultiDecoderToolById(tool.id);
    multiDecoderTool.name = tool.name;
    multiDecoderTool.options = tool.options.entries.map((option) {
      return MultiDecoderToolOption(option.key, option.value);
    }).toList();

    updateMultiDecoderTool(multiDecoderTool);
  }

  _deleteTool(int id) {
    deleteMultiDecoderTool(id);
    mdtTools.removeWhere((tool) => tool.id == id);
  }

  _refreshMDTTools() {
    mdtTools = multiDecoderTools.map((mdtTool) {
      return multiDecoderToolToGCWMultiDecoderTool(mdtTool);
    }).toList();
  }

  _moveUp(int id) {
    var oldIndex = moveMultiDecoderToolUp(id);
    if (oldIndex > 0) {
      var mdtTool = mdtTools.removeAt(oldIndex);
      mdtTools.insert(oldIndex - 1, mdtTool);
    }
  }

  _moveDown(int id) {
    var oldIndex = moveMultiDecoderToolDown(id);
    if (oldIndex < mdtTools.length - 1) {
      var mdtTool = mdtTools.removeAt(oldIndex);
      mdtTools.insert(oldIndex + 1, mdtTool);
    }
  }

  @override
  Widget build(BuildContext context) {
    _refreshMDTTools();

    return Column(
      children: <Widget>[
        GCWTextDivider(
          text: 'Add Tool',
        ),
        Row(
          children: [
            Expanded(
              child: Container(
                child: GCWDropDownButton(
                  value: _currentChosenTool,
                  onChanged: (value) {
                    setState(() {
                      _currentChosenTool = value;
                    });
                  },
                  items: mdtToolsRegistry.asMap().map((index, toolName) {
                    return MapEntry(
                      index,
                      GCWDropDownMenuItem(
                        value: index,
                        child: Text(i18n(context, toolName + '_title'))
                      )
                    );
                  }).values.toList(),
                ),
                padding: EdgeInsets.only(right: DOUBLE_DEFAULT_MARGIN)
              ),
            ),
            GCWIconButton(
              iconData: Icons.add,
              onPressed: () {
                _addNewTool();
                setState(() {
                });
              },
            ),
          ]
        ),
        GCWTextDivider(
          text: 'Configure Chosen Tools',
        ),
        _buildToollist()
      ],
    );
  }

  _buildToollist() {
    var odd = true;
    var rows = mdtTools.map((tool) {
      var row = Row(
        children: [
          Expanded(
            child: _currentEditId == tool.id
              ? Container(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: GCWText(text: 'Name'),
                            flex: 1
                          ),
                          Expanded(
                            child: GCWTextField(
                              controller: _editingToolNameController,
                              onChanged: (value) {
                                _editingToolName = value;
                              },
                            ),
                            flex: 3
                          )
                        ],
                      ),
                      tool.configurationWidget
                    ]
                  ),
                  padding: EdgeInsets.only(right: DOUBLE_DEFAULT_MARGIN)
                )
              : Column(
                  children: [
                    GCWText(
                      text: tool.name,
                    ),
                    Container(
                      child: GCWText(
                        text: tool.options.entries.map((entry) {
                          return '${entry.key}: ${entry.value}';
                        }).join('\n'),
                        style: gcwDescriptionTextStyle(),
                      ),
                      padding: EdgeInsets.only(left: DEFAULT_DESCRIPTION_MARGIN),
                    )
                  ],
                )
          ),
          Column(
            children: [
              _currentEditId == tool.id
                ? GCWIconButton(
                    iconData: Icons.check,
                    onPressed: () {
                      tool.name = _editingToolName;
                      _updateTool(tool);

                      setState(() {
                        _currentEditId = null;
                        _editingToolNameController.text = '';
                        _editingToolName = '';
                      });
                    },
                  )
                : GCWIconButton(
                    iconData: Icons.edit,
                    onPressed: () {
                      setState(() {
                        _currentEditId = tool.id;
                        _editingToolNameController.text = tool.name;
                        _editingToolName = tool.name;
                      });
                    },
                  ),
              GCWIconButton(
                iconData: Icons.remove,
                onPressed: () {
                  setState(() {
                    print(tool.name);
                    showDeleteAlertDialog(context, tool.name, () {
                      _deleteTool(tool.id);
                      setState(() {});
                    });
                  });
                },
              )
            ],
          ),
          Column(
            children: [
              GCWIconButton(
                iconData: Icons.arrow_drop_up,
                onPressed: () {
                  setState(() {
                    _moveUp(tool.id);
                  });
                },
              ),
              GCWIconButton(
                iconData: Icons.arrow_drop_down,
                onPressed: () {
                  setState(() {
                    _moveDown(tool.id);
                  });
                },
              )
            ],
          )
        ],
      );

      Widget output;
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

    return Column(
      children: rows,
    );
  }
}