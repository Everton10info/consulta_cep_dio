import 'package:consulta_cep_dio/home_controller.dart';
import 'package:consulta_cep_dio/home_data.dart';
import 'package:consulta_cep_dio/home_repository.dart';
import 'package:flutter/material.dart';
import 'home_page.dart';

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
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.lightGreen,
          backgroundColor: Colors.white,
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
