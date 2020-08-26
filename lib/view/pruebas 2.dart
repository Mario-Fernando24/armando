import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:startogodomiciliario/shared/preferencias.dart';

class PruebasMario extends StatefulWidget {
  @override
  _PruebasMarioState createState() => _PruebasMarioState();
}

class _PruebasMarioState extends State<PruebasMario> {
  //listar toda la informacion de los productos en unas tarjetas
  List data;

  Future<List> getDetallePedido() async {
    //instancio todos los productos
    final response =
        await http.get("https://startogoweb.com/api/DomiciliosEntregado");
    //lo retornamos en un json
    return json.decode(response.body);
  }

  @override
  //para que cuando cargue nuestra aplicacion es ejecutar esta funcion get
  void initState() {
    super.initState();
    this.getDetallePedido();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Detalle del pedido prueba"),
      ),
      body: new FutureBuilder<List>(
        future: getDetallePedido(),
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
              child: new Card(
                child: new ListTile(
                    title: new Text(
                  "mm:",
                  style:
                      TextStyle(fontSize: 25.0, color: Colors.deepOrangeAccent),
                )),
              ),
            ));
      },
    );
  }
}
