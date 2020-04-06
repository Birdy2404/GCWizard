import 'package:flutter/material.dart';
import 'package:gc_wizard/widgets/common/gcw_tool.dart';
import 'package:gc_wizard/widgets/common/gcw_toollist.dart';
import 'package:gc_wizard/widgets/registry.dart';
import 'package:gc_wizard/widgets/selector_lists/gcw_selection.dart';
import 'package:gc_wizard/widgets/tools/crypto/vanity_singlenumbers.dart';
import 'package:gc_wizard/widgets/tools/date_and_time/day_calculator.dart';
import 'package:gc_wizard/widgets/tools/date_and_time/weekday.dart';
import 'file:///E:/workspace/GCWizard/lib/widgets/tools/crypto/vanity_multiplenumbers.dart';
import 'package:gc_wizard/widgets/utils/common_widget_utils.dart';

class VanitySelection extends GCWSelection {
  @override
  Widget build(BuildContext context) {

    final List<GCWToolWidget> _toolList =
      Registry.toolList.where((element) {
        return [
          className(VanitySingleNumbers()),
          className(VanityMultipleNumbers()),
        ].contains(className(element.tool));
      }).toList();

    return Container(
      child: GCWToolList(
        toolList: _toolList
      )
    );
  }
}