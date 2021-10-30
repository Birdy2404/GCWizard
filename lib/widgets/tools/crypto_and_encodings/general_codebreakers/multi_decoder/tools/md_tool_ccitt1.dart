import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/ccitt1.dart';
import 'package:gc_wizard/logic/tools/science_and_technology/numeral_bases.dart';
import 'package:gc_wizard/utils/common_utils.dart';
import 'package:gc_wizard/widgets/common/gcw_twooptions_switch.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/general_codebreakers/multi_decoder/gcw_multi_decoder_tool.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/general_codebreakers/multi_decoder/gcw_multi_decoder_tool_configuration.dart';

const MDT_INTERNALNAMES_CCITT1 = 'multidecoder_tool_ccitt1_title';
const MDT_CCITT1_OPTION_MODE = 'ccitt1_numeralbase';

const MDT_CCITT1_OPTION_MODE_DENARY = 'denary';
const MDT_CCITT1_OPTION_MODE_BINARY = 'binary';

class MultiDecoderToolCcitt1 extends GCWMultiDecoderTool {
  MultiDecoderToolCcitt1({Key key, int id, String name, Map<String, dynamic> options, BuildContext context})
      : super(
            key: key,
            id: id,
            name: name,
            internalToolName: MDT_INTERNALNAMES_CCITT1,
            onDecode: (String input, String key) {
              if (options[MDT_CCITT1_OPTION_MODE] == MDT_CCITT1_OPTION_MODE_BINARY) {
                return decodeCCITT1(textToBinaryList(input).map((value) {
                  return int.tryParse(convertBase(value, 2, 10));
                }).toList());
              } else
                return decodeCCITT1(textToIntList(input));
            },
            options: options,
            configurationWidget: GCWMultiDecoderToolConfiguration(widgets: {
              MDT_CCITT1_OPTION_MODE: GCWTwoOptionsSwitch(
                value: options[MDT_CCITT1_OPTION_MODE] == MDT_CCITT1_OPTION_MODE_BINARY ? GCWSwitchPosition.right : GCWSwitchPosition.left,
                notitle: true,
                leftValue: i18n(context, 'common_numeralbase_denary'),
                rightValue: i18n(context, 'common_numeralbase_binary'),
                onChanged: (value) {
                  options[MDT_CCITT1_OPTION_MODE] = value == GCWSwitchPosition.left ? MDT_CCITT1_OPTION_MODE_DENARY : MDT_CCITT1_OPTION_MODE_BINARY;
                },
              )
            }));
}
