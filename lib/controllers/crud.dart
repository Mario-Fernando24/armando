import 'dart:core';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:startogodomiciliario/config/constants.dart';
import 'dart:convert';

import 'package:startogodomiciliario/helpers/apiService.dart';

class Crud {
  final String URL_API = '$BASE_ENDPOINT/api';
  //hacemos unas exportaciones el http
  //String serverUrl = "https://startogoweb.com/api/";
  //String serverUrlProducto = "https://startogoweb.com/api/mostrarDomiActivo";

  var status;
  var token;
  var idUsuarioLogueado;
  ApiService apiService = new ApiService();

  //creamos la funcion para el login
  loginData(String email, String password) async{
    String myUrl = "$URL_API/login";
    final response = await http.post(myUrl,
        headers: {'accept': 'application/json'},
        body: {"email": "$email", "password": "$password"});
    status = response.body.contains('error');
    var data = json.decode(response.body);
    if (status) {
      print('data : ${data["error"]}');
    } else {
      print('data : ${data["token"]}');
      _save(data["token"]);
      _savee(data["idUsuarioLogueado"]);
    }
  }

  //funcion para registrar producto

  void registrarDomiciliario(String _nombreController, String _correoController,
      String _contrasenaController) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key) ?? 0;

    //string myUrl= $serverUrl/api
    String myUrl = "$URL_API/api/register";
    final response = await http.post(myUrl, headers: {
      'accept': 'application/json'
    }, body: {
      "name": "$_nombreController",
      "email": "$_correoController",
      "password": "$_contrasenaController"
    });

    status = response.body.contains('error');
    var data = json.decode(response.body);
    if (status) {
      print('data : ${data["error"]}');
    } else {
      print('data : ${data["token"]}');
      _save(data["token"]);
    }
  }

  //metodo para restablecer contraseña
  void olvidasteContrasena(String _correoController) async {
    //string myUrl= $serverUrl/api
    String myUrl = "$URL_API/password/email";
    final response = await http.post(myUrl, headers: {
      'accept': 'application/json'
    }, body: {
      "email": "$_correoController",
    });
  }

  //funcion para update el producto  "editar"
  void actualizarDatosDomi(
      String id,
      String nombreDomi,
      String apellidoDomi,
      String numeroDomi,
      String num_documento,
      String paisDomi,
      String estadoDomi,
      String ciudadDomi,
      String generoDomi) async{
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key) ?? 0;

    String myUrl = "$BASE_ENDPOINT/api/Actualizar/$id";

    http.put(myUrl, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $value'
    }, body: {
      "nombreDomi": "$nombreDomi",
      "apellidoDomi": "$apellidoDomi",
      "numeroDomi": "$numeroDomi",
      "num_documento": "$num_documento",
      "paisDomi": "$paisDomi",
      "estadoDomi": "$estadoDomi",
      "ciudadDomi": "$ciudadDomi",
      "generoDomi": "$generoDomi"
    }).then((response) {
      print('Responses status : ${response.statusCode}');
      print('data : ${response.body}');
    });
  }

  //funcion para update el producto  "editar"
  void pedidoEntregado(String id) async {
    apiService.delete('DomiciliosEntregado/$id').then((response) {
      print('Responses status : ${response.statusCode}');
      print('data : ${response.body}');
    });
  }

  //funcion para eliminar algun producto, le pasamos por parametro el id del producto que queremos eliminar
  void eliminarProducto(String id) async {
    apiService.delete('products/$id').then((response) {
      print('Responses status : ${response.statusCode}');
      print('data : ${response.body}');
    });
  }

  //funcion para mostrar todos los Domicilialios activos
  Future<List> getDomiciliarioActivos() async {
    http.Response response = await apiService.get('mostrarDomiActivo');
    return json.decode(response.body);
  }

  //funcion para mostrar todos los productos

  Future<List> getDomiciliarioEntregados() async {
    http.Response response = await apiService.get('mostrarDomiciliosEntregado');

    return json.decode(response.body);
  }

  //metodo en el cual mando el id por parametro del pedido que quiero que se muestre
  Future<dynamic> getDetallePedido(int id) async {
    var response = await apiService.get('DomiciliosEntregado/$id');
    return json.decode(response.body);
  }

  //metodo en el cual mando el id por parametro del pedido que quiero que se muestre
  Future<dynamic> mostrarPerfil(int id) async {
    var response = await apiService.get('MostrarPerfil/$id');
    return json.decode(response.body);
  }

  //metodo para traerme los datos del domiciliario
  _save(String token) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = token;
    prefs.setString(key, value);
  }

  _read() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key) ?? 0;
    print('read: $value');
  }

  _savee(String idUsuarioLogueado) async {
    final prefs = await SharedPreferences.getInstance();
    final keyy = 'idUsuarioLogueado';
    final valuee = idUsuarioLogueado;
    prefs.setString(keyy, valuee);
  }

  _readd() async {
    final prefs = await SharedPreferences.getInstance();
    final keyy = 'idUsuarioLogueado';
    final valuee = prefs.get(keyy) ?? '';
    print('readd: $valuee');
  }
  
}
