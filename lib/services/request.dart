import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

import 'services.dart';

class HttpRequest {
  var client = http.Client();

  getList(String url) async {
    Response respuesta = await client.get(
      Uri.parse(url),
      headers: await setHeaders(),
    );
    return validarResponse(respuesta);
  }

  post(String url, dynamic json) async {
    Response respuesta = await client.post(
      Uri.parse(url),
      body: json,
      headers: await setHeaders(),
    );
    return validarResponse(respuesta);
  }

  update(String url, dynamic json, int id) async {
    Response respuesta = await client.put(
      Uri.parse('$url$id/'),
      body: json,
      headers: await setHeaders(),
    );
    return validarResponse(respuesta);
  }

  delete(String url, int id) async {
    Response respuesta = await client.delete(
      Uri.parse(url + id.toString()),
      headers: await setHeaders(),
    );
    return validarResponse(respuesta);
  }
}

dynamic validarResponse(Response response) {
  if (response.statusCode >= 200 && response.statusCode <= 208) {
    var result = json.decode(response.body);
    if (result.runtimeType.toString() == 'List<dynamic>') {
      // print(result);
      return result[0];
    } else {
      // print(result);
      return result;
    }
  } else {
    validSesion(response);
    return {"error": response.statusCode, "body": json.decode(response.body)};
  }
}

dynamic setHeaders() async {
  dynamic headers = {
    "Content-Type": "application/x-www-form-urlencoded",
  };

  headers = {'Content-Type': 'application/json; charset=UTF-8'};

  /* dynamic headers = {
    "Content-Type": "application/json; charset=UTF-8",
    "Accept": "application/json"
  }; */

  String bearer = '';
  try {
    bearer = await sotoreSecureData.getData("token");
    headers[HttpHeaders.authorizationHeader] = 'Bearer $bearer';
  } catch (e) {
    return headers;
  }
  return headers;
}

void validSesion(dynamic response) {
  print("Token deleted");
  response = jsonDecode(response.body);
  sotoreSecureData.delData("token");
}
