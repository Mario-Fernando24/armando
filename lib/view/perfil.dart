import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:startogodomiciliario/controllers/crud.dart';
import 'package:startogodomiciliario/shared/preferencias.dart';

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
                  print("mario" + pedidoRequest.data.toString());
                  var pedidoData = pedidoRequest.data;

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
                                    'Informacion Personal',
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
                              left: 25.0, right: 25.0, top: 25.0),
                          child: new Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Expanded(
                                child: Container(
                                  child: new Text(
                                    'Nombre',
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                flex: 2,
                              ),
                              Expanded(
                                child: Container(
                                  child: new Text(
                                    'Apellido',
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold),
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
                                  child: new TextField(
                                    decoration: const InputDecoration(
                                        hintText: "Nombres..."),
                                  ),
                                ),
                                flex: 2,
                              ),
                              Flexible(
                                child: new TextField(
                                  decoration: const InputDecoration(
                                      hintText: "Apellido..."),
                                ),
                                flex: 2,
                              ),
                            ],
                          )),

                      //===================fin=================================

                      //========================inicio=================
                      Padding(
                          padding: EdgeInsets.only(
                              left: 25.0, right: 25.0, top: 25.0),
                          child: new Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Expanded(
                                child: Container(
                                  child: new Text(
                                    'Telefono',
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                flex: 2,
                              ),
                              Expanded(
                                child: Container(
                                  child: new Text(
                                    'ID',
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold),
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
                                  child: new TextField(
                                    decoration: const InputDecoration(
                                        hintText: "Telefono..."),
                                  ),
                                ),
                                flex: 2,
                              ),
                              Flexible(
                                child: new TextField(
                                  decoration:
                                      const InputDecoration(hintText: "ID..."),
                                ),
                                flex: 2,
                              ),
                            ],
                          )),

                      //===================fin=================================

                      Padding(
                          padding: EdgeInsets.only(
                              left: 25.0, right: 25.0, top: 25.0),
                          child: new Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Expanded(
                                child: Container(
                                  child: new Text(
                                    'Pais',
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                flex: 2,
                              ),
                              Expanded(
                                child: Container(
                                  child: new Text(
                                    'Estado',
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold),
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
                                  child: new TextField(
                                    decoration: const InputDecoration(
                                        hintText: "Pais..."),
                                  ),
                                ),
                                flex: 2,
                              ),
                              Flexible(
                                child: new TextField(
                                  decoration: const InputDecoration(
                                      hintText: "Estado..."),
                                ),
                                flex: 2,
                              ),
                            ],
                          )),

                      //_________________________________________
                      Padding(
                          padding: EdgeInsets.only(
                              left: 25.0, right: 25.0, top: 25.0),
                          child: new Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Expanded(
                                child: Container(
                                  child: new Text(
                                    'Ciudad',
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                flex: 2,
                              ),
                              Expanded(
                                child: Container(
                                  child: new Text(
                                    'State',
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold),
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
                                  child: new TextField(
                                    decoration: const InputDecoration(
                                        hintText: "Ciudad..."),
                                  ),
                                ),
                                flex: 2,
                              ),
                              Flexible(
                                child: new TextField(
                                  decoration: const InputDecoration(
                                      hintText: "Enter State"),
                                ),
                                flex: 2,
                              ),
                            ],
                          )),
                      //===========================================
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
                onPressed: () {},
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(20.0)),
              )),
            ),
            flex: 2,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: Container(
                  child: new RaisedButton(
                child: new Text("Cancelar"),
                textColor: Colors.white,
                color: Colors.red,
                onPressed: () {},
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
