import 'package:flutter/material.dart';
import 'package:gc_wizard/widgets/common/gcw_tool.dart';
import 'package:gc_wizard/widgets/registry.dart';
import 'package:gc_wizard/widgets/utils/no_animation_material_page_route.dart';


// A Widget that accepts the necessary arguments via the
// constructor.
NoAnimationMaterialPageRoute createRoute (BuildContext context, ScreenArguments arguments) {
  if (arguments?.title == null) return null;
  var name = arguments.title.toLowerCase();
  List<GCWTool> tools;
  try {
    tools = registeredTools.where((tool) => tool.i18nPrefix == name).toList();

    //registeredTools.forEach((element) {print(element.i18nPrefix); });

    if (tools == null || tools.isEmpty) {
      var groups = {
        'astronomy',
        'base',
        'bcd',
        'bundeswehr',
        'coords',
        'countries',
        'crosssum',
        'dates',
        'dna',
        'earwigo',
        'hashes',
        'irrationalnumbers',
        'numbersequence',
        'primes',
        'rotation',
        'segmentdisplay',
        'symboltables',
        'telegraph',
        'urwigo',
        'vanity',
      };

      var specialEntrys= (
        {'symboltables_examples': 'symboltablesexamples'}
      );

      //case 'format_converter': // coords converter

      if (groups.contains(name) && (arguments.arguments != null && arguments.arguments.isNotEmpty)) {
        name = name + '_' + arguments.arguments[0].value;
        if (specialEntrys.keys.contains(name))
          name = specialEntrys[name];
       }
      tools = registeredTools.where((tool) => tool.i18nPrefix == name).toList();
    }
  } catch (e) {}
  if (tools == null || tools.isEmpty) return null;

  // arguments settings only for view the path in the url
  return NoAnimationMaterialPageRoute(builder: (context) => tools[0], settings: arguments.settings);
}

// You can pass any object to the arguments parameter.
// In this example, create a class that contains both
// a customizable title and message.
class ScreenArguments {
  String title;
  List<MapEntry<String, String>> arguments;
  RouteSettings settings;


  ScreenArguments(RouteSettings setting) {
    var regExp = RegExp(r'^(\/)([^#?]+)\??([^\.]*)');
    var match = regExp.firstMatch(setting.name);

    settings = setting;

    if (match != null) {
      title = match.group(2);
      if (match.groupCount > 2) {
        regExp = RegExp(r'([\w]+)=([\w]+)\&?');
        var argumentString = match.group(3);
        var matches = regExp.allMatches(argumentString);
        if (matches != null && argumentString.isNotEmpty) {
          arguments = <MapEntry<String, String>>[];
          matches.forEach((match) {
            arguments.add(MapEntry<String, String>(match.group(1), match.group(2)));
          });
          if (matches.isEmpty)
            arguments.add(MapEntry<String, String>('argument', argumentString));
        }
      }
    }
  }
}