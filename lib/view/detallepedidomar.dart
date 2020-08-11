import 'package:flutter/material.dart';
import 'package:startogodomiciliario/controllers/crud.dart';

import 'package:startogodomiciliario/view/DomiciliosEntregado.dart';
import 'package:startogodomiciliario/view/detallePedido.dart';

import 'menuLateral/menuprincial.dart';

class DetaPedidoMa extends StatefulWidget {
  List list;
  int index;
  //Hago el constructo y le paso esos parametros
  DetaPedidoMa({this.index, this.list});

  @override
  _DetaPedidoMaState createState() => _DetaPedidoMaState();
}

class _DetaPedidoMaState extends State<DetaPedidoMa> {
  //importa la clase donde esta toda la logica
  Crud crud = new Crud();

  void confirm() {
    AlertDialog alertDialog = AlertDialog(
      content: new Text(
          "Ver detalle '${widget.list[widget.index]['nombre_tienda']}'"),
      actions: <Widget>[
        new RaisedButton(
          shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(20.0)),
          child: new Text(
            "SI",
            style: new TextStyle(color: Colors.black),
          ),
          color: Colors.green,
          onPressed: () {
            Navigator.of(context).push(new MaterialPageRoute(
                builder: (BuildContext context) => DetallePedido()));
          },
        ),
        new RaisedButton(
          shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(20.0)),
          child: new Text("NO ", style: new TextStyle(color: Colors.black)),
          color: Colors.red,
          onPressed: () => Navigator.pop(context),
        ),
      ],
    );

    showDialog(context: context, child: alertDialog);
  }

//metodo para confirmar si entrego el pedido satisfactoriamente
  void confirmarentrega() {
    AlertDialog alertDialog = AlertDialog(
      content: new Text(
          "El cliente recibio el pedido de '${widget.list[widget.index]['nombre_tienda']}'"),
      actions: <Widget>[
        new RaisedButton(
          shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(20.0)),
          child: new Text(
            "SI",
            style: new TextStyle(color: Colors.black),
          ),
          color: Colors.green,
          onPressed: () {
            //Le envio por parametro el id del domicilio y el id del usuario
            crud.pedidoEntregado(widget.list[widget.index]['id'].toString());
            Navigator.of(context).push(new MaterialPageRoute(
              builder: (BuildContext context) => DomicilioEntregado(),
            ));
          },
        ),
        new RaisedButton(
          shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(20.0)),
          child: new Text("NO ", style: new TextStyle(color: Colors.black)),
          color: Colors.red,
          onPressed: () => Navigator.pop(context),
        ),
      ],
    );

    showDialog(context: context, child: alertDialog);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
            title: new Text("${widget.list[widget.index]['nombre_tienda']}")),
        drawer: MenuPrincipal(),
        body: new Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20.0),
          child: new Card(
            child: new Center(
              child: Column(
                children: <Widget>[
                  new Padding(
                    padding: const EdgeInsets.only(top: 30.0),
                  ),
                  new Text(
                    "Startogo Domiciliario",
                    style: new TextStyle(fontSize: 25.0, color: Colors.red),
                  ),
                  new Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                  ),
                  Divider(),
                  new Text(
                    "Subtotal: " + widget.list[widget.index]['subtotalpedido'],
                    style: new TextStyle(fontSize: 18.0),
                  ),
                  Divider(),
                  new Text(
                    "Impuesto: ${widget.list[widget.index]['impuesto']}",
                    style: new TextStyle(fontSize: 18.0),
                  ),
                  Divider(),
                  new Text(
                    "Propina: ${widget.list[widget.index]['ValorPropina']}",
                    style: new TextStyle(fontSize: 18.0),
                  ),
                  Divider(),
                  new Text(
                    "Total: ${widget.list[widget.index]['totalcobrar']}",
                    style: new TextStyle(fontSize: 25.0),
                  ),
                  new Padding(
                    padding: const EdgeInsets.only(top: 50.0),
                  ),
                  new Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      new RaisedButton(
                        child: new Text("Detalles Pedido"),
                        color: Colors.green,
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(90.0)),
                        onPressed: () => confirm(),
                      ),
                      VerticalDivider(),
                      new RaisedButton(
                        child: new Text("entregar pedido"),
                        color: Colors.blue,
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(30.0)),
                        onPressed: () => confirmarentrega(),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
