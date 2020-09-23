import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:url_launcher/url_launcher.dart';

class InicioMapa extends StatefulWidget {
  InicioMapa({Key key, this.title = ''}) : super(key: key);
  final String title;

  @override
  _InicioMapaState createState() => _InicioMapaState();
}

class _InicioMapaState extends State<InicioMapa> {
  bool _isVisible = true;
  bool _darkMode = false;
  StreamSubscription _streamSubscription;
  Location _tracker = Location();
  Marker marker;
  Circle circle;
  GoogleMapController _googleMapController;

  static final CameraPosition initialLocation = CameraPosition(
    target: LatLng(42.185623, -71.085291),
    zoom: 14.4746,
  );

  //function menu options
  void showMenuOptions() {
    setState(() {
      _isVisible = !_isVisible;
    });
  }

  //functions for call 911
  // Future<void> _launched;
  //String _phone = '123';
  Future<void> _makePhoneCall(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  bool switchValue = false;
  changeMapMode() {
    setState(() {
      if (_darkMode == true) {
      } else {}
    });
  }

  Future<String> getJsonFile(String path) async {
    return await rootBundle.loadString(path);
  }

  void setMapStyle(String mapStyle) {
    _googleMapController.setMapStyle(mapStyle);
  }

  @override
  void dispose() {
    if (_streamSubscription != null) {
      _streamSubscription.cancel();
    }
    super.dispose();
  }

  //Function for updateMarkerAndCircle
  void updateMarker(LocationData newLocalData, Uint8List imageData) {
    LatLng latlng = LatLng(newLocalData.latitude, newLocalData.longitude);
    this.setState(() {
      marker = Marker(
          markerId: MarkerId("marcador"),
          position: latlng,
          rotation: newLocalData.heading,
          draggable: false,
          zIndex: 2,
          flat: true,
          anchor: Offset(0.5, 0.5),
          icon: BitmapDescriptor.fromBytes(imageData));
      circle = Circle(
          circleId: CircleId("carro"),
          radius: newLocalData.accuracy,
          zIndex: 1,
          strokeColor: Colors.blue,
          center: latlng,
          fillColor: Colors.blue.withAlpha(70));
    });
  }

  Future<Uint8List> getMarkerCar() async {
    ByteData byteData =
        await DefaultAssetBundle.of(context).load("assets/auto.png");
    return byteData.buffer.asUint8List();
  }

  //Function for capture your current position
  void getCurrentLocationCar() async {
    try {
      Uint8List imageData = await getMarkerCar();
      var location = await _tracker.getLocation();

      updateMarker(location, imageData);

      if (_streamSubscription != null) {
        _streamSubscription.cancel();
      }

      _streamSubscription = _tracker.onLocationChanged.listen((newLocalData) {
        if (_googleMapController != null) {
          _googleMapController.animateCamera(CameraUpdate.newCameraPosition(
              new CameraPosition(
                  bearing: 100,
                  target: LatLng(newLocalData.latitude, newLocalData.longitude),
                  tilt: 0,
                  zoom: 18.00)));
          updateMarker(newLocalData, imageData);
        }
      });
    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        debugPrint("Permission Denied");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_darkMode) {
      setState(() {
        changeMapMode();
      });
    }

    return Stack(
      children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: GoogleMap(
            zoomGesturesEnabled: true,
            initialCameraPosition: initialLocation,
            markers: Set.of((marker != null) ? [marker] : []),
            circles: Set.of((circle != null) ? [circle] : []),
            onMapCreated: (GoogleMapController controller) {
              _googleMapController = controller;
            },
          ),
        ),
        Visibility(
          visible: _isVisible,
          child: Container(
            margin: EdgeInsets.only(top: 80, right: 10),
            alignment: Alignment.centerLeft,
            color: Color(0xFF808080).withOpacity(0.5),
            height: 440,
            width: 70,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: FloatingActionButton(
                  child: Icon(Icons.location_searching),
                  elevation: 5,
                  backgroundColor: Colors.blueAccent,
                  onPressed: () {
                    getCurrentLocationCar();
                  }),
            ),
          ),
        )
      ],
    );
  }
}
