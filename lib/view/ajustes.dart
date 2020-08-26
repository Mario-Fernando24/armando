import 'package:flutter/material.dart';
import 'package:startogodomiciliario/shared/preferencias.dart';
import 'package:startogodomiciliario/view/menuLateral/menuprincial.dart';

class SettingPage extends StatefulWidget {
  //nombre de la pagina de forma estatica

  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  bool _colorSegundario;

  String _nombre;

  TextEditingController _textcontroller;
  //inicializar el shared_preferences
  final prefs = new PreferenciasUsuarios();

  @override
  //se dispara cuando se inicializa este estado
  void initState() {
    super.initState();
    //Inicializo la ultima page
    // prefs.ultimaPagina = SettingPage.routeName;
    //inicializo el genero con las pref que esta en mi clase share_prefr/preferencias_usuario

    _colorSegundario = prefs.colorSecundario;
    _textcontroller = new TextEditingController(text: _nombre);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Ajustes'),

          //para activar el color
          backgroundColor:
              (prefs.colorSecundario) ? Colors.black : Colors.green,
        ),
        drawer: MenuPrincipal(),
        body: ListView(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(10.0),
              child: Text(
                'Ajustes',
                style: TextStyle(
                    fontSize: 40.0,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic),
              ),
            ),
            Divider(),
            Divider(),
            SwitchListTile(
              value: _colorSegundario,
              title: Text(
                'Modo Oscuro',
                style: TextStyle(
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                    color: Colors.red),
              ),
              onChanged: (value) {
                //para que se redibuje
                setState(() {
                  prefs.colorSecundario = value;
                  _colorSegundario = value;
                });
              },
            ),

            Divider(),
            Divider(),
            //caja de texto para ingresar un string
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(prefs.nombreUsuario,
                  style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic)),
            ),
            Divider(),
            Divider(),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(prefs.correoUsuario,
                  style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic)),
            ),
            Divider(),
            Divider(),
            Divider(),
            Divider(),
            SwitchListTile(
              value: _colorSegundario,
              title: Text(
                'Idioma español',
                style: TextStyle(
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                    color: Colors.red),
              ),
            ),
          ],
        ));
  }
}
