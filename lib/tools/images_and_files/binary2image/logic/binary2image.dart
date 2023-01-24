import 'dart:math';
import 'dart:typed_data';
import 'dart:ui';

import 'package:gc_wizard/logic/tools/crypto_and_encodings/substitution.dart';
import 'package:gc_wizard/utils/common_utils.dart';

Map<String, Color> colorMap = {
  '0': Color(0xFFFFFFFF), //Colors.white
  '1': Color(0xFF000000), //Colors.black
  '2': Color(0xFFFF5252), //Colors.redAccent //light red
  '3': Color(0xFFFFF9C4), //Colors.yellow.shade100 //light yellow
  '4': Color(0xFF8BC34A), //Colors.lightGreen
  '5': Color(0xFF18FFFF), //Colors.cyanAccent //light cyan,
  '6': Color(0xFF03A9F4), //Colors.lightBlue
  '7': Color(0xFFFF80AB), //Colors.pinkAccent.shade100 //light magenta,
  '8': Color(0xFFF44336), //Colors.red,
  '9': Color(0xFFFFFF00), //Colors.yellowAccent
  'A': Color(0xFF4CAF50), //Colors.green
  'B': Color(0xFF00BCD4), //Colors.cyan
  'C': Color(0xFF2196F3), //Colors.blue
  'D': Color(0xFFE040FB), //Colors.purpleAccent //magenta,
  'E': Color(0xFFB71C1C), //Colors.red.shade900 //dark red,
  'F': Color(0xFFFFEB3B), //Colors.yellow, //dark yellow,
  'G': Color(0xFF1B5E20), //Colors.green.shade900 //dark green,
  'H': Color(0xFF006064), //Colors.cyan.shade900 //dark cyan,
  'I': Color(0xFF0D47A1), //Colors.blue.shade900 //dark blue,
  'J': Color(0xFF9C27B0), //Colors.purple //dark magenta
  'K': Color(0xFFFF9800), //Colors.orange
  'L': Color(0xFFFF5722), //Colors.deepOrange
  'M': Color(0xFFFFAB40), //Colors.orangeAccent
  'N': Color(0xFF795548), //Colors.brown
  'O': Color(0xFF3E2723), //Colors.brown.shade900
  '#': Color(0xFFE0E0E0), //Colors.grey.shade300
};

Future<Uint8List> binary2image(String input, bool squareFormat, bool invers) async {
  var filter = _buildFilter(input);
  if (filter.length < 2) return null;

  if (!squareFormat) filter += "\n";
  input = _filterInput(input, filter);

  if (invers)
    input = substitution(input, {filter[0]: '1', filter[1]: '0'});
  else
    input = substitution(input, {filter[0]: '0', filter[1]: '1'});

  if (squareFormat) {
    var size = sqrt(input.length).ceil();
    input = insertSpaceEveryNthCharacter(input, size);
    input = input.replaceAll(RegExp('[ ]'), '\n');
  }

  return await _binary2Image(input);
}

Future<Uint8List> byteColor2image(String input) async {
  return await _binary2Image(input);
}

String _buildFilter(String input) {
  var alphabet = removeDuplicateCharacters(input);
  alphabet = alphabet.replaceAll(RegExp('[\r\n\t]'), '');
  var alphabetTmp = alphabet.split('').toList();
  alphabetTmp.sort();
  alphabet = alphabetTmp.join();

  if (alphabet.length <= 2) {
    return alphabet;
  }

  if (alphabet.length == 3 && alphabet.contains(' ')) return alphabet.replaceAll(' ', '');

  var filter = '';
  var map = Map<String, int>();

  alphabet.split('').forEach((char) {
    map.addAll({char: char.allMatches(input).length});
  });

  var countList = map.values.toList();
  countList.sort();

  for (int i = 0; i < countList.length; i++) {
    map.forEach((key, value) {
      if (value == countList[i]) filter += key;
    });
    map.removeWhere((key, value) => value == countList[i]);
  }
  filter = filter.split('').reversed.join();

  filter = filter.substring(0, 3);
  if (filter.contains(' '))
    return filter.replaceAll(' ', '');
  else
    return filter.substring(0, 2);
}

String _filterInput(String input, String filter) {
  var special = ".\$*+-?";
  special.split('').forEach((char) {
    filter = filter.replaceAll(char, '\\' + char);
  });

  return input.replaceAll(RegExp('[^$filter]'), '');
}

Future<Uint8List> _binary2Image(String input) async {
  if (input == '' || input == null) return null;

  var lines = input.split('\n');

  if (lines.length == 1)
    lines.addAll([lines[0], lines[0], lines[0], lines[0], lines[0], lines[0], lines[0], lines[0], lines[0]]);
  return input2Image(lines);
}

Future<Uint8List> input2Image(List<String> lines,
    {Map<String, Color> colors, int bounds = 10, double pointSize = 5.0}) async {
  var width = 0.0;
  var height = 0.0;

  if (lines == null) return null;

  lines.forEach((line) {
    width = max(width, line.length.toDouble());
    height++;
  });
  width = width * pointSize + 2 * bounds;
  height = height * pointSize + 2 * bounds;

  final canvasRecorder = PictureRecorder();
  final canvas = Canvas(canvasRecorder, Rect.fromLTWH(0, 0, width, height));

  final paint = Paint()
    ..color = colorMap.values.first //Colors.white
    ..style = PaintingStyle.fill;

  canvas.drawRect(Rect.fromLTWH(0, 0, width, height), paint);
  if (colors == null) colors = colorMap;
  for (int row = 0; row < lines.length; row++) {
    for (int column = 0; column < lines[row].length; column++) {
      paint.color = colorMap.values.first; // Colors.white
      if (colors.containsKey(lines[row][column])) paint.color = colors[lines[row][column]];

      if (lines[row][column] != '0')
        canvas.drawRect(
            Rect.fromLTWH(column * pointSize + bounds, row * pointSize + bounds, pointSize, pointSize), paint);
    }
  }

  final img = await canvasRecorder.endRecording().toImage(width.floor(), height.floor());
  final data = await img.toByteData(format: ImageByteFormat.png);

  return trimNullBytes(data.buffer.asUint8List());
}
