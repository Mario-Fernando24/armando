import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:startogodomiciliario/config/constants.dart';
import 'package:startogodomiciliario/view/olvidasteContrasena.dart';
import 'package:startogodomiciliario/view/registrarme.dart';
import 'package:startogodomiciliario/view/utilities/screenUtilCalc.dart';
import 'package:toast/toast.dart';

import '../main.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //declaramos de tipo booleano si esta cargando
  bool _isLoading = false;

  final String URL_API = '$BASE_ENDPOINT/api';

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
                  Text("Iniciando Sesión..."),
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
                              "Iniciar Sesión Driver",
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
  signIn(String email, pass) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    //nos devuelven los datos en un mapa lo que es  el email y la contraseña
    Map data = {'email': email, 'password': pass};
    var jsonResponse = null;

    var response = await http.post("$URL_API/login", body: data);
    print(response.statusCode);
    if (response.statusCode == 401) {
      Toast.show("correo o contraseñas no validos", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    }

    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      if (jsonResponse != null) {
        setState(() {
          _isLoading = false;
        });

        sharedPreferences.setString("token", jsonResponse['token']);
        sharedPreferences.setString(
            "idUsuarioLogueado", jsonResponse['idUsuarioLogueado']);
        sharedPreferences.setString("name", jsonResponse['name']);
        sharedPreferences.setString("email", jsonResponse['email']);

        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (BuildContext context) => MainPage()),
            (Route<dynamic> route) => false);
      }
    } else {
      setState(() {
        _isLoading = false;
      });
      print(response.body);
    }
  }

  Container buttonSection() {
    return Container(
      alignment: Alignment.topCenter,
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(horizontal: 60.0),
      margin: EdgeInsets.only(top: 15.0),
      child: Column(
        children: <Widget>[
          RaisedButton(
            onPressed:
                emailController.text == "" || passwordController.text == ""
                    ? null
                    : () {
                        setState(() {
                          _isLoading = true;
                        });
                        signIn(emailController.text, passwordController.text);
                      },
            elevation: 6.0,
            color: Colors.red,
            child: AutoSizeText("Ingresar",
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
            width: double.infinity,
            alignment: Alignment.topCenter,
            child: CupertinoButton(
              padding: EdgeInsets.symmetric(vertical: 15),
              child: AutoSizeText(
                "Registrarme",
                style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'sans'),
              ),
              onPressed: () => Navigator.of(context).push(new MaterialPageRoute(
                //LLAMO A LA CLASE LISTAR PRODUCTO
                builder: (BuildContext context) => RegistrarDomiciliario(),
              )),
            ),
          ),
          Container(
            width: double.infinity,
            alignment: Alignment.topCenter,
            child: CupertinoButton(
              padding: EdgeInsets.symmetric(vertical: 4),
              child: AutoSizeText(
                "Olvidaste tu contraseña",
                style: TextStyle(
                    fontSize: 13.0,
                    color: Colors.black,
                    fontFamily: 'sans',
                    fontWeight: FontWeight.bold),
              ),
              onPressed: () => Navigator.of(context).push(new MaterialPageRoute(
                //LLAMO A LA CLASE LISTAR PRODUCTO
                builder: (BuildContext context) => OlvidarContrasena(),
              )),
            ),
          )
        ],
      ),
    );
  }

  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();

  Container textSection() {
    return Container(
      child: Column(
        children: <Widget>[
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            controller: emailController,
            cursorColor: Colors.white,
            style: TextStyle(color: Colors.black),
            decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0)),
                hintText: 'Correo',
                labelText: 'Correo',
                suffixIcon: Icon(Icons.alternate_email),
                icon: Icon(Icons.email)),
          ),
          SizedBox(height: 30.0),
          TextFormField(
            controller: passwordController,
            cursorColor: Colors.black,
            //para que la contraseña se oculte mientra este escribiendo
            obscureText: true,
            style: TextStyle(color: Colors.black),
            decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0)),
                hintText: 'Contraseña',
                labelText: 'Contraseña',
                suffixIcon: Icon(Icons.lock_open),
                icon: Icon(Icons.lock)),
          ),
        ],
      ),
    );
  }

  Widget _imagenLogin() {
    return Image(
      image: AssetImage('assets/apk1.png'),
      height: calcFromH(context, 0.20),
    );
  }
}
