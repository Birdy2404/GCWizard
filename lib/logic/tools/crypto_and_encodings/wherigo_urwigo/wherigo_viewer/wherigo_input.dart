
import 'package:gc_wizard/logic/tools/crypto_and_encodings/wherigo_urwigo/wherigo_viewer/wherigo_common.dart';

class InputData{
  final String InputLUAName;
  final String InputID;
  final String InputName;
  final String InputDescription;
  final String InputVisible;
  final String InputMedia;
  final String InputIcon;
  final String InputType;
  final String InputText;
  final List<String> InputChoices;

  InputData(
      this.InputLUAName,
      this.InputID,
      this.InputName,
      this.InputDescription,
      this.InputVisible,
      this.InputMedia,
      this.InputIcon,
      this.InputType,
      this.InputText,
      this.InputChoices);
}


List<InputData>getInputsFromCartridge(String LUA, dtable, obfuscator){
  RegExp re = RegExp(r'( = Wherigo.ZInput)');
  List<String> lines = LUA.split('\n');
  String line = '';

  bool section = true;
  int j = 1;
  int k = 1;
  String LUAname = '';
  String id = '';
  String name = '';
  String description = '';
  String visible = '';
  String media = '';
  String icon = '';
  String type = '';
  String text = '';
  List<String> choices = [];

  int index = 0;
  List<InputData> result = [];
  InputData item;
  for (int i = 0; i < lines.length; i++){
    line = lines[i];
    if (re.hasMatch(line)) {
      LUAname = getLUAName(line);
      id = getLineData(lines[i + 1], LUAname, 'Id', obfuscator, dtable);
      name = getLineData(lines[i + 2], LUAname, 'Name', obfuscator, dtable);

      description = '';
      section = true;
      j = 1;
      do {
        description = description + lines[i + 2 + j];
        j = j + 1;
        if ((i + 2 + j) > lines.length - 1 || lines[i + 2 + j].startsWith(LUAname + '.Visible'))
          section = false;
      } while (section);
      description = getLineData(description, LUAname, 'Description', obfuscator, dtable);

      section = true;
      do {
        if ((i + 2 + j) < lines.length - 1) {
          if (lines[i + 2 + j].startsWith(LUAname + '.Visible'))
            visible = getLineData(
                lines[i + 2 + j], LUAname, 'Visible', obfuscator, dtable);
          if (lines[i + 2 + j].startsWith(LUAname + '.Media'))
            media = getLineData(
                lines[i + 2 + j], LUAname, 'Media', obfuscator, dtable);
          if (lines[i + 2 + j].startsWith(LUAname + '.Icon'))
            icon = getLineData(
                lines[i + 2 + j], LUAname, 'Icon', obfuscator, dtable);
          if (lines[i + 2 + j].startsWith(LUAname + '.Type'))
            type = getLineData(
                lines[i + 2 + j], LUAname, 'Type', obfuscator, dtable);
          if (lines[i + 2 + j].startsWith(LUAname + '.Text'))
            text = getLineData(
                lines[i + 2 + j], LUAname, 'Text', obfuscator, dtable);
          if (lines[i + 2 + j].startsWith(LUAname + '.Choices')) {
            k = 1;
            do {
              while (lines[i + 2 + j + k].trimLeft().startsWith('""')) {
                choices.add(lines[i + 2 + j + k].trimLeft().replaceAll('"', ''));
                k++;
              }
            } while (lines[i + 2 + j + k].trimLeft().startsWith('"'));
            j = j + k;

          }
          if (lines[i + 2 + j].startsWith(LUAname + '.Text'))
            section = false;
          j = j + 1;
        }
      } while (section);

      result.add(InputData(
        LUAname,
        id,
        name,
        description,
        visible,
        media,
        icon,
        type,
        text,
        choices
      ));
      index = i;
      item = InputData(
          lines[index],
          lines[index + 1],
          lines[index + 2],
          lines[index + 3],
          lines[index + 4],
          lines[index + 5],
          lines[index + 6],
          lines[index + 7],
          lines[index + 8],
          []);
      result.add(item);
      i = i + 9;
    }
  };

  return result;
}
