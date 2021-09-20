import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:gc_wizard/theme/fixed_colors.dart';
import 'package:gc_wizard/widgets/utils/file_utils.dart';
import 'package:qr/qr.dart' as qr;
import 'package:google_ml_kit/google_ml_kit.dart' as google;


/// Parse to code string with Uint8list
Future<String> scanBytes(Uint8List bytes) async {
  if (bytes == null) return null;
  try {
    var ocr =google.BarcodeScanner();
    var file = await createTmpFile('',bytes);
    var inputImage = google.InputImage.fromFile(file);

    var codes = await ocr.processImage(inputImage);
    if (codes != null)
      return codes.map((code ) {
        return code.value.rawValue;
        }).join("\n");

    ocr.close();
    file.delete();
  } catch (e) {}
  return null;
}

/// Generating Bar Code
Future<Uint8List> generateBarCode(String code) async {
  if (code == null || code == "") return null;

  var qrCode = qr.QrCode.fromData(
    data: code,
    errorCorrectLevel: qr.QrErrorCorrectLevel.L,
  );

  return _createQrCode(qrCode);
}

Future<Uint8List> _createQrCode(qr.QrCode qrCode, {double border = 10}) async {
  try {
    qrCode.make();
    const double moduleSize = 5;
    final canvasRecorder = ui.PictureRecorder();
    final rect = ui.Rect.fromLTWH(0, 0, moduleSize * qrCode.moduleCount + 2 * border, moduleSize * qrCode.moduleCount + 2 * border);
    final canvas = ui.Canvas(canvasRecorder, rect);
    final paint = ui.Paint()
      ..color = COLOR_QR_BACKGROUND
      ..style = ui.PaintingStyle.fill;

    canvas.drawRect(rect, paint);
    paint.color = Colors.black;
    for (int x = 0; x < qrCode.moduleCount; x++) {
      for (int y = 0; y < qrCode.moduleCount; y++) {
        if (qrCode.isDark(y, x)) {
          canvas.drawRect(ui.Rect.fromLTWH(x*moduleSize+border,y*moduleSize+border,moduleSize,moduleSize), paint);
        }
      }
    }
    var image = await canvasRecorder.endRecording().toImage(rect.width.floor(), rect.height.floor());

    final data = await image.toByteData(format: ui.ImageByteFormat.png);
    return data.buffer.asUint8List();
  } catch (e) {
    return null;
  }

}

Future<Uint8List> addBorder(Uint8List imageBytes, {double border = 10}) async {
  try {
    return addImageBorder(await _bytesToImage(imageBytes), border: border);
  } catch (e) {
    return null;
  }
}

Future<Uint8List> addImageBorder(ui.Image image, {double border = 10}) async {
  try {
    final canvasRecorder = ui.PictureRecorder();
    final rect = ui.Rect.fromLTWH(0, 0, image.width + 2 * border, image.height + 2 * border);
    final canvas = ui.Canvas(canvasRecorder, rect);
    final paint = ui.Paint()
      ..color = COLOR_QR_BACKGROUND
      ..style = ui.PaintingStyle.fill;

    canvas.drawRect(rect, paint);
    canvas.drawImage(image, ui.Offset(border, border), paint);
    image = await canvasRecorder.endRecording().toImage(rect.width.floor(), rect.height.floor());

    final data = await image.toByteData(format: ui.ImageByteFormat.png);
    return data.buffer.asUint8List();
  } catch (e) {
    return null;
  }
}

Future<ui.Image> _bytesToImage(Uint8List imgBytes) async {
  ui.Codec codec = await ui.instantiateImageCodec(imgBytes);
  ui.FrameInfo frame = await codec.getNextFrame();
  return frame.image;
}
