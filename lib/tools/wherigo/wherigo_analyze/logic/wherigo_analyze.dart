import 'dart:typed_data';
import 'dart:isolate';
import 'dart:async';
import 'dart:math';

import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:flutter/material.dart';

import 'package:gc_wizard/utils/collection_utils.dart';
import 'package:gc_wizard/tools/wherigo/logic/earwigo_tools.dart';
import 'package:gc_wizard/tools/wherigo/logic/urwigo_tools.dart';

part 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/wherigo_analyze_gwc.dart';
part 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/wherigo_analyze_lua.dart';
part 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/wherigo_common.dart';
part 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/wherigo_global_variables.dart';
part 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/wherigo_global_classes.dart';
part 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/wherigo_global_const.dart';
part 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/wherigo_global_enums.dart';

Future<WherigoCartridge> getCartridgeAsync(dynamic jobData) async {
  WherigoCartridge output = WherigoCartridge();
  switch (jobData.parameters['dataType']) {
    case WHERIGO_DATA_TYPE_GWC:
      output = await getCartridgeGWC(jobData.parameters["byteListGWC"], jobData.parameters["offline"],
          sendAsyncPort: jobData.sendAsyncPort);
      break;
    case WHERIGO_DATA_TYPE_LUA:
      output = await getCartridgeLUA(jobData.parameters["byteListLUA"], jobData.parameters["offline"],
          sendAsyncPort: jobData.sendAsyncPort);
      break;
  }

  jobData?.sendAsyncPort?.send(output);

  return output;
}
