import 'package:flutter/material.dart';
import 'package:gc_wizard/widgets/common/gcw_tool.dart';
import 'package:gc_wizard/widgets/common/gcw_toollist.dart';
import 'package:gc_wizard/widgets/registry.dart';
import 'package:gc_wizard/widgets/selector_lists/gcw_selection.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/number_sequences/lychrel.dart';
import 'package:gc_wizard/widgets/utils/common_widget_utils.dart';

class NumberSequenceLychrelSelection extends GCWSelection {
  @override
  Widget build(BuildContext context) {
    final List<GCWTool> _toolList = registeredTools.where((element) {
      return [
        className(NumberSequenceLychrelNthNumber()),
        className(NumberSequenceLychrelRange()),
        className(NumberSequenceLychrelDigits()),
        className(NumberSequenceLychrelCheckNumber()),
        className(NumberSequenceLychrelContainsDigits()),
      ].contains(className(element.tool));
    }).toList();

    return Container(child: GCWToolList(toolList: _toolList));
  }
}
