import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:startogodomiciliario/controllers/crud.dart';
import 'package:startogodomiciliario/main.dart';
import 'package:startogodomiciliario/shared/preferencias.dart';
import 'package:toast/toast.dart';

import 'menuLateral/menuprincial.dart';

// ignore: must_be_immutable
class Perfil extends StatefulWidget {
  List list;
  int index;
  int id;

  final prefs = new PreferenciasUsuarios();

  //Hago el constructo y le paso esos parametros
  Perfil({this.index, this.list, this.id});

  @override
  _PerfilState createState() => _PerfilState();
}

class _PerfilState extends State<Perfil> {
  //inicializar el shared_preferences
  final prefs = new PreferenciasUsuarios();
  Crud crud = new Crud();

  TextEditingController _nombreController = new TextEditingController();
  TextEditingController _apellidoController = new TextEditingController();
  TextEditingController _numerotelefono = new TextEditingController();
  TextEditingController _num_documento = new TextEditingController();
  TextEditingController _paisDomi = new TextEditingController();
  TextEditingController _estadoDomi = new TextEditingController();
  TextEditingController _ciudadDomi = new TextEditingController();

  TextEditingController _fotoDomi = new TextEditingController();

  TextEditingController _generoDomi = new TextEditingController();

  @override
  void initState() {
    super.initState();
    itemm();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          title: new AutoSizeText("Perfil " + prefs.nombreUsuario),

          //para activar el color condicion si el colorSegundario es true que muestre negro si no verde
          backgroundColor:
              (prefs.colorSecundario) ? Colors.black : Colors.green,
        ),
        drawer: MenuPrincipal(),
        body: itemm());
  }

//cuerpo del widget
  Widget itemm() {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 2.0, vertical: 16.0),
      //para que la imagen tome todo el ancho posible del dispositivo

      child: new Card(
        child: new Center(
          child: FutureBuilder<dynamic>(
              builder: (context, pedidoRequest) {
                //    print("mario prueba " + pedidoRequest.data.toString());
                if (pedidoRequest.hasData) {
                  //   print("mario" + pedidoRequest.data.toString());

                  var pedidoData = pedidoRequest.data;

                  _nombreController = new TextEditingController(
                      text: "${pedidoData['perfilDomi']['nombreDomi']}");

                  _apellidoController = new TextEditingController(
                      text: "${pedidoData['perfilDomi']['apellidoDomi']}");

                  _numerotelefono = new TextEditingController(
                      text: "${pedidoData['perfilDomi']['numeroDomi']}");

                  _num_documento = new TextEditingController(
                      text: "${pedidoData['perfilDomi']['num_documento']}");

                  _paisDomi = new TextEditingController(
                      text: "${pedidoData['perfilDomi']['paisDomi']}");

                  _estadoDomi = new TextEditingController(
                      text: "${pedidoData['perfilDomi']['estadoDomi']}");

                  _ciudadDomi = new TextEditingController(
                      text: "${pedidoData['perfilDomi']['ciudadDomi']}");

                  _fotoDomi = new TextEditingController(
                      text: "${pedidoData['perfilDomi']['fotoDomi']}");

                  _generoDomi = new TextEditingController(
                      text: "${pedidoData['perfilDomi']['generoDomi']}");

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                          padding: EdgeInsets.only(
                              left: 25.0, right: 25.0, top: 25.0),
                          child: new Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              new Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Container(
                                    height: 250.0,
                                    color: Colors.white,
                                    child: new Column(
                                      children: <Widget>[
                                        Padding(
                                          padding: EdgeInsets.only(top: 20.0),
                                          child: new Stack(
                                              fit: StackFit.loose,
                                              children: <Widget>[
                                                new Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    new Container(
                                                        width: 140.0,
                                                        height: 140.0,
                                                        decoration:
                                                            new BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          image:
                                                              new DecorationImage(
                                                            image: new ExactAssetImage(
                                                                'assets/apk1.png'),
                                                            fit: BoxFit.cover,
                                                          ),
                                                        )),
                                                  ],
                                                ),
                                                Padding(
                                                    padding: EdgeInsets.only(
                                                        top: 90.0,
                                                        right: 100.0),
                                                    child: new Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: <Widget>[
                                                        new CircleAvatar(
                                                          backgroundColor:
                                                              Colors.red,
                                                          radius: 25.0,
                                                          child: new Icon(
                                                            Icons.camera_alt,
                                                            color: Colors.white,
                                                          ),
                                                        )
                                                      ],
                                                    )),
                                              ]),
                                        )
                                      ],
                                    ),
                                  ),
                                  new Text(
                                    'Informacion Driver',
                                    style: TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              new Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[],
                              )
                            ],
                          )),
                      //========================inicio=================

                      Padding(
                          padding: EdgeInsets.only(
                              left: 25.0, right: 25.0, top: 2.0),
                          child: new Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Flexible(
                                child: Padding(
                                  padding: EdgeInsets.only(right: 10.0),
                                  child: new TextFormField(
                                    controller: _nombreController,
                                    /*Presta atención a la siguiente línea:*/
                                    keyboardType: TextInputType.text,
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Nombre';
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      hintText: 'Nombre',
                                      labelText: "Nombre",
                                    ),
                                  ),
                                ),
                                flex: 2,
                              ),
                              Flexible(
                                child: new TextFormField(
                                  /*Presta atención a la siguiente línea:*/
                                  keyboardType: TextInputType.number,
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Apellido';
                                    }
                                    return null;
                                  },
                                  controller: _apellidoController,
                                  decoration: InputDecoration(
                                    hintText: 'Apellido',
                                    labelText: "Apellido",
                                  ),
                                ),
                                flex: 2,
                              ),
                            ],
                          )),

                      Padding(
                          padding: EdgeInsets.only(
                              left: 25.0, right: 25.0, top: 2.0),
                          child: new Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Flexible(
                                child: Padding(
                                  padding: EdgeInsets.only(right: 10.0),
                                  child: new TextFormField(
                                    controller: _numerotelefono,
                                    /*Presta atención a la siguiente línea:*/
                                    keyboardType: TextInputType.number,
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Telefono';
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      hintText: 'Telefono',
                                      labelText: "Telefono",
                                    ),
                                  ),
                                ),
                                flex: 2,
                              ),
                              Flexible(
                                child: new TextFormField(
                                  /*Presta atención a la siguiente línea:*/
                                  keyboardType: TextInputType.number,
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return '# Documento';
                                    }
                                    return null;
                                  },
                                  controller: _num_documento,
                                  decoration: InputDecoration(
                                    hintText: '# Documento',
                                    labelText: "# Documento",
                                  ),
                                ),
                                flex: 2,
                              ),
                            ],
                          )),

                      Padding(
                          padding: EdgeInsets.only(
                              left: 25.0, right: 25.0, top: 2.0),
                          child: new Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Flexible(
                                child: Padding(
                                  padding: EdgeInsets.only(right: 10.0),
                                  child: new TextFormField(
                                    controller: _paisDomi,
                                    /*Presta atención a la siguiente línea:*/
                                    keyboardType: TextInputType.text,
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Pais';
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      hintText: 'Pais',
                                      labelText: "Pais",
                                    ),
                                  ),
                                ),
                                flex: 2,
                              ),
                              Flexible(
                                child: new TextFormField(
                                  /*Presta atención a la siguiente línea:*/
                                  keyboardType: TextInputType.text,
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Estado';
                                    }
                                    return null;
                                  },
                                  controller: _estadoDomi,
                                  decoration: InputDecoration(
                                    hintText: 'Estado',
                                    labelText: "Estado",
                                  ),
                                ),
                                flex: 2,
                              ),
                            ],
                          )),

                      Padding(
                          padding: EdgeInsets.only(
                              left: 25.0, right: 25.0, top: 2.0),
                          child: new Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Flexible(
                                child: Padding(
                                  padding: EdgeInsets.only(right: 10.0),
                                  child: new TextFormField(
                                    controller: _ciudadDomi,
                                    /*Presta atención a la siguiente línea:*/
                                    keyboardType: TextInputType.text,
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Ciudad';
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      hintText: 'Ciudad',
                                      labelText: "Ciudad",
                                    ),
                                  ),
                                ),
                                flex: 2,
                              ),
                              Flexible(
                                child: new TextFormField(
                                  /*Presta atención a la siguiente línea:*/
                                  keyboardType: TextInputType.text,
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Sexo';
                                    }
                                    return null;
                                  },
                                  controller: _generoDomi,
                                  decoration: InputDecoration(
                                    hintText: 'Sexo',
                                    labelText: "Sexo",
                                  ),
                                ),
                                flex: 2,
                              ),
                            ],
                          )),

                      //===================fin=================================

                      _getActionButtons(),
                    ],
                  );
                }
                return CircularProgressIndicator();
              },
              future: crud.mostrarPerfil(int.parse(prefs.idUsuarioo))),
        ),
      ),
    );
  }

  Widget _getActionButtons() {
    var toast = Toast;
    return Padding(
      padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 45.0),
      child: new Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: 10.0),
              child: Container(
                  child: new RaisedButton(
                child: new Text("Actualizar"),
                textColor: Colors.white,
                color: Colors.green,
                onPressed: () {
                  crud.actualizarDatosDomi(
                      prefs.idUsuarioo,
                      _nombreController.text.trim(),
                      _apellidoController.text.trim(),
                      _numerotelefono.text.trim(),
                      _num_documento.text.trim(),
                      _paisDomi.text.trim(),
                      _estadoDomi.text.trim(),
                      _ciudadDomi.text.trim(),
                      _generoDomi.text.trim());
                  Navigator.of(context).push(new MaterialPageRoute(
                    builder: (BuildContext context) => new Perfil(),
                  ));

                  Toast.show("Actualizacion exitosa", context,
                      duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                },
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(20.0)),
              )),
            ),
            flex: 2,
          ),
        ],
      ),
    );
  }
}
