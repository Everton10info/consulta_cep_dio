import 'dart:convert';

import 'package:http/http.dart' as http;

abstract interface class HomeData {
  Future<dynamic> getCep(String code);
  Future<dynamic> getDB(String code);
  Future<dynamic> addCep(cep);
  deleteData(String id);
}

class HomeDataImpl implements HomeData {
  @override
  deleteData(String id) {
    // TODO: implement deleteData
    throw UnimplementedError();
  }

  @override
  Future<dynamic> getCep(code) async {
    final urlBuscaCep = 'http://viacep.com.br/ws/$code/json/';
    final result = await http.get(Uri.parse(urlBuscaCep));

    if (result.statusCode == 200) {
      print(result.body);
      return jsonDecode(result.body);
    } else {
      print(result.statusCode);
      throw result.statusCode;
    }
  }

  @override
  Future getDB(String code) async {
    final urlBuscaCep = 'http://viacep.com.br/ws/$code/json/';
    final result = await http.get(Uri.parse(urlBuscaCep));

    if (result.statusCode == 200) {
      print(result.body);
      return jsonDecode(result.body);
    } else {
      print(result.statusCode);
      throw result.statusCode;
    }
  }

  @override
  Future addCep(cep) async {
    const String urlAddCep = 'https://parseapi.back4app.com/classes/cep';
    final result = await http.post(Uri.parse(urlAddCep),
        headers: {
          "X-Parse-Application-Id": "Puc4W5ugN4xcsrZeE2hi5q0TaW9v6NakDthKRyHh",
          "X-Parse-REST-API-Key": "wA0T5iBvfALHj68biMX0qKD7XNYmDmXkJeXuyqc9",
          "Content-Type": "application/json",
        },
        body: jsonEncode(cep));
    print('${result.body}+ deuuuuuu');
  }
}
/* X-Parse-Application-Id: Puc4W5ugN4xcsrZeE2hi5q0TaW9v6NakDthKRyHh

X-Parse-REST-API-Key: wA0T5iBvfALHj68biMX0qKD7XNYmDmXkJeXuyqc9

Content-Type: application/json */