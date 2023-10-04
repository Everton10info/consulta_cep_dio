import 'package:consulta_cep_dio/cep_model.dart';
import 'package:consulta_cep_dio/home_controller.dart';
import 'package:consulta_cep_dio/utils.dart';
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
  List<Cep> cep = [];
  final _textEditingController = TextEditingController();
  @override
  void initState() {
    init();
    super.initState();
  }

  init() async {
    cep = await widget.homeController.showList();
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
            inputFormatters: [
              MaskFormatter.cepMaskFormatter,
            ],
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
              child: ValueListenableBuilder(
            valueListenable: widget.homeController.listCeps,
            builder: (BuildContext context, value, Widget? child) {
              final list = widget.homeController.listCeps.value;
              return ListView.builder(
                itemCount: list.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Text(list[index].localidade ?? ''),
                    title: Text(list[index].cep),
                  );
                },
              );
            },
          ))
        ]),
      ),
    );
  }
}
