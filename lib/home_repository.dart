import 'cep_model.dart';
import 'home_data.dart';

class Homerepository {
  final HomeData data;

  Homerepository({required this.data});
  deletecep() {}

  Future<String> getcep(cep) async {
    try {
      final resDb = await data.getDB(cep);

      if (resDb["results"].isEmpty) {
        await data.getCep(cep).then((value) => data.addCep(value));

        return 'Cep Encontrado!';
      }
      return 'Cep Invalido';
    } catch (error) {
      return '';
    }
  }

  Future<List<Cep>> showCep() async {
    List<Cep> listCep = [];
    try {
      final resDb = await data.getList();

      for (var i = 0; i < resDb.length; i++) {
        listCep.add(Cep.fromJson(resDb[i]));
      }

      return listCep;
    } catch (error) {
      return [];
    }
  }
}
