import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:startogodomiciliario/controllers/crud.dart';
import 'package:startogodomiciliario/shared/preferencias.dart';

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
          title: new AutoSizeText("Detalle del pedido"),

          //para activar el color condicion si el colorSegundario es true que muestre negro si no verde
          backgroundColor:
              (prefs.colorSecundario) ? Colors.black : Colors.green,
        ),
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
                //  print("Builder " + pedidoRequest.data.toString());
                if (pedidoRequest.hasData) {
                  var pedidoData = pedidoRequest.data;
                  return Column(
                    children: <Widget>[
                      _logom(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          AutoSizeText(
                            "#${pedidoData['cabezapedido']['id']}",
                            style:
                                TextStyle(fontSize: 16.0, color: Colors.black),
                          ),
                          AutoSizeText(
                            "${pedidoData['cabezapedido']['nombre_tienda']}",
                            style: TextStyle(
                                fontSize: 15.0,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          AutoSizeText(
                            "Cliente ${pedidoData['cabezapedido']['nombrecli']}",
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
                          AutoSizeText(
                            "${pedidoData['cabezapedido']['observacion_domicilio']}",
                            style: TextStyle(
                                fontSize: 15.0,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
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
                            //   DataColumn(label: Text("negocio")),
                            DataColumn(
                                label: Text(
                              "producto",
                              style: TextStyle(
                                  fontSize: 12.0,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            )),
                            DataColumn(
                                label: Text(
                                  "cantidad",
                                  style: TextStyle(
                                      fontSize: 12.0,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                                numeric: true),
                            DataColumn(
                                label: Text(
                              "p venta",
                              style: TextStyle(
                                  fontSize: 12.0,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            )),
                            DataColumn(
                                label: Text(
                              "subtotal",
                              style: TextStyle(
                                  fontSize: 12.0,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            )),
                            DataColumn(
                                label: Text(
                              "observacion",
                              style: TextStyle(
                                  fontSize: 10.0,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            )),
                          ],
                          rows: pedidoData['detallepedido']
                              .map<DataRow>((detalle) {
                            return DataRow(selected: true, cells: [
                              //, showEditIcon: true
                              //     DataCell(Text("${detalle['nombre_tienda']}")),
                              DataCell(Text("${detalle['nombre']}")),
                              DataCell(Text("${detalle['cantidad']}")),
                              DataCell(Text("${detalle['precio_venta']}")),
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
                          AutoSizeText(
                            "\$ Subtotal: ${pedidoData['cabezapedido']['subtotalpedido']}",
                            style: new TextStyle(
                                fontSize: 15.0, fontWeight: FontWeight.bold),
                          ),
                          Divider(),
                          new AutoSizeText(
                            "\$ Impuesto: ${pedidoData['cabezapedido']['impuesto']}",
                            style: new TextStyle(
                                fontSize: 15.0, fontWeight: FontWeight.bold),
                          ),
                          Divider(),
                          new AutoSizeText(
                            "\$ Propina: ${pedidoData['cabezapedido']['ValorPropina']}",
                            style: new TextStyle(
                                fontSize: 15.0, fontWeight: FontWeight.bold),
                          ),
                          Divider(),
                          new AutoSizeText(
                            "\$ Total: ${pedidoData['cabezapedido']['totalcobrar']}",
                            style: new TextStyle(
                                fontSize: 15.0, fontWeight: FontWeight.bold),
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

  Widget _logom() {
    return Image(
      image: AssetImage('assets/apk1.png'),
      height: 100.0,
    );
  }
}
