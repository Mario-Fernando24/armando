import 'package:auto_size_text/auto_size_text.dart';
import 'package:fancy_dialog/FancyAnimation.dart';
import 'package:fancy_dialog/FancyGif.dart';
import 'package:fancy_dialog/FancyTheme.dart';
import 'package:fancy_dialog/fancy_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:startogodomiciliario/controllers/crud.dart';
import 'package:startogodomiciliario/view/registrarme.dart';
import 'package:toast/toast.dart';
import 'login.dart';

class OlvidarContrasena extends StatefulWidget {
  //le pasamos como parametro como lo es el key
  OlvidarContrasena({Key key, this.title}) : super(key: key);
  final title;
  @override
  _OlvidarContrasenaState createState() => _OlvidarContrasenaState();
}

class _OlvidarContrasenaState extends State<OlvidarContrasena> {
  //instanciamos nuestro controlador que es el crud
  Crud auth = new Crud();
  //declaramos de tipo booleano si esta cargando
  //bool _isLoading = false;

  final TextEditingController _correoController = new TextEditingController();

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
      title: 'Olvidaste tu contraseña',

      home: Scaffold(
        appBar: AppBar(
          title: AutoSizeText(
            'Olvidaste tu contraseña',
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

                ListTile(
                  title: AutoSizeText('¿Olvidaste tu contraseña?',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  subtitle: AutoSizeText(
                    'Aquí puede recuperar fácilmente una nueva contraseña, le enviaremos un enlace a su correo electronico para que restablecer su cuenta,',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                new Padding(
                  padding: new EdgeInsets.only(top: 20.0),
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

                //boton

                Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: RaisedButton(
                    textColor: Colors.white,
                    elevation: 6.0,
                    color: Colors.green[900],
                    child: AutoSizeText("Recuperar mi cuenta"),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0)),
                    onPressed: () => {
                      if (_correoController.text == "")
                        {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) => FancyDialog(
                                    title: "Campos vacio",
                                    descreption:
                                        "Por favor Ingresar un correo electronico valido para recuperar su cuenta",
                                    animationType: FancyAnimation.LEFT_RIGHT,
                                    theme: FancyTheme.FANCY,
                                    gifPath: FancyGif
                                        .PLAY_MEDIA, //'./assets/walp.png',
                                    okFun: () => {},
                                  ))
                        }
                      else if (RegExp(
                              r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$')
                          .hasMatch(_correoController.text))
                        {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) => FancyDialog(
                                    title: "Desea recuperar su cuenta",
                                    descreption:
                                        "le enviaremos un enlace a su correo electronico ${_correoController.text} para que restablesca su cuenta, si no lo encuentras aveces por accidente cae en la carpeta spam  ",
                                    animationType: FancyAnimation.BOTTOM_TOP,
                                    theme: FancyTheme.FANCY,
                                    gifPath: FancyGif.CHECK_MAIL,
                                    okFun: () => {
                                      if (_correoController.text != "")
                                        {
                                          Toast.show("correo enviado con exito",
                                              context,
                                              duration: Toast.LENGTH_LONG,
                                              gravity: Toast.BOTTOM),
                                          auth.olvidasteContrasena(
                                              _correoController.text.trim()),
                                        }
                                    },
                                  ))
                        }
                      else
                        {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) => FancyDialog(
                                    title: "Error",
                                    descreption:
                                        "${_correoController.text} no es un correo valido, por favor ingrese un correo electronico valido",
                                    animationType: FancyAnimation.BOTTOM_TOP,
                                    theme: FancyTheme.FANCY,
                                    gifPath: FancyGif
                                        .PLAY_MEDIA, //'./assets/walp.png',
                                    okFun: () => {},
                                  ))
                        }
                    },
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
                              color: Colors.black,
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
                            "Registrarme",
                            style: TextStyle(
                                fontSize: 18.0,
                                fontFamily: 'sans',
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          onPressed: () =>
                              Navigator.of(context).push(new MaterialPageRoute(
                            //LLAMO A LA CLASE LISTAR PRODUCTO
                            builder: (BuildContext context) =>
                                RegistrarDomiciliario(),
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
