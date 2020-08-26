import 'package:flutter/material.dart';
import 'package:startogodomiciliario/shared/preferencias.dart';
import 'menuLateral/menuprincial.dart';

class Perfil extends StatefulWidget {
  @override
  _PerfilState createState() => _PerfilState();
}

class _PerfilState extends State<Perfil> {
  //instancio la clase de las preferencias del usuario
  final prefs = new PreferenciasUsuarios();
  //declaro la variable del nombre
  String _nombre = '';
  String _email = '';
  String _passwordd = '';
  String _fecha = '';
  String _opcionSelecionada = 'Masculino';

  List _listaSelect = ['Masculino', 'Femenino', 'Otros'];
  //NOS PERMITE MANEJAR LA CAJA DE LA FECHA
  TextEditingController _inputControllerFecha = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Perfil domiciliario'),

        //para activar el color condicion si el colorSegundario es true que muestre negro si no verde
        backgroundColor: (prefs.colorSecundario) ? Colors.black : Colors.green,
      ),
      drawer: MenuPrincipal(),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
        children: <Widget>[
          _crearNombre(),
          Divider(),
          _crearApellido(),
          Divider(),
          _numTelefono(),
          Divider(),
          _crearSelectGenero(),
          Divider(),
          _crearNumDocumento(),
          Divider(),
          _crearPais(),
          Divider(),
          _crearEstado(),
          Divider(),
          _crearCiudad(),
          Divider(),
          //    _crearPersona(),
          Padding(
            padding: new EdgeInsets.only(top: 35.0),
          ),
          _actualizarPerfil()
          //boton
        ],
      ),
    );
  }

  Widget _crearNombre() {
    return TextField(
      //para que se posecione
      //  autofocus: true,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
          //    counter: Text('Letras ${_nombre.length}'),
          hintText: 'Nombre',
          labelText: 'Nombre',
          suffixIcon: Icon(Icons.people_outline),
          icon: Icon(Icons.account_circle)),
      //le paso el valor que digito en el input y lo paso por parametro
      onChanged: (valor) {
        //si quiero que se vea en tiempo real
        setState(() {
          _nombre = valor;
          //  print(_nombre);
        });
      },
    );
  }

  Widget _crearApellido() {
    return TextField(
      //para que se posecione
      //  autofocus: true,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
          //    counter: Text('Letras ${_nombre.length}'),
          hintText: 'Apellido',
          labelText: 'Apellido',
          suffixIcon: Icon(Icons.people_outline),
          icon: Icon(Icons.account_circle)),
      //le paso el valor que digito en el input y lo paso por parametro
      onChanged: (valor) {
        //si quiero que se vea en tiempo real
        setState(() {
          _nombre = valor;
          //  print(_nombre);
        });
      },
    );
  }

  Widget _numTelefono() {
    return TextField(
      //para que se posecione
      //  autofocus: true,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
          //    counter: Text('Letras ${_nombre.length}'),
          hintText: 'N. Telefono',
          labelText: 'N. Telefono',
          suffixIcon: Icon(Icons.phone_android),
          icon: Icon(Icons.phone_android)),
      //le paso el valor que digito en el input y lo paso por parametro
      onChanged: (valor) {
        //si quiero que se vea en tiempo real
        setState(() {
          _nombre = valor;
          //  print(_nombre);
        });
      },
    );
  }

  List<DropdownMenuItem<String>> getOpcionesDropdown() {
    List<DropdownMenuItem<String>> lista = new List();
    _listaSelect.forEach((seleccionando) {
      lista.add(DropdownMenuItem(
        child: Text(seleccionando),
        value: seleccionando,
      ));
    });

    return lista;
  }

  Widget _crearSelectGenero() {
    return Row(
      children: <Widget>[
        Icon(Icons.short_text),
        SizedBox(
          width: 30.0,
        ),
        Expanded(
          child: DropdownButton(
              value: _opcionSelecionada,
              items: getOpcionesDropdown(),
              onChanged: (opt) {
                // print(opt);
                // para que me lo dibuje el valor que seleccione
                setState(() {
                  _opcionSelecionada = opt;
                });
              }),
        )
      ],
    );
  }

  Widget _crearNumDocumento() {
    return TextField(
      //para que se posecione
      //  autofocus: true,
      keyboardType: TextInputType.number,

      decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
          hintText: 'N. Documento',
          labelText: 'N. Documento',
          suffixIcon: Icon(Icons.playlist_add_check),
          icon: Icon(Icons.contacts)),
      //le paso el valor que digito en el input y lo paso por parametro
      onChanged: (valor) {
        //si quiero que se vea en tiempo real
        setState(() {
          _email = valor;
          //  print(_nombre);
        });
      },
    );
  }

  Widget _crearPais() {
    return TextField(
      //para que se posecione
      //  autofocus: true,
      keyboardType: TextInputType.text,

      decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
          hintText: 'Pais',
          labelText: 'Pais',
          suffixIcon: Icon(Icons.ac_unit),
          icon: Icon(Icons.ac_unit)),
      //le paso el valor que digito en el input y lo paso por parametro
      onChanged: (valor) {
        //si quiero que se vea en tiempo real
        setState(() {
          _email = valor;
          //  print(_nombre);
        });
      },
    );
  }

  Widget _crearEstado() {
    return TextField(
      //para que se posecione
      //  autofocus: true,
      keyboardType: TextInputType.text,

      decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
          hintText: 'Estado',
          labelText: 'Estado',
          suffixIcon: Icon(Icons.ac_unit),
          icon: Icon(Icons.ac_unit)),
      //le paso el valor que digito en el input y lo paso por parametro
      onChanged: (valor) {
        //si quiero que se vea en tiempo real
        setState(() {
          _email = valor;
          //  print(_nombre);
        });
      },
    );
  }

  Widget _crearCiudad() {
    return TextField(
      //para que se posecione
      //  obscureText para que me oculto lo que voy escribiendo
      obscureText: true,
      decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
          hintText: 'Ciudad',
          labelText: 'Ciudad',
          suffixIcon: Icon(Icons.ac_unit),
          icon: Icon(Icons.ac_unit)),
      //le paso el valor que digito en el input y lo paso por parametro
      onChanged: (valor) {
        //si quiero que se vea en tiempo real
        setState(() {
          _passwordd = valor;
          //  print(_nombre);
        });
      },
    );
  }

  // Widget _crearPersona() {
  //  return ListTile(
  //   title: Text('Nombre es: $_nombre'),
  //   subtitle: Text('Email:$_email '),
  //   trailing: Text(_opcionSelecionada),
  //  );
//  }

  Widget _actualizarPerfil() {
    return Container(
      height: 60,
      child: new RaisedButton(
          onPressed: () {},
          elevation: 6.0,
          color: (prefs.colorSecundario) ? Colors.black : Colors.green,
          child: Text("Actualizar", style: TextStyle(color: Colors.white)),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0))),
    );
  }
}
