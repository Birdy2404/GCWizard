import 'package:flutter/material.dart';
import 'package:gc_wizard/application/i18n/app_localizations.dart';
import 'package:gc_wizard/common_widgets/dropdowns/gcw_dropdown.dart';
import 'package:gc_wizard/common_widgets/dropdowns/gcw_stateful_dropdown.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/general_codebreakers/multi_decoder/widget/multi_decoder.dart';
import 'package:gc_wizard/tools/science_and_technology/numeral_bases/logic/numeral_bases.dart';
import 'package:gc_wizard/tools/science_and_technology/teletypewriter/_common/logic/teletypewriter.dart';
import 'package:gc_wizard/utils/collection_utils.dart';

const MDT_INTERNALNAMES_CCITT1 = 'multidecoder_tool_ccitt1_title';
const MDT_CCITT1_OPTION_MODE = 'common_mode';

const MDT_CCITT1_OPTION_MODE_DENARY = 'common_numeralbase_denary';
const MDT_CCITT1_OPTION_MODE_BINARY = 'common_numeralbase_binary';

class MultiDecoderToolCcitt1 extends AbstractMultiDecoderTool {
  MultiDecoderToolCcitt1({
    Key? key,
    required int id,
    required String name,
    required Map<String, Object?> options,
    required BuildContext context})
      : super(
            key: key,
            id: id,
            name: name,
            internalToolName: MDT_INTERNALNAMES_CCITT1,
            onDecode: (String input, String key) {
              if (options[MDT_CCITT1_OPTION_MODE] == MDT_CCITT1_OPTION_MODE_BINARY) {
                var intValues = textToBinaryList(input).map((value) {
                  return int.tryParse(convertBase(value, 2, 10) ?? '') ?? null;
                }).toList();
                return decodeTeletypewriter(intValues.whereType<int>().toList(),
                    TeletypewriterCodebook.CCITT_ITA1_EU);
              } else
                return decodeTeletypewriter(textToIntList(input), TeletypewriterCodebook.CCITT_ITA1_EU);
            },
            options: options,
            configurationWidget: MultiDecoderToolConfiguration(widgets: {
              MDT_CCITT1_OPTION_MODE: GCWStatefulDropDown<String>(
                value: toStringOrDefault(options[MDT_CCITT1_OPTION_MODE], MDT_CCITT1_OPTION_MODE_DENARY),
                onChanged: (newValue) {
                  options[MDT_CCITT1_OPTION_MODE] = newValue;
                },
                items: [MDT_CCITT1_OPTION_MODE_DENARY, MDT_CCITT1_OPTION_MODE_BINARY].map((mode) {
                  return GCWDropDownMenuItem(
                    value: mode,
                    child: i18n(context, mode),
                  );
                }).toList(),
              )
            }));
}
