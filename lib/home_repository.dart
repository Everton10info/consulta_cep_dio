import 'cep_model.dart';
import 'home_data.dart';

class Homerepository {
  final HomeData data;

  Homerepository({required this.data});
  deletecep(String id) async {
    await data.deleteData(id);
  }

  Future<String> getcep(cep) async {
    try {
      final resultDb = await data.getDB(cep);
      if (resultDb["results"].isNotEmpty) return 'Cep já listado!';

      final result = await data.getCep(cep);

      if (result["erro"] == true) return 'Cep Invalido';

      await data.addCep(result);

      return 'Cep Encontrado!';
    } catch (e) {
      return 'Cep Invalido';
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
