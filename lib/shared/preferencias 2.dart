import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

//podemos guardar el token, id del usuario, preferencias si queremos recibir notificaciones y color o tema de la apk
class PreferenciasUsuarios {
  static final PreferenciasUsuarios _instancia =
      new PreferenciasUsuarios._internal();

  //creo el constructor, cuando se ejecute el constructor que me retorne
  factory PreferenciasUsuarios() {
    return _instancia;
  }
  PreferenciasUsuarios._internal();
  //la que me va a permitir saber e inicializar para poderla consumir
  SharedPreferences prefs;

  initPrefs() async {
    //esto va a ser =   SharedPreferences prefs;
    prefs = await SharedPreferences.getInstance();
  }

  get colorSecundario {
    //el ??1 es que si no existe el genero que sea igual a 1
    return prefs.getBool('colorSecundario') ?? false;
  }

  set colorSecundario(bool value) {
    prefs.setBool('colorSecundario', value);
  }

  get nombreUsuario {
    //el ??1 es que si no existe el genero que sea igual a 1
    return prefs.getString('name') ?? 'm';
  }

  set nombreUsuario(String value) {
    prefs.setString('name', value);
  }

  get idUsuarioo {
    //el ??1 es que si no existe el genero que sea igual a 1
    return prefs.getString('idUsuario') ?? 'm';
  }

  set idUsuarioo(String value) {
    prefs.setString('idUsuario', value);
  }

  get correoUsuario {
    return prefs.getString('email') ?? 'm';
  }

  set correoUsuario(String value) {
    prefs.setString('email', value);
  }
}
