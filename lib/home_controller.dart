import 'package:consulta_cep_dio/cep_model.dart';
import 'package:consulta_cep_dio/home_repository.dart';
import 'package:flutter/foundation.dart';

class HomeController {
  final Homerepository repository;
  final listCeps = ValueNotifier([]);

  HomeController({
    required this.repository,
  });

  Future<String> findCep(String code) async {
    final result = await repository.getcep(code);
    await showList();
    return result;
  }

  Future showList() async {
    listCeps.value = await repository.showCep();
  }
}
