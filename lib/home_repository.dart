import 'package:consulta_cep_dio/cep_model.dart';
import 'package:consulta_cep_dio/home_data.dart';
import 'package:http/http.dart';

class Homerepository {
  final HomeData data;

  Homerepository({required this.data});
  deletecep() {}

  Future<Cep> getcep(cep) async {
    try {
      final res = await data.getCep(cep).then((value) => data.addCep(value));
      print(res);
      return Cep.fromJson(res);
    } catch (error) {
      return Cep();
    }
  }
}

class CepError extends ClientException {
  CepError(super.message);
}
