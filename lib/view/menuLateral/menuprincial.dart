import 'package:flutter/material.dart';
import 'package:startogodomiciliario/shared/preferencias.dart';
import 'package:startogodomiciliario/view/DomiciliosEntregado.dart';
import 'package:startogodomiciliario/view/ajustes.dart';

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
            child: Text(
              'Domiciliario',
              style: TextStyle(fontSize: 25.0, color: Colors.black),
            ),
          ),
          new Divider(),
          new ListTile(
              title: new Text("Inicio"),
              trailing: new Icon(Icons.home,
                  color: (prefs.colorSecundario) ? Colors.black : Colors.green),
              onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                  builder: (BuildContext context) => MainPage()))),
          new Divider(),
          new ListTile(
              title: new Text("Perfil"),
              trailing: new Icon(Icons.person_add,
                  color: (prefs.colorSecundario) ? Colors.black : Colors.green),
              onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                  //LLAMO A LA CLASE PERFILPAGE
                  builder: (BuildContext context) => Perfil()))),
          new Divider(),
          new ListTile(
              title: new Text("Pedidos Activos"),
              trailing: new Icon(Icons.card_travel,
                  color: (prefs.colorSecundario) ? Colors.black : Colors.green),
              onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                  //LLAMO A LA CLASE LISTAR PRODUCTO

                  builder: (BuildContext context) => DomiciliosActivos()))),
          new Divider(),
          new ListTile(
              title: new Text("Historial de Pedidos"),
              trailing: new Icon(Icons.history,
                  color: (prefs.colorSecundario) ? Colors.black : Colors.green),
              onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                  //LLAMO A LA CLASE LISTAR PRODUCTO

                  builder: (BuildContext context) => DomicilioEntregado()))),
          new Divider(),
          new ListTile(
              title: new Text("Mi billetera"),
              trailing: new Icon(Icons.attach_money,
                  color: (prefs.colorSecundario) ? Colors.black : Colors.green),
              onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                  //LLAMO A LA CLASE LISTAR PRODUCTO

                  ))),
          new Divider(),
          new ListTile(
              title: new Text("Estadisticas"),
              trailing: new Icon(Icons.assessment,
                  color: (prefs.colorSecundario) ? Colors.black : Colors.green),
              onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                  //LLAMO A LA CLASE LISTAR PRODUCTO

                  ))),
          new Divider(),
          new ListTile(
              title: new Text("Ajustes"),
              trailing: new Icon(Icons.settings,
                  color: (prefs.colorSecundario) ? Colors.black : Colors.green),
              onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                  //LLAMO A LA CLASE PERFILPAGE
                  builder: (BuildContext context) => SettingPage()))),
        ],
      ),
    );
  }

  Widget _imagenm() {
    return FadeInImage(
      image: NetworkImage(
          'https://startogoweb.com/vista/assets/images/icons/domiciliopfffff.png'),
      //mientras este cargando el imagen http me muestre el gif de cargando
      placeholder: AssetImage('assets/loading.gif'),
      //para que agarre todo el ancho
      fit: BoxFit.contain,

      //con una duracion de 20milisegundo
      fadeInDuration: Duration(milliseconds: 500),
      height: 190.0,
    );
  }
}
