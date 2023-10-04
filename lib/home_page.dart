import 'package:consulta_cep_dio/home_controller.dart';
import 'package:consulta_cep_dio/home_data.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final HomeController homeController;

  const HomePage({
    super.key,
    required this.homeController,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String cep = '';
  final _textEditingController = TextEditingController();
  @override
  void initState() {
    // init();
    super.initState();
  }

  init() async {
    // cep = await widget.homeController.findCep('960280');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Text(
            'PESQUISA',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor),
          ),
          const SizedBox(
            height: 36,
          ),
          TextFormField(
            keyboardType: TextInputType.number,
            controller: _textEditingController,
          ),
          const SizedBox(
            height: 36,
          ),
          ElevatedButton(
              onPressed: () async {
                await widget.homeController
                    .findCep(_textEditingController.text);
              },
              child: const Text('Buscar')),
          Expanded(
              child: ListView.builder(
            itemCount: 22,
            itemBuilder: (context, index) {
              return Text('ceps');
            },
          ))
        ]),
      ),
    );
  }
}
