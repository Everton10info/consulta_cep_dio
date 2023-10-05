import 'dart:convert';
import 'package:http/http.dart' as http;

abstract interface class HomeData {
  Future<Map<String, dynamic>> getCep(String code);
  Future<Map<String, dynamic>> getDB(String code);
  Future<List> getList();
  Future<dynamic> addCep(cep);

  deleteData(String id);
}

class HomeDataImpl implements HomeData {
  @override
  deleteData(String id) async {
    print('$id === id');
    final urldellCep = 'https://parseapi.back4app.com/classes/cep/$id';
    final result = await http.delete(Uri.parse(urldellCep), headers: {
      "X-Parse-Application-Id": "Puc4W5ugN4xcsrZeE2hi5q0TaW9v6NakDthKRyHh",
      "X-Parse-REST-API-Key": "wA0T5iBvfALHj68biMX0qKD7XNYmDmXkJeXuyqc9",
      "Content-Type": "application/json",
    });
    print(result.body);
  }

  @override
  Future<Map<String, dynamic>> getCep(code) async {
    final cep = code.replaceAll('-', '');
    final urlBuscaCep = 'http://viacep.com.br/ws/$cep/json/';
    final result = await http.get(
      Uri.parse(urlBuscaCep),
    );

    if (result.statusCode == 200) {
      return jsonDecode(result.body);
    } else {
      throw result.statusCode;
    }
  }

  @override
  Future<Map<String, dynamic>> getDB(String code) async {
    const String urlAddCep = 'https://parseapi.back4app.com/classes/cep';
    try {
      final result = await http
          .get(Uri.parse('$urlAddCep?where={"cep":"$code"}'), headers: {
        "X-Parse-Application-Id": "Puc4W5ugN4xcsrZeE2hi5q0TaW9v6NakDthKRyHh",
        "X-Parse-REST-API-Key": "wA0T5iBvfALHj68biMX0qKD7XNYmDmXkJeXuyqc9",
        "Content-Type": "application/json",
      });

      return jsonDecode(result.body);
    } catch (e) {
      rethrow;
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
    print('${result.body}+ add');
  }

  @override
  Future<List> getList() async {
    const String urlAddCep = 'https://parseapi.back4app.com/classes/cep';
    try {
      final result = await http.get(Uri.parse(urlAddCep), headers: {
        "X-Parse-Application-Id": "Puc4W5ugN4xcsrZeE2hi5q0TaW9v6NakDthKRyHh",
        "X-Parse-REST-API-Key": "wA0T5iBvfALHj68biMX0qKD7XNYmDmXkJeXuyqc9",
        "Content-Type": "application/json",
      });
      print('${jsonDecode(result.body)['results'].runtimeType}');
      return jsonDecode(result.body)['results'];
    } catch (e) {
      rethrow;
    }
  }
}
