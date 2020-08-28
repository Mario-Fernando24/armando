import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:startogodomiciliario/controllers/crud.dart';
import 'package:startogodomiciliario/shared/preferencias.dart';

import 'menuLateral/menuprincial.dart';

// ignore: must_be_immutable
class DetallePedido extends StatefulWidget {
  List list;
  int index;

  //Hago el constructo y le paso esos parametros
  DetallePedido({this.index, this.list});

  @override
  _DetallePedidoState createState() => _DetallePedidoState();
}

class _DetallePedidoState extends State<DetallePedido> {
  //inicializar el shared_preferences
  final prefs = new PreferenciasUsuarios();
  Crud crud = new Crud();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          title: new AutoSizeText("ee"),

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
          child: Column(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  AutoSizeText(
                    "#: ",
                    style: TextStyle(fontSize: 15.0, color: Colors.black),
                  ),
                  AutoSizeText(
                    "Direccion: ",
                    style: TextStyle(fontSize: 15.0, color: Colors.black),
                  ),
                  AutoSizeText(
                    "Ciudad:  ",
                    style: TextStyle(fontSize: 15.0, color: Colors.black),
                  ),
                  AutoSizeText(
                    "Estado:  ",
                    style: TextStyle(fontSize: 15.0, color: Colors.black),
                  ),
                  AutoSizeText(
                    "Codigo Postal: ",
                    style: TextStyle(fontSize: 15.0, color: Colors.black),
                  ),
                  AutoSizeText(
                    "Pais: ",
                    style: TextStyle(fontSize: 15.0, color: Colors.black),
                  ),
                  AutoSizeText(
                    "Pago: ",
                    style: TextStyle(fontSize: 15.0, color: Colors.black),
                  ),
                  AutoSizeText(
                    "mm",
                    style: TextStyle(fontSize: 15.0, color: Colors.black),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                ],
              ),
              DataTable(
                  sortColumnIndex: 2,
                  sortAscending: false,
                  columns: [
                    DataColumn(label: Text("negocio")),
                    DataColumn(label: Text("producto")),
                    DataColumn(label: Text("cantidad"), numeric: true),
                    DataColumn(label: Text("p venta")),
                    DataColumn(label: Text("subtotal")),
                    DataColumn(label: Text("observacion")),
                  ],
                  rows: FutureBuilder<List<DataRow>>(
                      builder: (context, rows) {
                        return [
                          DataRow(selected: true, cells: [
                            //, showEditIcon: true
                            DataCell(Text("Andres")),
                            DataCell(Text("Cruz")),
                            DataCell(Text("28")),
                            DataCell(Text("28")),
                            DataCell(Text("28")),
                            DataCell(Text("28")),
                          ])
                        ];
                      },
                      future: crud.getDetallePedido(id))),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  new Padding(
                    padding: const EdgeInsets.only(top: 30.0),
                  ),
                  new AutoSizeText(
                    "Subtotal: ",
                    style: new TextStyle(fontSize: 15.0),
                  ),
                  Divider(),
                  new AutoSizeText(
                    "Impuesto: ",
                    style: new TextStyle(fontSize: 15.0),
                  ),
                  Divider(),
                  new AutoSizeText(
                    "Propina: ",
                    style: new TextStyle(fontSize: 15.0),
                  ),
                  Divider(),
                  new AutoSizeText(
                    "Total: ",
                    style: new TextStyle(fontSize: 15.0),
                  ),
                  Divider(),
                  new Padding(
                    padding: const EdgeInsets.only(top: 30.0),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
