
import 'dart:isolate';

import 'package:gc_wizard/logic/tools/crypto_and_encodings/wherigo_urwigo/wherigo_viewer/wherigo_common.dart';

class CharacterData{
  final String CharacterLUAName;
  final String CharacterID;
  final String CharacterName;
  final String CharacterDescription;
  final String CharacterVisible;
  final String CharacterMediaName;
  final String CharacterIconName;
  final String CharacterLocation;
  final String CharacterContainer;
  final String CharacterGender;
  final String CharacterType;

  CharacterData(
      this.CharacterLUAName,
      this.CharacterID,
      this.CharacterName,
      this.CharacterDescription,
      this.CharacterVisible,
      this.CharacterMediaName,
      this.CharacterIconName,
      this.CharacterLocation,
      this.CharacterContainer,
      this.CharacterGender,
      this.CharacterType);
}


Map<String, dynamic> getCharactersFromCartridge(String LUA, dtable, obfuscator){
  RegExp re = RegExp(r'( = Wherigo.ZCharacter)');
  List<String> lines = LUA.split('\n');
  String line = '';
  List<CharacterData> Characters = [];
  Map<String, ObjectData> NameToObject = {};
  var out = Map<String, dynamic>();
  bool sectionCharacter = true;
  bool sectionDescription = true;

  String LUAname = '';
  String id = '';
  String name = '';
  String description = '';
  String visible = '';
  String media = '';
  String icon = '';
  String location = '';
  String gender = '';
  String type = '';
  String container = '';

  int maxLoop = lines.length;
  for (int i = 0; i < maxLoop; i++){
    line = lines[i];
    if (re.hasMatch(line)) {
      LUAname = '';
      id = '';
      name = '';
      description = '';
      visible = '';
      media = '';
      icon = '';
      location = '';
      gender = '';
      type = '';

      LUAname = getLUAName(line);
      container = getContainer(lines[i]);

      description = '';
      sectionCharacter = true;

      do {
        i++;
        if (lines[i].trim().startsWith(LUAname + 'Container =')) {
          container = getContainer(lines[i]);
        }

        if (lines[i].trim().startsWith(LUAname + '.Id')) {
          id = getLineData(lines[i], LUAname, 'Id', obfuscator, dtable);
        }

        if (lines[i].trim().startsWith(LUAname + '.Name')) {
          name = getLineData(lines[i], LUAname, 'Name', obfuscator, dtable);
        }

        if (lines[i].trim().startsWith(LUAname + '.Description')) {
          description = '';
          sectionDescription = true;
          do {
            description = description + lines[i];
            i++;
            if ((i) > lines.length - 1 || lines[i].startsWith(LUAname + '.Visible')) {
              sectionDescription = false;
            }
          } while (sectionDescription);
          description = description.replaceAll('[[', '').replaceAll(']]', '').replaceAll('<BR>', '\n');
          description = getLineData(description, LUAname, 'Description', obfuscator, dtable);
        }

        if (lines[i].startsWith(LUAname + '.Visible'))
          visible = getLineData(
              lines[i], LUAname, 'Visible', obfuscator, dtable);

        if (lines[i].startsWith(LUAname + '.Media'))
          media = getLineData(
              lines[i], LUAname, 'Media', obfuscator, dtable);

        if (lines[i].startsWith(LUAname + '.Icon'))
          icon = getLineData(
              lines[i], LUAname, 'Icon', obfuscator, dtable);

        if (lines[i].startsWith(LUAname + '.ObjectLocation'))
          location = getLineData(
              lines[i], LUAname, 'ObjectLocation', obfuscator, dtable);

        if (lines[i].startsWith(LUAname + '.Gender'))
          gender = getLineData(
              lines[i], LUAname, 'Gender', obfuscator, dtable);

        if (lines[i].startsWith(LUAname + '.Type'))
          type = getLineData(
              lines[i], LUAname, 'Type', obfuscator, dtable);

        if (lines[i].startsWith(LUAname + '.Type'))
          sectionCharacter = false;

      } while (sectionCharacter);

      Characters.add(CharacterData(
           LUAname ,
           id,
           name,
           description,
           visible,
           media,
           icon,
           location,
           container,
           gender,
           type
      ));
      NameToObject[LUAname] = ObjectData(id, name, media);
    } // end if
  }; // end for

  out.addAll({'content': Characters});
  out.addAll({'names': NameToObject});
  return out;
}
