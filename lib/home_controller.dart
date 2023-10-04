import 'package:consulta_cep_dio/home_repository.dart';

class HomeController {
  final Homerepository repository;

  HomeController({
    required this.repository,
  });

  Future<String> findCep(String code) async {
    final result = await repository.getcep(code);
    return result.cep ?? 'Cep inexistente';
  }
}
