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
              padding: EdgeInsets.all(5.0),
              child: Text(
                'Ajustes',
                style: TextStyle(fontSize: 45.0, fontWeight: FontWeight.bold),
              ),
            ),
            Divider(),
            SwitchListTile(
              value: _colorSegundario,
              title: Text('Cambiar color segundario Negro'),
              onChanged: (value) {
                //para que se redibuje
                setState(() {
                  prefs.colorSecundario = value;
                  _colorSegundario = value;
                });
              },
            ),

            //caja de texto para ingresar un string
            Divider(),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: TextField(
                controller: _textcontroller,
                decoration: InputDecoration(
                    labelText: 'Nombre',
                    helperText: 'Nombre de la ${prefs.idUsuarioo}'),
                onChanged: (value) {
                  prefs.nombreUsuario = value;
                },
              ),
            )
          ],
        ));
  }
}
