part of 'package:gc_wizard/common_widgets/coordinates/gcw_coords/gcw_coords.dart';

class _GCWCoordsDutchGrid extends StatefulWidget {
  final void Function(DutchGrid) onChanged;
  final DutchGrid coordinates;

  const _GCWCoordsDutchGrid({Key? key, required this.onChanged, required this.coordinates}) : super(key: key);

  @override
  _GCWCoordsDutchGridState createState() => _GCWCoordsDutchGridState();
}

class _GCWCoordsDutchGridState extends State<_GCWCoordsDutchGrid> {
  late TextEditingController _xController;
  late TextEditingController _yController;

  var _currentX = defaultDoubleText;
  var _currentY = defaultDoubleText;

  @override
  void initState() {
    super.initState();

    var dutchGrid = widget.coordinates;
    _currentX.value = dutchGrid.x;
    _currentY.value = dutchGrid.y;

    _xController = TextEditingController(text: _currentX.value.toString());
    _yController = TextEditingController(text: _currentY.value.toString());
  }

  @override
  void dispose() {
    _xController.dispose();
    _yController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Column(children: <Widget>[
      GCWDoubleTextField(
          hintText: i18n(context, 'coords_formatconverter_easting'),
          controller: _xController,
          onChanged: (ret) {
            setState(() {
              _currentX = ret;
              _setCurrentValueAndEmitOnChange();
            });
          }),
      GCWDoubleTextField(
          hintText: i18n(context, 'coords_formatconverter_northing'),
          controller: _yController,
          onChanged: (ret) {
            setState(() {
              _currentY = ret;
              _setCurrentValueAndEmitOnChange();
            });
          }),
    ]);
  }

  void _setCurrentValueAndEmitOnChange() {
    widget.onChanged(DutchGrid(_currentX.value, _currentY.value));
  }
}
