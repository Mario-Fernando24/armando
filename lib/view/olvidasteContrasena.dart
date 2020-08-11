import 'package:startogodomiciliario/controllers/crud.dart';
import 'package:flutter/material.dart';
import 'package:startogodomiciliario/view/login.dart';

class OlvidarContrasena extends StatefulWidget {
  //le pasamos como parametro como lo es el key
  OlvidarContrasena({Key key, this.title}) : super(key: key);
  final title;
  @override
  _OlvidarContrasenaState createState() => _OlvidarContrasenaState();
}

class _OlvidarContrasenaState extends State<OlvidarContrasena> {
  //instanciamos nuestro controlador que es el crud
  Crud crud = new Crud();
  //declaramos de tipo booleano si esta cargando
  bool _isLoading = false;

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
          title: Text('Olvidaste tu contraseña'),
        ),
        body: Container(
            child: ListView(
          padding: const EdgeInsets.only(
              top: 6, left: 12.0, right: 12.0, bottom: 12.0),
          children: <Widget>[
            _imagenmaa(),

            ListTile(
              title: Text('¿Olvidaste tu contraseña?'),
              subtitle: Text(
                'Aquí puede recuperar fácilmente una nueva contraseña, le enviaremos un enlace a su correo electronico para que restablesca su cuenta',
                style: TextStyle(fontWeight: FontWeight.w300),
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

            new Padding(
              padding: new EdgeInsets.only(top: 20.0),
            ),

            //boton
            Container(
              height: 60,
              child: new RaisedButton(
                  onPressed: () {
                    if (_correoController.text != "") {
                      crud.olvidasteContrasena(_correoController.text.trim());
                      Navigator.of(context).push(new MaterialPageRoute(
                        builder: (BuildContext context) => new LoginPage(),
                      ));
                    }
                  },
                  elevation: 6.0,
                  color: Colors.green,
                  child: Text("Restablecer Contraseña",
                      style: TextStyle(color: Colors.white)),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0))),
            ),
          ],
        )),
      ),
    );
  }

  Widget _imagenmaa() {
    return Image(
      image: AssetImage('assets/apk1.png'),
      height: 250.0,
    );
  }
}
