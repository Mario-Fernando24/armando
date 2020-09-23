import 'dart:convert';

import 'package:fancy_dialog/FancyAnimation.dart';
import 'package:fancy_dialog/FancyGif.dart';
import 'package:fancy_dialog/FancyTheme.dart';
import 'package:fancy_dialog/fancy_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:startogodomiciliario/config/constants.dart';
import 'package:startogodomiciliario/controllers/crud.dart';
import 'package:startogodomiciliario/view/olvidasteContrasena.dart';
import 'package:startogodomiciliario/view/utilities/screenUtilCalc.dart';
import 'package:toast/toast.dart';

import 'login.dart';

class RegistrarDomiciliario extends StatefulWidget {
  @override
  _RegistrarDomiciliarioState createState() => _RegistrarDomiciliarioState();
}

class _RegistrarDomiciliarioState extends State<RegistrarDomiciliario> {
// Inicialmente la contraseña es oscura
  bool _obscureText = true;
  Crud auth = new Crud();
  // Alterna la contraseña para mostrar el estado

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  //declaramos de tipo booleano si esta cargando
  bool _isLoading = false;

  final String URL_API = '$BASE_ENDPOINT/api';
  String nombre = '';
  String email = '';
  String password = '';
  String confirmPassword = '';
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light
        .copyWith(statusBarColor: Colors.transparent));
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Colors.white, Colors.green[500], Colors.black],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter),
        ),
        child: _isLoading
            ? Center(
                child: Column(
                children: [
                  Text("Registrandose..."),
                  CircularProgressIndicator(
                      valueColor:
                          new AlwaysStoppedAnimation<Color>(Colors.white)),
                ],
              ))
            : ListView(
                children: <Widget>[
                  _imagenLogin(),
                  Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: calcFromW(context, 0.05)),
                      child: Card(
                          child: Padding(
                        padding: const EdgeInsets.only(
                            bottom: 5, left: 20, right: 20, top: 8),
                        child: Column(
                          children: [
                            Center(
                                child: Text(
                              "Registrarse",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: calcFromW(context, 0.065)),
                            )),
                            SizedBox(
                              height: 30,
                            ),
                            textSection(),
                            SizedBox(
                              height: 20,
                            ),
                            buttonSection(),
                          ],
                        ),
                      ))),
                ],
              ),
      ),
    );
  }

//declaramos una funcion segnIn que es la que se va a conectar con nuestra api de laravel
  register() async {
    if (!RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$')
        .hasMatch(email)) {
      Toast.show("${email} NO es un correo valido", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    } else if (nombre.isEmpty) {
      Toast.show("Campo nombre vacio", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    } else if (password.isEmpty && password.length >= 8) {
      Toast.show("Campo Contraseña vacio", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    } else if (password.length <= 8) {
      Toast.show("la contraseña debe ser mayor a 8 caracteres", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    } else if (confirmPassword != password) {
      Toast.show("Las contraseña no coinciden", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    } else if (RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$')
            .hasMatch(email) &&
        nombre != "" &&
        password != "") {
      showDialog(
          context: context,
          builder: (BuildContext context) => FancyDialog(
                title: "Confirme si desea registrarse",
                descreption:
                    "le enviaremos un correo electronico con la confirmacion de su cuenta  ${email}",
                animationType: FancyAnimation.BOTTOM_TOP,
                theme: FancyTheme.FANCY,
                gifPath: FancyGif.CHECK_MAIL, //'./assets/walp.png',
                okFun: () => {
                  if (nombre != "" && email != "" && password != "")
                    {
                      auth.registrarDomiciliario(
                          nombre.trim(), email.trim(), password.trim()),
                      Toast.show("Cliente creado exitosamente${email}", context,
                          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM),
                    }
                },
              ));
    }
  }

  Container buttonSection() {
    return Container(
      alignment: Alignment.topCenter,
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: <Widget>[
          RaisedButton(
            onPressed: nombre == "" ||
                    email == "" ||
                    password == "" ||
                    confirmPassword == ""
                ? null
                : () {
                    register();
                  },
            elevation: 6.0,
            color: Colors.green,
            child: Text("Registrarse",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold)),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0)),
          ),
          Padding(
            padding: new EdgeInsets.only(top: 5.0),
          ),
          Container(
            child: Row(
              children: [
                Expanded(
                  child: CupertinoButton(
                    child: Text(
                      "Iniciar Sesión",
                      style: TextStyle(
                          fontSize: 13.0,
                          // fontWeight: FontWeight.bold,
                          fontFamily: 'sans'),
                    ),
                    onPressed: () =>
                        Navigator.of(context).push(new MaterialPageRoute(
                      //LLAMO A LA CLASE LISTAR PRODUCTO
                      builder: (BuildContext context) => LoginPage(),
                    )),
                  ),
                ),
                Expanded(
                  child: CupertinoButton(
                    child: Text(
                      "Olvidè mi contraseña",
                      style: TextStyle(
                          fontSize: 13.0,
                          // fontWeight: FontWeight.bold,
                          fontFamily: 'sans'),
                    ),
                    onPressed: () =>
                        Navigator.of(context).push(new MaterialPageRoute(
                      //LLAMO A LA CLASE LISTAR PRODUCTO
                      builder: (BuildContext context) => OlvidarContrasena(),
                    )),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  final TextEditingController nombreController = new TextEditingController();
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();
  final TextEditingController confirmPasswordController =
      new TextEditingController();

  Container textSection() {
    return Container(
      child: Column(
        children: <Widget>[
          TextFormField(
            keyboardType: TextInputType.text,
            controller: nombreController,
            onChanged: (text) {
              setState(() {
                nombre = text;
              });
            },
            decoration: InputDecoration(
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
              hintText: 'Nombre Completo',
              labelText: 'Nombre Completo',
              // icon: Icon(Icons.account_box)
            ),
          ),
          SizedBox(height: 30.0),
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            controller: emailController,
            onChanged: (text) {
              setState(() {
                email = text;
              });
            },
            decoration: InputDecoration(
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
              hintText: 'Correo',
              labelText: 'Correo',
              // icon: Icon(Icons.email)
            ),
          ),
          SizedBox(height: 30.0),
          TextFormField(
            controller: passwordController,
            //para que la contraseña se oculte mientra este escribiendo
            obscureText: _obscureText,
            onChanged: (text) {
              setState(() {
                password = text;
              });
            },
            decoration: InputDecoration(
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
              hintText: 'Contraseña',
              labelText: 'Contraseña',
              suffixIcon: IconButton(
                  onPressed: _toggle,
                  icon: Icon(!_obscureText ? Icons.lock_open : Icons.lock)),
              // icon: Icon(Icons.lock)
            ),
          ),
          SizedBox(height: 30.0),
          TextFormField(
            controller: confirmPasswordController,
            //para que la contraseña se oculte mientra este escribiendo
            obscureText: _obscureText,
            onChanged: (text) {
              setState(() {
                confirmPassword = text;
              });
            },
            decoration: InputDecoration(
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
              hintText: 'Confirmar Contraseña',
              labelText: 'Confirmar Contraseña',
              suffixIcon: IconButton(
                  onPressed: _toggle,
                  icon: Icon(!_obscureText ? Icons.lock_open : Icons.lock)),
              // icon: Icon(Icons.lock)
            ),
          ),

          //  new TextFormField(
          //   decoration: const InputDecoration(
          //       labelText: 'Password',
          //      icon: const Padding(
          //         padding: const EdgeInsets.only(top: 15.0),
          //        child: const Icon(Icons.lock))
          //         ),
          //    obscureText: _obscureText,
          //  ),
          //    new FlatButton(
          //        onPressed: _toggle,
          //        child: new Text(_obscureText ? "Mostrar" : "Esconder")),
        ],
      ),
    );
  }

  Widget _imagenLogin() {
    return Image(
      image: AssetImage('assets/apk1.png'),
      height: calcFromH(context, 0.25),
    );
  }
}
