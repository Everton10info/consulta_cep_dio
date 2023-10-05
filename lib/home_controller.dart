import 'package:consulta_cep_dio/home_repository.dart';
import 'package:flutter/foundation.dart';

class HomeController {
  final Homerepository repository;
  final listCeps = ValueNotifier([]);
  final isLoader = ValueNotifier(false);

  HomeController({
    required this.repository,
  });

  Future<String> findCep(String code) async {
    isLoader.value = true;
    final result = await repository.getcep(code);
    await showList();

    return result;
  }

  Future showList() async {
    isLoader.value = true;
    listCeps.value = await repository.showCep();
    isLoader.value = false;
  }

  deleteCep(String id) async {
    isLoader.value = true;
    await repository.deletecep(id);
    await showList();
  }
}
