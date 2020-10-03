import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:toast/toast.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({Key key}) : super(key: key);

  @override
  _ShopPageState createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  final Location location = Location();

  LocationData _location;
  String _error;
  PermissionStatus _permissionGranted;
  @override
  void initState() {
    super.initState();
    runInit();
  }

  Future<void> runInit() async {
    await _checkPermissions();
    if (_permissionGranted == PermissionStatus.deniedForever) {
      Toast.show(
          "No hemos podido acceder a tu ubicación para el envio", context,
          duration: Toast.LENGTH_LONG);
    } else if (_permissionGranted == PermissionStatus.denied) {
      Toast.show("Necesitamos tu ubicación para enviar tu pedido", context,
          duration: Toast.LENGTH_LONG);
      await _requestPermission();
    } else if (_permissionGranted == PermissionStatus.granted) {}
  }

  Future<void> _checkPermissions() async {
    final PermissionStatus permissionGrantedResult =
        await location.hasPermission();
    setState(() {
      _permissionGranted = permissionGrantedResult;
    });
  }

  Future<void> _requestPermission() async {
    if (_permissionGranted != PermissionStatus.granted) {
      final PermissionStatus permissionRequestedResult =
          await location.requestPermission();
      setState(() {
        _permissionGranted = permissionRequestedResult;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("ruta"),
          //para activar el color condicion si el colorSegundario es true que muestre negro si no verde
          backgroundColor: Colors.indigo[900],
        ),
        body: _buildWebView());
  }

  Widget _buildWebView() {
    return WebView(
      javascriptMode: JavascriptMode.unrestricted,
      initialUrl:
          'https://www.google.com/maps/search/?api=1&query=8.761101,-75.870548',
    );
  }
}
