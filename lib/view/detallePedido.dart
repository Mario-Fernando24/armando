import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:startogodomiciliario/controllers/crud.dart';
import 'package:startogodomiciliario/shared/preferencias.dart';

import 'menuLateral/menuprincial.dart';

// ignore: must_be_immutable
class DetallePedido extends StatefulWidget {
  List list;
  int index;
  int id;

  //Hago el constructo y le paso esos parametros
  DetallePedido({this.index, this.list, this.id});

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
          title: new AutoSizeText("Detalle"),

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
                print("Builder " + pedidoRequest.hasData.toString());
                if (pedidoRequest.hasData) {
                  var pedidoData = pedidoRequest.data;
                  return Column(
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          AutoSizeText(
                            "#: ${pedidoData['cabezapedido']['id']}",
                            style:
                                TextStyle(fontSize: 15.0, color: Colors.black),
                          ),
                          AutoSizeText(
                            "Direccion: ${pedidoData['cabezapedido']['direccion']}",
                            style:
                                TextStyle(fontSize: 15.0, color: Colors.black),
                          ),
                          AutoSizeText(
                            "Ciudad: ${pedidoData['cabezapedido']['ciudad']}",
                            style:
                                TextStyle(fontSize: 15.0, color: Colors.black),
                          ),
                          AutoSizeText(
                            "Estado:  ${pedidoData['cabezapedido']['estadodir']}",
                            style:
                                TextStyle(fontSize: 15.0, color: Colors.black),
                          ),
                          AutoSizeText(
                            "Codigo Postal: ${pedidoData['cabezapedido']['codigopostal']}",
                            style:
                                TextStyle(fontSize: 15.0, color: Colors.black),
                          ),
                          AutoSizeText(
                            "Pais: ${pedidoData['cabezapedido']['pais']}",
                            style:
                                TextStyle(fontSize: 15.0, color: Colors.black),
                          ),
                          AutoSizeText(
                            "Pago: ${pedidoData['cabezapedido']['formaPago']}",
                            style:
                                TextStyle(fontSize: 15.0, color: Colors.black),
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
                          rows: pedidoData['detallepedido']
                              .map<DataRow>((detalle) {
                            return DataRow(selected: true, cells: [
                              //, showEditIcon: true
                              DataCell(Text("${detalle['nombre_tienda']}")),
                              DataCell(Text("${detalle['nombre']}")),
                              DataCell(Text("${detalle['cantidad']}")),
                              DataCell(Text("${detalle['venta']}")),
                              DataCell(Text("${detalle['subtotal']}")),
                              DataCell(Text("${detalle['observacion']}")),
                            ]);
                          }).toList()),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          new Padding(
                            padding: const EdgeInsets.only(top: 30.0),
                          ),
                          new AutoSizeText(
                            "Subtotal: ${pedidoData['cabezapedido']['subtotalpedidoido']}",
                            style: new TextStyle(fontSize: 15.0),
                          ),
                          Divider(),
                          new AutoSizeText(
                            "Impuesto: ${pedidoData['cabezapedido']['impuesto']}",
                            style: new TextStyle(fontSize: 15.0),
                          ),
                          Divider(),
                          new AutoSizeText(
                            "Propina: ${pedidoData['cabezapedido']['ValorPropina']}",
                            style: new TextStyle(fontSize: 15.0),
                          ),
                          Divider(),
                          new AutoSizeText(
                            "Total: ${pedidoData['cabezapedido']['totalcobrar']}",
                            style: new TextStyle(fontSize: 15.0),
                          ),
                          Divider(),
                          new Padding(
                            padding: const EdgeInsets.only(top: 30.0),
                          ),
                        ],
                      ),
                    ],
                  );
                }
                return CircularProgressIndicator();
              },
              future: crud.getDetallePedido(this.widget.id)),
        ),
      ),
    );
  }
}
