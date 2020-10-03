import 'package:fancy_dialog/FancyAnimation.dart';
import 'package:fancy_dialog/FancyGif.dart';
import 'package:fancy_dialog/FancyTheme.dart';
import 'package:fancy_dialog/fancy_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:startogodomiciliario/controllers/crud.dart';
import 'package:startogodomiciliario/view/registrarme.dart';
import 'package:startogodomiciliario/view/utilities/screenUtilCalc.dart';
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
  bool _isLoading = false;
  String email = '';

  final TextEditingController _correoController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //color al scafoll
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      //final del color scafoll
      debugShowCheckedModeBanner: false,
      title: 'Olvidaste tu contraseña',
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'Olvidaste tu contraseña',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.white, Colors.blue[900]],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter),
            ),
            child: ListView(
              padding: const EdgeInsets.only(
                  top: 6, left: 12.0, right: 12.0, bottom: 12.0),
              children: <Widget>[
                _imagenmaa(),
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
                              "Restablecer contraseña",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: calcFromW(context, 0.065)),
                            ),
                          ),
                          Center(
                            child: Text(
                              "Aquí puede recuperar fácilmente una nueva contraseña, le enviaremos un enlace a su correo electronico para que restablezca su cuenta.",
                              style: TextStyle(fontSize: 15.0),
                            ),
                          ),
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
            )),
      ),
    );
  }

  //declaramos una funcion segnIn que es la que se va a conectar con nuestra api de laravel
  enviar(String email) async {
    if (email.trim() == "") {
      showDialog(
          context: context,
          builder: (BuildContext context) => FancyDialog(
                title: "Campos vacio",
                descreption:
                    "Por favor Ingresar un correo electronico valido para recuperar su cuenta.",
                animationType: FancyAnimation.LEFT_RIGHT,
                theme: FancyTheme.FANCY,
                gifPath: FancyGif.FUNNY_MAN, //'./assets/walp.png',
                okFun: () => {},
              ));
    } else if (RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$')
        .hasMatch(email.trim())) {
      showDialog(
          context: context,
          builder: (BuildContext context) => FancyDialog(
                title: "Desea recuperar su cuenta",
                descreption:
                    "le enviaremos un enlace a su correo electronico para que restablezca su cuenta  ${email.trim()}",
                animationType: FancyAnimation.BOTTOM_TOP,
                theme: FancyTheme.FANCY,
                gifPath: FancyGif.CHECK_MAIL, //'./assets/walp.png',
                okFun: () => {
                  if (email.trim() != "")
                    {
                      auth.olvidasteContrasena(email.trim()),
                      Toast.show(
                          "Correo electronico enviado correctamente", context,
                          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM),
                    }
                },
              ));
    } else {
      showDialog(
          context: context,
          builder: (BuildContext context) => FancyDialog(
                title: "Error",
                descreption:
                    "${email.trim()} no es un correo valido, por favor ingrese un correo electronico valido",
                animationType: FancyAnimation.BOTTOM_TOP,
                theme: FancyTheme.FANCY,
                gifPath: FancyGif.PLAY_MEDIA, //'./assets/walp.png',
                okFun: () => {},
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
            onPressed: email == ""
                ? null
                : () {
                    setState(() {
                      _isLoading = true;
                    });
                    enviar(email);
                  },
            elevation: 6.0,
            color: Colors.indigo[900],
            child: Text("Restablecer contraseña",
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
                      "Login",
                      style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
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
                      "Registrarme",
                      style: TextStyle(fontSize: 13.0, fontFamily: 'sans'),
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
      ),
    );
  }

  final TextEditingController emailController = new TextEditingController();

  Container textSection() {
    return Container(
      child: Column(
        children: <Widget>[
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
              suffixIcon: Icon(Icons.alternate_email),
              // icon: Icon(Icons.email)
            ),
          ),
        ],
      ),
    );
  }

  Widget _imagenmaa() {
    return Image(
      image: AssetImage('assets/apk1.png'),
      height: calcFromH(context, 0.25),
    );
  }
}
