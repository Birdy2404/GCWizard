part of 'package:gc_wizard/tools/games/number_pyramid/widget/number_pyramid_solver.dart';

Point<int>? selectedBox;
Rect? selectedBoxRect;

class NumberPyramidBoard extends StatefulWidget {
  final NumberPyramidFillType type;
  final void Function(NumberPyramid) onChanged;
  final NumberPyramid board;

  const NumberPyramidBoard({Key? key, required this.onChanged,
    required this.board, this.type = NumberPyramidFillType.CALCULATED})
      : super(key: key);

  @override
  NumberPyramidBoardState createState() => NumberPyramidBoardState();
}

class NumberPyramidBoardState extends State<NumberPyramidBoard> {
  int? _currentValue;
  late TextEditingController _currentInputController;
  late GCWIntegerTextInputFormatter _integerInputFormatter;
  final _currentValueFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    _currentInputController = TextEditingController();
    _integerInputFormatter = GCWIntegerTextInputFormatter(min: 0, max: 999999);
  }

  @override
  void dispose() {
    _currentInputController.dispose();
    _currentValueFocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return
        Expanded(
            child:
              Stack(children:<Widget>[
                  AspectRatio(
                      aspectRatio: 1 / 0.5,
                      child: CanvasTouchDetector(
                        gesturesToOverride: const [GestureType.onTapDown],
                        builder: (context) {
                          return CustomPaint(
                            painter: NumberPyramidBoardPainter(context, widget.type, widget.board, _showBoxValue)
                          );
                        },
                      )
                  ),
                  _editWidget()
              ])
    );
  }

  Widget _editWidget() {
    ThemeColors colors = themeColors();
    if (selectedBoxRect != null && selectedBox  != null) {
      _currentValue = widget.board.getValue(selectedBox!.x, selectedBox!.y);
      _currentInputController.text = _currentValue?.toString() ?? '';

      return Positioned(
          left: selectedBoxRect!.left,
          top: selectedBoxRect!.top,
          width: selectedBoxRect!.width,
          height: selectedBoxRect!.height,
          child: TextFormField(
              textAlign: TextAlign.center,
              //textAlignVertical: TextAlignVertical.center,
              controller: _currentInputController,
              inputFormatters: [_integerInputFormatter],
              keyboardType: const TextInputType.numberWithOptions(),
              autofocus: true,
              focusNode: _currentValueFocusNode,
              style: TextStyle(
                //height: selectedBoxRect!.height-5,
                fontSize: selectedBoxRect!.height * 0.8,
                color: colors.secondary(),
              ),
              onChanged: (value) {
                setState(() {
                  _currentValue = int.tryParse(value);
                  var type = NumberPyramidFillType.USER_FILLED;
                  if (_currentValue == null) type = NumberPyramidFillType.CALCULATED;
                  if (selectedBox != null &&
                      widget.board.setValue(selectedBox!.x, selectedBox!.y, _currentValue, type)) {
                    widget.board.removeCalculated();
                  }
                });
              }
          )
      ); //SizedBox (width: 60, child: Column(children: [textBox()])))
    }
    return Container();
  }

  void _showBoxValue(Point<int>? selectedBox) {
    setState(() {

    });
  }
}

class NumberPyramidBoardPainter extends CustomPainter {
  final BuildContext context;
  final void Function(Point<int>?) showBoxValue;
  final NumberPyramidFillType type;
  final NumberPyramid board;

  NumberPyramidBoardPainter(this.context, this.type, this.board, this.showBoxValue);

  @override
  void paint(Canvas canvas, Size size) {
    var _touchCanvas = TouchyCanvas(context, canvas);
    ThemeColors colors = themeColors();

    var paint = Paint();
    var paintBack = Paint();
    var selectedRect = const Rect.fromLTRB(0, 0, 0, 0);
    paint.strokeWidth = 1;
    paint.style = PaintingStyle.stroke;
    paint.color = colors.secondary();

    paintBack.style = PaintingStyle.fill;
    paintBack.color = colors.gridBackground();

    const border = 2;
    double widthOuter = size.width - 2 * border;
    double heightOuter = size.height - 2 * border;
    double xOuter = border.toDouble();
    double yOuter = border.toDouble();
    double widthInner = widthOuter / board.getRowsCount();
    double heightInner = min(heightOuter /  board.getRowsCount(), widthInner / 2);

    for (int y = 0; y < board.getRowsCount(); y++) {
      double xInner = (widthOuter + xOuter - (y + 1) * widthInner) / 2;
      double yInner = yOuter + y * heightInner;

      for (int x = 0; x < board.getColumnsCount(y); x++) {
        var boardY = y;
        var boardX = x;

        var rect = Rect.fromLTWH(xInner, yInner, widthInner, heightInner);
        _touchCanvas.drawRect(rect, paintBack,
            onTapDown: (tapDetail) {
              selectedBox = Point<int>(boardX, boardY);
              selectedBoxRect = rect;
              showBoxValue(selectedBox);
            }
        );

        if (selectedBox != null && selectedBox!.x == x && selectedBox!.y == y) {
          selectedRect = Rect.fromLTWH(xInner, yInner, widthInner, heightInner);
        }

        _touchCanvas.drawRect(Rect.fromLTWH(xInner, yInner, widthInner, heightInner), paint);

        if (board.getValue(boardX, boardY) != null) {
          var textColor =
            board.getFillType(boardX, boardY) == NumberPyramidFillType.USER_FILLED ? colors.secondary() : colors.mainFont();

          var fontsize = heightInner * 0.8;
          var text = board.getValue(boardX, boardY)?.toString();
          var textPainter = _buildTextPainter(text ?? '', textColor, fontsize);

          while (textPainter.width > widthInner) {
            fontsize *= 0.95;
            if (fontsize < heightInner * 0.8 * 0.5) { // min. 50% fontsize
              if (text == null || text.length < 2) break;
              var splitPos = (text.length / 2).ceil();
              text = text.substring(0, splitPos) + '\n' + text.substring(splitPos);
              textPainter = _buildTextPainter(text, textColor, fontsize);
              break;
            }
            textPainter = _buildTextPainter(text ?? '', textColor, fontsize);
          }

          if (selectedRect.isEmpty) {
            textPainter.paint(
                canvas,
                Offset(xInner + (widthInner  - textPainter.width) * 0.5,
                      yInner + (heightInner - textPainter.height) * 0.5));
          }
        }

        xInner += widthInner;
      }
    }

    if (!selectedRect.isEmpty) {
      paint.color = colors.focused();
      _touchCanvas.drawRect(selectedRect, paint);
    }

    // var rect =
    // _touchCanvas.drawRect(rect, paintBack,
    //     onTapDown: (tapDetail) {
    //       selectedBox = Point<int>(boardX, boardY);
    //       selectedBoxRect = rect;
    //       showBoxValue(boardX, boardY);
    //     }
    // );
  }

  TextPainter _buildTextPainter(String text, Color color, double fontsize) {
    TextSpan span = TextSpan(
        style: gcwTextStyle().copyWith(color: color, fontSize: fontsize),
        text: text);
    TextPainter textPainter = TextPainter(text: span, textDirection: TextDirection.ltr);
    textPainter.layout();

    return textPainter;
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
