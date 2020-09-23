import 'dart:async';
import 'dart:convert';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:startogodomiciliario/config/constants.dart';
import 'package:startogodomiciliario/shared/preferencias.dart';
import 'package:startogodomiciliario/view/detallepedidomar.dart';

import 'menuLateral/menuprincial.dart';

//stf
class DomiciliosActivos extends StatefulWidget {
  @override
  _DomiciliosActivosState createState() => _DomiciliosActivosState();
}

class _DomiciliosActivosState extends State<DomiciliosActivos> {
  //listar toda la informacion de los productos en unas tarjetas
  List data;

  //inicializar el shared_preferences
  final prefs = new PreferenciasUsuarios();

  final String URL_API = '$BASE_ENDPOINT/api';

  Future<List> getDomiciliarioActivos() async {
    //instancio todos los productos
    final response =
        await http.get("$URL_API/mostrarDomiActivo/" + prefs.idUsuarioo);
    print(response.body);
    //lo retornamos en un json
    return json.decode(response.body);
  }

  @override
  //para que cuando cargue nuestra aplicacion es ejecutar esta funcion get
  void initState() {
    super.initState();
    this.getDomiciliarioActivos();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new AutoSizeText("Pedidos Activas"),
      ),
      body: new FutureBuilder<List>(
        future: getDomiciliarioActivos(),
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
              onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                  builder: (BuildContext context) => new DetaPedidoMa(
                        list: list,
                        index: i,
                      ))),
              child: new Card(
                //sombra de la tarjeta
                elevation: 10.0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)),
                //las tarjetas lo principal es el child ya que puedo colocar cualquier cosa
                child: Column(
                  children: <Widget>[
                    ListTile(
                      leading: FadeInImage.assetNetwork(
                        placeholder: 'assets/logotienda.png',
                        image:
                            "http://startogoweb.com/imagenes/logos/${list[i]['logo_empresa']}",
                        height: 90.0,
                      ),
                      title: new AutoSizeText(
                        list[i]['nombre_tienda'].toString(),
                        style: TextStyle(
                            fontSize: 24.0,
                            color: Colors.red[600],
                            fontWeight: FontWeight.bold),
                      ),
                      subtitle: AutoSizeText(
                        list[i]['nombre_cliente'].toString() +
                            "\n" +
                            list[i]['direccion'].toString() +
                            "\n" +
                            list[i]['observacion_domicilio'].toString() +
                            "\n" +
                            list[i]['estado'].toString() +
                            "\n" +
                            list[i]['created_at'].toString(),
                        style: TextStyle(
                            fontSize: 14.0,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
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
