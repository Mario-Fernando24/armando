import 'dart:async';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:startogodomiciliario/config/constants.dart';

class ApiService {
  final String URL_API = '$BASE_ENDPOINT/api';
  final Client client = new Client();

  Future<String> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.get("token") ?? null;
  }

  Future<Map<String, String>> getHeaders() async {
    var token = await getToken();
    var headers = {
      'Accept': 'application/json',
      'X-Requested-With': 'XMLHttpRequest',
      'Content-Type': 'application/json'
    };
    if (token != null) {
      headers['Authorization'] = 'Bearer $token';
    }
    return headers;
  }

  Future<Response> get(url) async {
    final headers = await getHeaders();
    return client.get('$URL_API/$url', headers: headers);
  }

  Future<Response> post(url, body) async {
    final headers = await getHeaders();
    return client.post('$URL_API/$url', headers: headers, body: body);
  }

  Future<Response> put(url, body) async {
    final headers = await getHeaders();
    return client.put('$URL_API/$url', headers: headers, body: body);
  }

  Future<Response> delete(url) async {
    final headers = await getHeaders();
    return client.delete('$URL_API/$url', headers: headers);
  }
}
