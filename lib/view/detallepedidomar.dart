import 'package:fancy_dialog/FancyAnimation.dart';
import 'package:fancy_dialog/FancyTheme.dart';
import 'package:fancy_dialog/fancy_dialog.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:startogodomiciliario/controllers/crud.dart';

import 'package:startogodomiciliario/view/DomiciliosEntregado.dart';
import 'package:startogodomiciliario/view/detallePedido.dart';
import 'package:toast/toast.dart';
import 'package:url_launcher/url_launcher.dart';

import 'DomiciliosEntregado.dart';

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
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  int _currentIndex = 0;

  void confirm() {
    AlertDialog alertDialog = AlertDialog(
      content: new Text("Detalle '${widget.list[widget.index]['id']}'"),
      actions: <Widget>[
        new RaisedButton(
          shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(20.0)),
          child: new Text(
            "SI",
            style: new TextStyle(color: Colors.black),
          ),
          color: Colors.indigo[900],
          onPressed: () {
            Navigator.of(context).push(new MaterialPageRoute(
                builder: (BuildContext context) => DetallePedido(
                    id: int.parse(widget.list[widget.index]['id']))));
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
    showDialog(
        context: context,
        builder: (BuildContext context) => FancyDialog(
              title: "Desea Entregar el pedido",
              descreption: "Entrego el pedido ?",
              okColor: Colors.indigo[900],
              ok: "Enviar",
              cancel: "Cancelar",

              animationType: FancyAnimation.LEFT_RIGHT,
              theme: FancyTheme.FANCY,
              gifPath: './assets/entregar.gif', //'./assets/walp.png',
              okFun: () async {
                var response = await crud.pedidoEntregado(
                    widget.list[widget.index]['id'].toString());
                Navigator.of(context).push(
                  new MaterialPageRoute(
                      builder: (BuildContext context) => DomicilioEntregado()),
                );
                Toast.show('Pedido entregado con exito', context,
                    duration: Toast.LENGTH_LONG);
              },
            ));
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
          title: new Text(
        "${widget.list[widget.index]['nombre_tienda']}",
        style: new TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
        ),
      )),
      //  drawer: MenuPrincipal(),
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
                Icon(
                  Icons.monetization_on,
                  color: Colors.black,
                  size: 50.0,
                ),
                new Text(
                  "Startogo Driver",
                  style: new TextStyle(
                      fontSize: 25.0,
                      color: Colors.red,
                      fontWeight: FontWeight.bold),
                ),
                new Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                ),
                Divider(),
                new Text(
                  "Subtotal: " + widget.list[widget.index]['subtotalpedido'],
                  style: new TextStyle(
                      fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
                Divider(),
                new Text(
                  "Impuesto: ${widget.list[widget.index]['impuesto']}",
                  style: new TextStyle(
                      fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
                Divider(),
                new Text(
                  "Propina: ${widget.list[widget.index]['ValorPropina']}",
                  style: new TextStyle(
                      fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
                Divider(),
                new Text(
                  "Total: ${widget.list[widget.index]['totalcobrar']}",
                  style: new TextStyle(
                      fontSize: 25.0, fontWeight: FontWeight.bold),
                ),
                new Padding(
                  padding: const EdgeInsets.only(top: 50.0),
                ),
                // new Column(
                //   mainAxisSize: MainAxisSize.min,
                //   children: <Widget>[
                //     new RaisedButton(
                //         child: new Text(
                //             "Ruta${widget.list[widget.index]['latitud']}"),
                //         color: Colors.red,
                //         shape: new RoundedRectangleBorder(
                //             borderRadius: new BorderRadius.circular(90.0)),
                //         onPressed: () => launch(
                //             'https://www.google.com/maps/search/?api=1&query=${widget.list[widget.index]['latitud']},${widget.list[widget.index]['longitud']}')),
                //     new RaisedButton(
                //       child: new Text("Detalles del  Pedido"),
                //       color: Colors.indigo[900],
                //       shape: new RoundedRectangleBorder(
                //           borderRadius: new BorderRadius.circular(90.0)),
                //       onPressed: () {
                //         Navigator.of(context).push(new MaterialPageRoute(
                //             builder: (BuildContext context) => DetallePedido(
                //                 id: int.parse(
                //                     widget.list[widget.index]['id']))));
                //       },
                //     ),
                //     VerticalDivider(),
                //     if (widget.list[widget.index]['estado'] == 'camino')
                //       new RaisedButton(
                //         child: new Text("ENTREGAR"),
                //         color: Colors.blue,
                //         shape: new RoundedRectangleBorder(
                //             borderRadius: new BorderRadius.circular(30.0)),
                //         onPressed: () => confirmarentrega(),
                //       ),
                //   ],
                // ),
              ],
            ),
          ),
        ),
      ),
      //boton navigator
      bottomNavigationBar: _bottomNavigationBar(context),
    );
  }

  Widget _bottomNavigationBar(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        canvasColor: Color.fromRGBO(0, 39, 132, 1.0),
        //   primaryColor: Colors.white
      ),
      //lo que voy a mostrar
      child: BottomNavigationBar(
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.assignment, size: 40.0, color: Colors.white),
              title: Column()),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.map,
                size: 40.0,
                color: Colors.white,
              ),
              title: Container()),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.done_outline,
                size: 40.0,
                color: Colors.white,
              ),
              title: Container())
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
            print(index);
            if (index == 0) {
              Navigator.of(context).push(new MaterialPageRoute(
                  builder: (BuildContext context) => DetallePedido(
                      id: int.parse(widget.list[widget.index]['id']))));
            }
            if (index == 1) {
              if (widget.list[widget.index]['latitud'] == null ||
                  widget.list[widget.index]['latitud'] == '' ||
                  widget.list[widget.index]['longitud'] == null ||
                  widget.list[widget.index]['longitud'] == '') {
                Toast.show('Cliente sin geocalizacion', context,
                    duration: Toast.LENGTH_LONG);
              } else {
                launch(
                    'https://www.google.com/maps/search/?api=1&query=${widget.list[widget.index]['latitud']},${widget.list[widget.index]['longitud']}');
              }
            }
            if (index == 2) {
              if (widget.list[widget.index]['estado'] == 'camino') {
                confirmarentrega();
              } else {
                Toast.show('Espere que el pedido este en camino', context,
                    duration: Toast.LENGTH_LONG);
              }
            }
          });
        },
      ),
    );
  }
}
