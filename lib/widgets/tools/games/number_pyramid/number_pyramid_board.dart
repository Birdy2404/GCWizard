import 'dart:math';
import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/games/number_pyramid_solver.dart';
import 'package:gc_wizard/theme/theme.dart';
import 'package:gc_wizard/theme/theme_colors.dart';
import 'package:gc_wizard/widgets/common/base/gcw_button.dart';
import 'package:gc_wizard/widgets/common/base/gcw_dialog.dart';
import 'package:gc_wizard/widgets/common/gcw_integer_textfield.dart';
import 'package:touchable/touchable.dart';

Point<int> _selectedBox;

class NumberPyramidBoard extends StatefulWidget {
  final NumberPyramidFillType type;
  final Function(int, int) showBoxValue;
  final Function onChanged;
  final NumberPyramid board;

  NumberPyramidBoard({Key key, this.onChanged, this.showBoxValue, this.board, this.type: NumberPyramidFillType.CALCULATED})
      : super(key: key);

  @override
  NumberPyramidBoardState createState() => NumberPyramidBoardState();
}

class NumberPyramidBoardState extends State<NumberPyramidBoard> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
            child: AspectRatio(
                aspectRatio: 1 / 0.5,
                child: CanvasTouchDetector(
                  gesturesToOverride: [GestureType.onTapDown],
                  builder: (context) {
                    return CustomPaint(
                      painter: NumberPyramidBoardPainter(context, widget.type, widget.board, (x, y, value) {
                          setState(() {
                            if (value == null)
                              widget.board.setValue(x, y, null, NumberPyramidFillType.CALCULATED);
                            else
                              widget.board.setValue(x, y, value, NumberPyramidFillType.USER_FILLED);

                            widget.onChanged(widget.board);
                          });
                        },
                        widget.showBoxValue)
                    );
                  },
                )))
      ],
    );
  }
}

class NumberPyramidBoardPainter extends CustomPainter {
  final Function(int, int, int) setBoxValue;
  final Function(int, int) showBoxValue;
  final NumberPyramid board;
  final BuildContext context;
  final NumberPyramidFillType type;

  NumberPyramidBoardPainter(this.context, this.type, this.board, this.setBoxValue, this.showBoxValue);

  @override
  void paint(Canvas canvas, Size size) {
    var _touchCanvas = TouchyCanvas(context, canvas);
    ThemeColors colors = themeColors();

    var paint = Paint();
    var paintBack = Paint();
    Rect selectedRect;
    paint.strokeWidth = 1;
    paint.style = PaintingStyle.stroke;
    paint.color = colors.accent();
    paintBack.style = PaintingStyle.fill;
    paintBack.color = colors.gridBackground();

    double widthOuter = size.width;
    double heightOuter = size.height;
    double xOuter = 0 * widthOuter;
    double yOuter = 0 * heightOuter;
    double widthInner = widthOuter / board.getRowsCount();
    double heightInner = min(heightOuter /  board.getRowsCount(), widthInner / 2);


    for (int i = 0; i < board.getRowsCount(); i++) {
      double xInner = (widthOuter + xOuter - (i+1) * widthInner) / 2;
      double yInner = yOuter + i * heightInner;

      for (int j = 0; j < board.getColumnsCount(i); j++) {
        var boardY = i;
        var boardX = j;

        _touchCanvas.drawRect(Rect.fromLTWH(xInner, yInner, widthInner, heightInner), paintBack,
            onTapDown: (tapDetail) {
              //_removeCalculated(board);
              //_showInputDialog(boardX, boardY);
              _selectedBox = Point<int>(boardX, boardY);
              showBoxValue(boardX, boardY);
            });


        if (_selectedBox != null && _selectedBox.x == j  && _selectedBox.y == i)
          selectedRect = Rect.fromLTWH(xInner, yInner, widthInner, heightInner);

        _touchCanvas.drawRect(Rect.fromLTWH(xInner, yInner, widthInner, heightInner), paint);

        if (board.getValue(boardX, boardY) != null) {
          var textColor =
              board.getType(boardX, boardY) == NumberPyramidFillType.USER_FILLED ? colors.accent() : colors.mainFont();

          var fontsize = heightInner * 0.8;
          TextSpan span = TextSpan(
              style: gcwTextStyle().copyWith(color: textColor, fontSize: fontsize),
              text: board.getValue(boardX, boardY).toString());
          TextPainter textPainter = TextPainter(text: span, textDirection: TextDirection.ltr);
          textPainter.layout();
          while (textPainter.width > widthInner) {
            fontsize *= 0.95;
            if (fontsize < heightInner * 0.8 * 0.5) { // min. 50% fontsize
              var splitPos = (span.text.length / 2).ceil();
              span = TextSpan(
                  style: span.style.copyWith(fontSize: fontsize),
                  text: span.text.substring(0, splitPos) + '\n' + span.text.substring(splitPos));
              textPainter = TextPainter(text: span, textDirection: TextDirection.ltr);
              textPainter.layout();
              break;
            }

            span = TextSpan(
                style: span.style.copyWith(fontSize: fontsize),
                text: span.text);
            textPainter = TextPainter(text: span, textDirection: TextDirection.ltr);
            textPainter.layout();
          }

          textPainter.paint(
              canvas,
              Offset(xInner + (widthInner - textPainter.width) * 0.5,
                  yInner + (heightInner - textPainter.height) * 0.5));
        }

        xInner += widthInner;
      }
    }

    if (selectedRect != null) {
      paint.color = colors.focused();
      _touchCanvas.drawRect(selectedRect, paint);
    }
  }

  _showInputDialog(int x, y) {
    var columns = <Widget>[];
    int _value = 0;

    columns.add(
      Container(
        width: 100,
        height: 30,
        child:         GCWIntegerTextField(
            onChanged:  (ret) {
              _value = ret['value'];
            }
      )

    ));

    for (int i = 0; i < 3; i++) {
      var rows = <Widget>[];
      for (int j = 0; j < 3; j++) {
        var value = i * 3 + j + 1;

        rows.add(GCWButton(
          text: value.toString(),
          textStyle: gcwTextStyle().copyWith(fontSize: 32, color: themeColors().dialogText()),
          onPressed: () {
            _value = i * 3 + j + 1;
            // Navigator.of(context).pop();
            // setBoxValue(x, y, value);
          },
        ));
      }

      columns.add(Row(
        children: rows,
      ));
    }

    columns.add(GCWButton(
      text: i18n(context, 'sudokusolver_removevalue'),
      onPressed: () {
        Navigator.of(context).pop();
        setBoxValue(x, y, null);
      },
    ));

    columns.add(GCWButton(
      text: 'Enter',
      onPressed: () {
        Navigator.of(context).pop();
        setBoxValue(x, y, _value);
      },
    ));

    showGCWDialog(
        context,
        i18n(context, 'sudokusolver_entervalue'),
        Container(
          height: 300,
          child: Column(children: columns),
        ),
        []);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
