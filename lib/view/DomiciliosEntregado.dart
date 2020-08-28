import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:startogodomiciliario/shared/preferencias.dart';

import 'menuLateral/menuprincial.dart';

//stf
class DomicilioEntregado extends StatefulWidget {
  @override
  _DomicilioEntregadoState createState() => _DomicilioEntregadoState();
}

class _DomicilioEntregadoState extends State<DomicilioEntregado> {
  //listar toda la informacion de los productos en unas tarjetas
  List data;

  Future<List> getDomiciliarioEntregados() async {
    //instancio todos los productos
    final response = await http
        .get("https://startogoweb.com/api/mostrarDomiciliosEntregado");
    //lo retornamos en un json
    return json.decode(response.body);
  }

  @override
  //para que cuando cargue nuestra aplicacion es ejecutar esta funcion get
  void initState() {
    super.initState();
    this.getDomiciliarioEntregados();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Domicilios Entregados"),
      ),
      drawer: MenuPrincipal(),
      body: new FutureBuilder<List>(
        future: getDomiciliarioEntregados(),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.hasError);
          return snapshot.hasData
              ? new ItemList(
                  list: snapshot.data,
                )
              : new Center(
                  child: new CircularProgressIndicator(),
                );
        },
      ),
    );
  }
}

class ItemList extends StatelessWidget {
  //instancio las preferencias del usuario
  final prefs = new PreferenciasUsuarios();
  //importamos nuestro controlador
  // Crud crud = new Crud();
  final List list;
  ItemList({this.list});

  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
      itemCount: list == null ? 0 : list.length,
      itemBuilder: (context, i) {
        return new Container(
            padding: const EdgeInsets.all(10.0),
            child: new GestureDetector(
              // onTap: () => Navigator.of(context).push(new MaterialPageRoute(
              //  builder: (BuildContext context) => new DetaPedidoMa(
              //   list: list,
              //   index: i,
              // ))),
              child: new Card(
                //sombra de la tarjeta
                elevation: 10.0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)),
                //las tarjetas lo principal es el child ya que puedo colocar cualquier cosa
                child: Column(
                  children: <Widget>[
                    if (prefs.idUsuarioo.toString() ==
                        list[i]['id_domiciliario'].toString())
                      ListTile(
                        leading: Icon(Icons.shopping_cart, color: Colors.green),
                        title: new Text(
                          "Negocio: " + list[i]['nombre_tienda'].toString(),
                          style: TextStyle(fontSize: 20.0, color: Colors.red),
                        ),
                        subtitle: Text(
                          list[i]['nombre_cliente'].toString() +
                              "\n" +
                              list[i]['correo_cliente'].toString() +
                              "\n" +
                              list[i]['numero_cliente'].toString() +
                              "\n" +
                              list[i]['direccion'].toString() +
                              "\n" +
                              list[i]['total'].toString() +
                              "\n" +
                              list[i]['observacion_domicilio'].toString() +
                              "\n" +
                              list[i]['estado'].toString() +
                              "\n" +
                              list[i]['created_at'].toString(),
                          style: TextStyle(fontSize: 14.0, color: Colors.black),
                        ),
                      ),
                    //   Row(
                    //propiedad para colocar fila fila al final
                    //   mainAxisAlignment: MainAxisAlignment.end,
                    //    children: <Widget>[
                    //    FlatButton(
                    //      child: Text('Entregar pedido'),
                    //   onPressed: () {},
                    //  ),
                    //   FlatButton(
                    //      child: Text('Detalles'),
                    //       onPressed: () {},
                    //      ),
                    //     ],
                    //   )
                  ],
                ),
              ),
            ));
      },
    );
  }
}