import 'package:consulta_cep_dio/controller/home_controller.dart';
import 'package:consulta_cep_dio/data/home_data.dart';
import 'package:consulta_cep_dio/repository/home_repository.dart';
import 'package:flutter/material.dart';
import 'page/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: const ColorScheme.light(
          primary: Color.fromARGB(255, 162, 222, 193),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: HomePage(
        homeController: HomeController(
          repository: Homerepository(
            data: HomeDataImpl(),
          ),
        ),
      ),
    );
  }
}
