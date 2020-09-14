import 'package:auto_size_text/auto_size_text.dart';
import 'package:fancy_dialog/FancyAnimation.dart';
import 'package:fancy_dialog/FancyGif.dart';
import 'package:fancy_dialog/FancyTheme.dart';
import 'package:fancy_dialog/fancy_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:startogodomiciliario/controllers/crud.dart';
import 'package:toast/toast.dart';

import 'login.dart';
import 'olvidasteContrasena.dart';

class RegistrarDomiciliario extends StatefulWidget {
  //le pasamos como parametro como lo es el key
  RegistrarDomiciliario({Key key, this.title}) : super(key: key);
  final title;
  @override
  _RegistrarDomiciliarioState createState() => _RegistrarDomiciliarioState();
}

class _RegistrarDomiciliarioState extends State<RegistrarDomiciliario> {
  //instanciamos nuestro controlador que es el auth
  Crud auth = new Crud();

  final TextEditingController _nombreController = new TextEditingController();
  final TextEditingController _correoController = new TextEditingController();
  final TextEditingController _contrasenaController =
      new TextEditingController();

  final TextEditingController _contraconfirmarController =
      new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //color al scafoll
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      //final del color scafoll
      debugShowCheckedModeBanner: false,
      title: 'Registro de Driver.',
      home: Scaffold(
        appBar: AppBar(
          title: AutoSizeText(
            'Registrar nuevo Driver',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.white, Colors.green[900]],
                  begin: Alignment.centerLeft,
                  end: Alignment.bottomCenter),
            ),
            child: ListView(
              padding: const EdgeInsets.only(
                  top: 6, left: 12.0, right: 12.0, bottom: 12.0),
              children: <Widget>[
                new Padding(
                  padding: new EdgeInsets.only(top: 15.0),
                ),
                _imagenmaa(),
                new Padding(
                  padding: new EdgeInsets.only(top: 20.0),
                ),
                //---nombre del producto
                Container(
                    height: 50,
                    child: new TextField(
                      controller: _nombreController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0)),
                        labelText: 'Nombre...',
                        hintText: 'Nombre',
                        suffixIcon: Icon(Icons.add_circle_outline),
                        icon: Icon(Icons.account_circle),
                      ),
                    )),
                new Padding(
                  padding: new EdgeInsets.only(top: 15.0),
                ),
                //n
                Container(
                    height: 50,
                    child: new TextField(
                      controller: _correoController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0)),
                        labelText: 'Correo Electronico',
                        hintText: 'Correo Electronico',
                        suffixIcon: Icon(Icons.alternate_email),
                        icon: Icon(Icons.email),
                      ),
                    )),

                new Padding(
                  padding: new EdgeInsets.only(top: 15.0),
                ),

                Container(
                    height: 50,
                    child: new TextField(
                      obscureText: true,
                      controller: _contrasenaController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0)),
                        labelText: 'Contraseña',
                        hintText: 'Contraseña',
                        suffixIcon: Icon(Icons.lock_open),
                        icon: Icon(Icons.lock),
                      ),
                    )),

                new Padding(
                  padding: new EdgeInsets.only(top: 15.0),
                ),

                Container(
                    height: 50,
                    child: new TextField(
                      obscureText: true,
                      controller: _contraconfirmarController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0)),
                        labelText: 'Confirmar Contraseña',
                        hintText: 'Confirmar Contraseña',
                        suffixIcon: Icon(Icons.lock_open),
                        icon: Icon(Icons.lock),
                      ),
                    )),

                //boton

                Padding(
                  padding: EdgeInsets.only(top: 30),
                  child: RaisedButton(
                    textColor: Colors.white,
                    elevation: 10.0,
                    color: Colors.green[900],
                    child: AutoSizeText("Registrarse"),
                    onPressed: () => {
                      if (!RegExp(
                              r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$')
                          .hasMatch(_correoController.text))
                        {
                          Toast.show(
                              "${_correoController.text} NO es un correo valido",
                              context,
                              duration: Toast.LENGTH_LONG,
                              gravity: Toast.BOTTOM),
                        }
                      else if (_nombreController.text.isEmpty)
                        {
                          Toast.show("Campo nombre vacio", context,
                              duration: Toast.LENGTH_LONG,
                              gravity: Toast.BOTTOM),
                        }
                      else if (_contrasenaController.text.isEmpty &&
                          _contrasenaController.text.length >= 8)
                        {
                          Toast.show("Campo Contraseña vacio", context,
                              duration: Toast.LENGTH_LONG,
                              gravity: Toast.BOTTOM),
                        }
                      else if (_contrasenaController.text.length <= 8)
                        {
                          Toast.show(
                              "la contraseña debe ser mayor a 8 caracteres",
                              context,
                              duration: Toast.LENGTH_LONG,
                              gravity: Toast.BOTTOM),
                        }
                      else if (_contraconfirmarController.text !=
                          _contrasenaController.text)
                        {
                          Toast.show("Las contraseña no coinciden", context,
                              duration: Toast.LENGTH_LONG,
                              gravity: Toast.BOTTOM),
                        }
                      else if (RegExp(
                                  r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$')
                              .hasMatch(_correoController.text) &&
                          _nombreController.text != "" &&
                          _contrasenaController.text != "")
                        {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) => FancyDialog(
                                    title: "Confirme si desea registrarse",
                                    descreption:
                                        "le enviaremos un correo electronico con la confirmacion de su cuenta  ${_correoController.text}",
                                    animationType: FancyAnimation.BOTTOM_TOP,
                                    theme: FancyTheme.FANCY,
                                    gifPath: FancyGif
                                        .CHECK_MAIL, //'./assets/walp.png',
                                    okFun: () => {
                                      if (_nombreController.text != "" &&
                                          _correoController.text != "" &&
                                          _contrasenaController.text != "")
                                        {
                                          auth.registrarDomiciliario(
                                              _nombreController.text.trim(),
                                              _correoController.text.trim(),
                                              _contrasenaController.text
                                                  .trim()),
                                        }
                                    },
                                  ))
                        }
                    },
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0),
                    ),
                  ),
                ),

                Container(
                  child: Row(
                    children: [
                      Expanded(
                        child: CupertinoButton(
                          child: Text(
                            "Login",
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'sans',
                              color: Colors.white,
                            ),
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
                            "Olvide Mi contraseña",
                            style: TextStyle(
                                fontSize: 18.0,
                                fontFamily: 'sans',
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          onPressed: () =>
                              Navigator.of(context).push(new MaterialPageRoute(
                            //LLAMO A LA CLASE LISTAR PRODUCTO
                            builder: (BuildContext context) =>
                                OlvidarContrasena(),
                          )),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            )),
      ),
    );
  }

  Widget _imagenmaa() {
    return Image(
      image: AssetImage('assets/apk1.png'),
      height: 230.0,
    );
  }
}
