import 'dart:async';
import 'dart:math';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:flutter_map_marker_popup/flutter_map_marker_popup.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/coords/data/ellipsoid.dart';
import 'package:gc_wizard/logic/tools/coords/utils.dart';
import 'package:gc_wizard/theme/fixed_colors.dart';
import 'package:gc_wizard/theme/theme.dart';
import 'package:gc_wizard/theme/theme_colors.dart';
import 'package:gc_wizard/widgets/common/base/gcw_iconbutton.dart';
import 'package:gc_wizard/widgets/common/base/gcw_output_text.dart';
import 'package:gc_wizard/widgets/common/base/gcw_text.dart';
import 'package:gc_wizard/widgets/tools/coords/base/gcw_map_geometries.dart';
import 'package:gc_wizard/widgets/tools/coords/base/utils.dart';
import 'package:gc_wizard/widgets/utils/common_widget_utils.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong/latlong.dart';
import 'package:url_launcher/url_launcher.dart';

enum _LayerType {OPENSTREETMAP_MAPNIK, MAPBOX_SATELLITE}

final OSM_TEXT = 'coords_mapview_osm';
final OSM_URL = 'coords_mapview_osm_url';
final MAPBOX_SATELLITE_TEXT = 'coords_mapview_mapbox_satellite';
final MAPBOX_SATELLITE_URL = 'coords_mapview_mapbox_satellite_url';

class GCWMapView extends StatefulWidget {
  final List<MapPoint> points;
  final List<MapGeodetic> geodetics;
  final List<MapCircle> circles;

  const GCWMapView({Key key, this.points, this.geodetics, this.circles})
      : super(key: key);

  @override
  GCWMapViewState createState() => GCWMapViewState();
}

class GCWMapViewState extends State<GCWMapView> {
  final PopupController _popupLayerController = PopupController();
  final MapController _mapController = MapControllerImpl();

  _LayerType _currentLayer = _LayerType.OPENSTREETMAP_MAPNIK;
  var _mapBoxToken;

  StreamSubscription<Position> _positionStreamSubscription;
  Position _currentPosition;
  var _useUserPosition = true;
  var _currentPermissionGranted = false;

  //////////////////////////////////////////////////////////////////////////////
  // from: https://stackoverflow.com/a/58958668/3984221
  LatLng computeCentroid(Iterable<LatLng> points) {
    double latitude = 0;
    double longitude = 0;
    int n = points.length;

    for (LatLng point in points) {
      latitude += point.latitude;
      longitude += point.longitude;
    }

    return LatLng(latitude / n, longitude / n);
  }

  //////////////////////////////////////////////////////////////////////////////

  //////////////////////////////////////////////////////////////////////////////
  // from: https://stackoverflow.com/a/13274361/3984221

  double _latRad(_lat) {
    var _sin = sin(_lat * PI / 180);
    var _radX2 = log((1 + _sin) / (1 - _sin)) / 2;
    return max(min(_radX2, PI), -PI) / 2;
  }

  int _zoom(_mapPx, _worldPx, _fraction) {
    return (log(_mapPx / _worldPx / _fraction) / ln2).floor();
  }

  int _getBoundsZoomLevel() {
    var _mapDim = MediaQuery.of(context).size;
    var _worldDim = {'height': 256, 'width': 256};
    var _zoomMax = 18;

    var _bounds = LatLngBounds();
    widget.points.forEach((point) => _bounds.extend(point.point));

    var _ne = _bounds.northEast;
    var _sw = _bounds.southWest;

    var _latFraction = (_latRad(_ne.latitude) - _latRad(_sw.latitude)) / PI;

    var _lngDiff = _ne.longitude - _sw.longitude;
    var _lngFraction = ((_lngDiff < 0) ? (_lngDiff + 360) : _lngDiff) / 360;

    var _latZoom = _zoomMax;
    if (_latFraction > 0.0)
      _latZoom = _zoom(_mapDim.height, _worldDim['height'], _latFraction);

    var _lngZoom = _zoomMax;
    if (_lngFraction > 0.0)
      _lngZoom = _zoom(_mapDim.width, _worldDim['width'], _lngFraction);

    return min(min(_latZoom, _lngZoom), _zoomMax);
  }

  //////////////////////////////////////////////////////////////////////////////

  Future<String> _loadToken(String tokenName) async {
    return await rootBundle.loadString('assets/tokens/$tokenName');
  }

  @override
  void dispose() {
    if (_positionStreamSubscription != null) {
      _positionStreamSubscription.cancel();
      _positionStreamSubscription = null;
    }

    super.dispose();
  }

  void _toggleListening() {
    if (_positionStreamSubscription == null) {
      final positionStream = getPositionStream(
        timeInterval: 10000
      );
      _positionStreamSubscription = positionStream.handleError((error) {
        _positionStreamSubscription.cancel();
        _positionStreamSubscription = null;
      }).listen((position) => setState(() => _currentPosition = position));
      _positionStreamSubscription.pause();
    }

    setState(() {
      if (_positionStreamSubscription.isPaused) {
        _positionStreamSubscription.resume();
      } else {
        _positionStreamSubscription.pause();
      }
    });
  }

  Future<LocationPermission>_checkPermission() {
    checkPermission().then((permission) {
      var newPermission = false;
      if (permission != null && [LocationPermission.always, LocationPermission.whileInUse].contains(permission))
        newPermission = true;

      if (permission == LocationPermission.denied)
        requestPermission().then((status) => setState(_currentPosition = null));

      if (newPermission != _currentPermissionGranted) {
        setState(() {
          _currentPermissionGranted = newPermission;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_useUserPosition && !_currentPermissionGranted)
      _checkPermission();

    //Marker Shadow
    List<Marker> _markers = widget.points.map((_point) {
      return GCWMarker(
        coordinateDescription: _buildPopupCoordinateDescription(_point),
        coordinateText: _buildPopupCoordinateText(_point),
        width: 28.3,
        height: 28.3,
        point: _point.point,
        builder: (context) {
          return Icon(
            Icons.my_location,
            size: 28.3,
            color: COLOR_MAP_POINT_OUTLINE,
          );
        }
      );
    }).toList();

    //colored Markers
    _markers.addAll(
      widget.points.map((_point) {
        return GCWMarker(
          coordinateDescription: _buildPopupCoordinateDescription(_point),
          coordinateText: _buildPopupCoordinateText(_point),
          width: 25.0,
          height: 25.0,
          point: _point.point,
          builder: (context) {
            return Icon(
              Icons.my_location,
              size: 25.0,
              color: _point.color,
            );
          }
        );
      }).toList()
    );

    if (_useUserPosition && _currentPosition != null) {
      _markers.add(GCWMarker(
        coordinateDescription: 'My Coords',
        coordinateText: _currentPosition.latitude.toString() + ' ' + _currentPosition.longitude.toString(),
        width: 25.0,
        height: 25.0,
        point: LatLng(_currentPosition.latitude, _currentPosition.longitude),
        builder: (context) {
          return Icon(
            Icons.my_location,
            size: 25.0,
            color: Colors.cyan,
          );
        }
      ));
    }

    print(_markers[2].point);

    List<Polyline> _polylines = _addPolylines();
    List<Polyline> _circlePolylines = _addCircles();
    _polylines.addAll(_circlePolylines);

    var layer = _currentLayer == _LayerType.MAPBOX_SATELLITE && _mapBoxToken != null && _mapBoxToken != ''
      ? TileLayerOptions(
          urlTemplate: 'https://api.mapbox.com/v4/mapbox.satellite/{z}/{x}/{y}@2x.jpg90?access_token={accessToken}',
          additionalOptions: {
            'accessToken': _mapBoxToken
          },
          tileProvider: CachedNetworkTileProvider()
        )
      : TileLayerOptions(
          urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
          subdomains: ['a', 'b', 'c'],
          tileProvider: CachedNetworkTileProvider()
        );

    var layers = <LayerOptions>[layer];

    layers.addAll([
      PolylineLayerOptions(
        polylines: _polylines
      ),
      MarkerLayerOptions(
        markers: _markers
      ),
      PopupMarkerLayerOptions(
        markers: _markers,
        popupSnap: PopupSnap.top,
        popupController: _popupLayerController,
        popupBuilder: (BuildContext _, Marker marker) => _buildPopups(marker)
      ),
    ]);

    return Listener(
      onPointerSignal: handleSignal,
      child: Stack(
        children: [
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              center: computeCentroid(widget.points.map((_point) => _point.point).toList()),
              zoom: _getBoundsZoomLevel().toDouble(),
              minZoom: 1.0,
              maxZoom: 18.0,
              plugins: [PopupMarkerPlugin()],
              onTap: (_) => _popupLayerController.hidePopup()
            ),
            layers: layers,
          ),
          Positioned(
            top: 15.0,
            right: 15.0,
            child: Column(
              children: _buildButtons()
            )
          ),

          Positioned(
            bottom: 5.0,
            left: 5.0,
            child: InkWell(
              child: Opacity(
                child: Container(
                  color: COLOR_MAP_LICENSETEXT_BACKGROUND,
                  child: Text(
                    i18n(context, _currentLayer == _LayerType.OPENSTREETMAP_MAPNIK ? OSM_TEXT : MAPBOX_SATELLITE_TEXT),
                    style: TextStyle(
                      color: COLOR_MAP_LICENSETEXT,
                      fontSize: defaultFontSize() - 4,
                      decoration: TextDecoration.underline
                    )
                  )
                ),
                opacity: 0.7,
              ),
              onTap: () {
                launch(i18n(context, _currentLayer == _LayerType.OPENSTREETMAP_MAPNIK ? OSM_URL : MAPBOX_SATELLITE_URL));
              },
            ),
          )
        ],
      )
    );
  }

  _buildButtons() {
    var buttons = [
      GCWIconButton(
        iconData: Icons.layers,
        onPressed: () {
          _currentLayer = _currentLayer == _LayerType.OPENSTREETMAP_MAPNIK ? _LayerType.MAPBOX_SATELLITE : _LayerType.OPENSTREETMAP_MAPNIK;

          if (_currentLayer == _LayerType.MAPBOX_SATELLITE && (_mapBoxToken == null || _mapBoxToken == '')) {
            _loadToken('mapbox').then((token) {
              setState(() {
                _mapBoxToken = token;
              });
            });
          } else {
            setState(() {});
          }
        }
      ),
    ];

    if (_useUserPosition && _currentPermissionGranted) {
      buttons.add(
        GCWIconButton(
          iconData: Icons.location_on,
          onPressed: _toggleListening,
        )
      );
    }

    return buttons;
  }

  // handle mouse wheel on web
  void handleSignal(e) {
    if (e is PointerScrollEvent) {
      var delta = e.scrollDelta.direction;
      _mapController.move(_mapController.center, _mapController.zoom + (delta > 0 ? -0.2 : 0.2));
    }
  }

  _buildPopupCoordinateText(MapPoint point) {
    var coordinateFormat = defaultCoordFormat();
    if (point.coordinateFormat != null)
      coordinateFormat = point.coordinateFormat;

    return formatCoordOutput(point.point, coordinateFormat, getEllipsoidByName(ELLIPSOID_NAME_WGS84));
  }

  _buildPopupCoordinateDescription(MapPoint point) {
    if (point.markerText == null || point.markerText.length == 0)
      return null;

    return point.markerText;
  }

  _buildPopups(Marker marker) {

    ThemeColors colors = themeColors();

    return Container(
      width: 250,
      height: defaultFontSize() * 7,
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.only(
        bottom: 5
      ),
      decoration: ShapeDecoration(
        color: colors.dialog(),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(roundedBorderRadius),
          side:  BorderSide(
            width: 1,
            color: colors.dialogText(),
          ),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          (marker as GCWMarker).coordinateDescription == null ? Container()
            : Container(
                child: GCWText(
                  text: (marker as GCWMarker).coordinateDescription,
                  style: TextStyle(
                    fontFamily: gcwTextStyle().fontFamily,
                    fontSize: defaultFontSize(),
                    color: colors.dialogText(),
                    fontWeight: FontWeight.bold
                  )
                ),
                padding: EdgeInsets.only(
                  bottom: 10
                ),
              ),
          GCWOutputText(
            text: (marker as GCWMarker).coordinateText,
            style: TextStyle(
                fontFamily: gcwTextStyle().fontFamily,
                fontSize: defaultFontSize(),
                color: colors.dialogText()
            )
          )
        ],
      )
    );
  }

  List<Polyline> _addPolylines() {
    List<Polyline> _polylines = widget.geodetics.map((_geodetic) {
      return Polyline(
        points: _geodetic.shape,
        strokeWidth: 3.0,
        color: _geodetic.color,
      );
    }).toList();
    return _polylines;
  }

  List<Polyline> _addCircles() {

    List<Polyline> _polylines =  widget.circles.map((_circle) {
      return Polyline(
        points: _circle.shape,
        strokeWidth: 3.0,
        color: _circle.color,
      );
    }).toList();

    return _polylines;
  }
}

class GCWMarker extends Marker {
  final String coordinateText;
  final String coordinateDescription;

  GCWMarker({
    this.coordinateText,
    this.coordinateDescription,
    LatLng point,
    WidgetBuilder builder,
    double width,
    double height,
    AnchorPos anchorPos
  }) : super(point: point, builder: builder, width: width, height: height);
}
