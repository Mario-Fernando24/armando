import 'package:auto_size_text/auto_size_text.dart';
import 'package:startogodomiciliario/shared/preferencias.dart';
import 'package:startogodomiciliario/view/inicioapp.dart';
import 'package:startogodomiciliario/view/login.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:startogodomiciliario/view/mapainicio.dart';
import 'package:startogodomiciliario/view/menuLateral/menuprincial.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = new PreferenciasUsuarios();
  await prefs.initPrefs();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Startogo Drive",
      debugShowCheckedModeBanner: false,
      home: MainPage(),
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  String _idUsuariomar = '';

  TextEditingController _textcontroller;
  final prefs = new PreferenciasUsuarios();
  //sharedPrederences es para que me mantenga el estado
  SharedPreferences sharedPreferences;

  @override
  void initState() {
    super.initState();
    _textcontroller = new TextEditingController(text: _idUsuariomar);
    checkLoginStatus();
  }

  checkLoginStatus() async {
    //aqui para que compruebe el estado para que no le toque estar logueando cada ves que se salga de la apliccion
    sharedPreferences = await SharedPreferences.getInstance();
    prefs.idUsuarioo = sharedPreferences.getString("idUsuarioLogueado");
    _idUsuariomar = sharedPreferences.getString("idUsuarioLogueado");
    setState(() {});
    //se el sharead es igual a vacio que nos mande al login
    if (sharedPreferences.getString("token") == null) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (BuildContext context) => MarioPru()),
          (Route<dynamic> route) => false);
    }
  }

//este es un menu lateral
  @override
  Widget build(BuildContext context) {
    //instancio
    // final prefs = new PreferenciasUsuarios();

    return Scaffold(
      appBar: AppBar(
        title: AutoSizeText("Startogo Drive",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),

        //para activar el color condicion si el colorSegundario es true que muestre negro si no verde
        backgroundColor: (prefs.colorSecundario) ? Colors.black : Colors.green,

        actions: <Widget>[
          Container(
            padding: EdgeInsets.all(4.0),
            child: CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://startogoweb.com/vista/assets/images/icons/domiciliopfffff.png'),
              radius: 25.0,
            ),
          ),
          FlatButton(
            onPressed: () {
              sharedPreferences.clear();
              sharedPreferences.commit();
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                      builder: (BuildContext context) => LoginPage()),
                  (Route<dynamic> route) => false);
            },
            child: AutoSizeText("Salir",
                style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 20)),
          ),
        ],
      ),
      //llamo el mapa que se muestra en el inicio
      body: Center(child: InicioMapa()),

      drawer: MenuPrincipal(),
    );
  }
}
