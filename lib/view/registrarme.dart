import 'package:startogodomiciliario/controllers/crud.dart';
import 'package:flutter/material.dart';
import 'package:startogodomiciliario/view/login.dart';

import '../main.dart';

class RegistrarDomiciliario extends StatefulWidget {
  //le pasamos como parametro como lo es el key
  RegistrarDomiciliario({Key key, this.title}) : super(key: key);
  final title;
  @override
  _RegistrarDomiciliarioState createState() => _RegistrarDomiciliarioState();
}

class _RegistrarDomiciliarioState extends State<RegistrarDomiciliario> {
  //instanciamos nuestro controlador que es el crud
  Crud crud = new Crud();

  final TextEditingController _nombreController = new TextEditingController();
  final TextEditingController _correoController = new TextEditingController();
  final TextEditingController _contrasenaController =
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
      title: 'Registro de Domiciliario',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Registro de Domiciliario'),
        ),
        body: Container(
            child: ListView(
          padding: const EdgeInsets.only(
              top: 6, left: 12.0, right: 12.0, bottom: 12.0),
          children: <Widget>[
            _imagenmaa(),
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
              padding: new EdgeInsets.only(top: 35.0),
            ),
            //boton
            Container(
              height: 60,
              child: new RaisedButton(
                  onPressed: () {
                    if (_nombreController.text != "" &&
                        _correoController.text != "" &&
                        _contrasenaController.text != "") {
                      crud.registrarDomiciliario(
                          _nombreController.text.trim(),
                          _correoController.text.trim(),
                          _contrasenaController.text.trim());
                      Navigator.of(context).push(new MaterialPageRoute(
                        builder: (BuildContext context) => new LoginPage(),
                      ));
                    }
                  },
                  elevation: 6.0,
                  color: Colors.green,
                  child: Text("Registrarme",
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
