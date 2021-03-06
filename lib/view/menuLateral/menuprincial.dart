import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:startogodomiciliario/shared/preferencias.dart';
import 'package:startogodomiciliario/view/DomiciliosEntregado.dart';
import 'package:startogodomiciliario/view/ajustes.dart';
import 'package:startogodomiciliario/view/login.dart';

import '../../main.dart';
import '../domiciliosActivos.dart';
import '../perfil.dart';

class MenuPrincipal extends StatelessWidget {
  final prefs = new PreferenciasUsuarios();
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: new ListView(
        //ojo para quitar lo que sobresale del menu lateral
        padding: EdgeInsets.zero,
        children: <Widget>[
          _imagenm(),
          Center(
            child: AutoSizeText(prefs.nombreUsuario,
                style: TextStyle(
                    fontSize: 25.0,
                    color: Colors.black,
                    fontWeight: FontWeight.bold)),
          ),
          new Divider(),
          new ListTile(
              title: new AutoSizeText("Inicio"),
              trailing: new Icon(Icons.home,
                  size: 30.0,
                  color: (prefs.colorSecundario)
                      ? Colors.black
                      : Colors.indigo[900]),
              onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                  builder: (BuildContext context) => MainPage()))),
          new Divider(),
          new ListTile(
              title: new AutoSizeText("Perfil"),
              trailing: new Icon(Icons.person_add,
                  size: 30.0,
                  color: (prefs.colorSecundario)
                      ? Colors.black
                      : Colors.indigo[900]),
              onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                  //LLAMO A LA CLASE PERFILPAGE
                  builder: (BuildContext context) => Perfil()))),
          new Divider(),
          new ListTile(
              title: new AutoSizeText("Pedidos Activos"),
              trailing: new Icon(Icons.shopping_cart,
                  size: 30.0,
                  color: (prefs.colorSecundario)
                      ? Colors.black
                      : Colors.indigo[900]),
              onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                  //LLAMO A LA CLASE LISTAR PRODUCTO

                  builder: (BuildContext context) => DomiciliosActivos()))),
          new Divider(),
          new ListTile(
              title: new AutoSizeText("Historial de Pedidos"),
              trailing: new Icon(Icons.history,
                  size: 30.0,
                  color: (prefs.colorSecundario)
                      ? Colors.black
                      : Colors.indigo[900]),
              onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                  //LLAMO A LA CLASE LISTAR PRODUCTO

                  builder: (BuildContext context) => DomicilioEntregado()))),
          //   new Divider(),
          //  new ListTile(
          //     title: new AutoSizeText("Mi billetera"),
          //    trailing: new Icon(Icons.attach_money,
          //        size: 30.0,
          //        color: (prefs.colorSecundario) ? Colors.black : Colors.indigo[900]),
          //    onTap: () {}),
          // new Divider(),
          //  new ListTile(
          //     title: new AutoSizeText("Estadisticas"),
          //    trailing: new Icon(Icons.assessment,
          //       size: 30.0,
          //       color: (prefs.colorSecundario) ? Colors.black : Colors.indigo[900]),
          //     onTap: () {}),
          new Divider(),
          new ListTile(
              title: new AutoSizeText("Ajustes"),
              trailing: new Icon(Icons.settings,
                  size: 30.0,
                  color: (prefs.colorSecundario)
                      ? Colors.black
                      : Colors.indigo[900]),
              onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                  //LLAMO A LA CLASE PERFILPAGE
                  builder: (BuildContext context) => SettingPage()))),
          new Divider(),
          new ListTile(
              title: new AutoSizeText(
                "Salir",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              trailing: new FaIcon(
                FontAwesomeIcons.signOutAlt,
                size: 30.0,
                color: Colors.red,
              ),
              onTap: () async {
                //cierro session y elimino el token que esat guardadas en las preferencias de la apk
                SharedPreferences preferences =
                    await SharedPreferences.getInstance();
                await preferences.clear();

                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (BuildContext context) => LoginPage()),
                    (Route<dynamic> route) => false);
              }),
        ],
      ),
    );
  }

  Widget _imagenm() {
    return Image(
      image: AssetImage('assets/apk1.png'),
      height: 180.0,
    );
  }
}
