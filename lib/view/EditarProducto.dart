import 'package:auto_size_text/auto_size_text.dart';
import 'package:startogodomiciliario/controllers/crud.dart';
import 'package:startogodomiciliario/view/domiciliosActivos.dart';
import 'package:flutter/material.dart';

class EditarProducto extends StatefulWidget {
  //declaramos unas variables de tipo listas
  final List list;
  final int index;

  // le paso al metodo por parametro la lista que esto envio "datos" y el id del producto que quiero modificar
  EditarProducto({this.list, this.index});

  @override
  _EditarProductoState createState() => _EditarProductoState();
}

class _EditarProductoState extends State<EditarProducto> {
  //importamos nuestro controlador
  Crud crud = new Crud();
  TextEditingController controllerNombre;
  TextEditingController controllerPrecio;
  TextEditingController controllerStock;
  TextEditingController controllerId;
  @override
  void initState() {
    controllerId =
        TextEditingController(text: widget.list[widget.index]['id'].toString());
    controllerNombre = TextEditingController(
        text: widget.list[widget.index]['name '].toString());
    controllerPrecio = TextEditingController(
        text: widget.list[widget.index]['precio'].toString());
    controllerStock = TextEditingController(
        text: widget.list[widget.index]['stock'].toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new AutoSizeText("Editar Producto"),
      ),
      body: Form(
        child: ListView(
          padding: const EdgeInsets.all(10.0),
          children: <Widget>[
            new Column(children: <Widget>[
              new ListTile(
                leading: const Icon(Icons.person, color: Colors.black),
                title: new TextFormField(
                  controller: controllerNombre,
                  //validamos si el usuario ingreso algun dato
                  validator: (value) {
                    if (value.isEmpty) return "ingrese nombre del producto";
                  },
                  decoration: new InputDecoration(
                    hintText: "Nombre",
                    labelText: "Nombre",
                  ),
                ),
              ),

              new ListTile(
                leading: const Icon(Icons.location_on, color: Colors.black),
                title: new TextFormField(
                  controller: controllerPrecio,
                  //validamos si el usuario ingreso algun dato
                  validator: (value) {
                    if (value.isEmpty) return "Precio...";
                  },
                  decoration: new InputDecoration(
                    hintText: "Precio",
                    labelText: "Precio",
                  ),
                ),
              ),

              new ListTile(
                leading: const Icon(Icons.location_on, color: Colors.black),
                title: new TextFormField(
                  controller: controllerStock,
                  //validamos si el usuario ingreso algun dato
                  validator: (value) {
                    if (value.isEmpty) return "Stock...";
                  },
                  decoration: new InputDecoration(
                    hintText: "Stock",
                    labelText: "Stock",
                  ),
                ),
              ),

              //divido
              const Divider(height: 1.0),

              new Padding(
                padding: const EdgeInsets.all(10.0),
              ),

              new RaisedButton(
                child: new AutoSizeText("Editar"),
                color: Colors.blueAccent,
                onPressed: () {
                  crud.editarData(
                      controllerId.text.trim(),
                      controllerNombre.text.trim(),
                      controllerPrecio.text.trim(),
                      controllerStock.text.trim());
                  Navigator.of(context).push(new MaterialPageRoute(
                    builder: (BuildContext context) => new DomiciliosActivos(),
                  ));
                },
              )
            ])
          ],
        ),
      ),
    );
  }
}
