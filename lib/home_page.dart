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
  final _textEditingController = TextEditingController();
  @override
  void initState() {
    init();
    super.initState();
  }

  init() async {
    await widget.homeController.showList();
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
            decoration: const InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 20),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                )),
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
              onPressed: () {
                widget.homeController.findCep(_textEditingController.text).then(
                    (value) =>
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(value),
                          backgroundColor: Colors.green[400],
                        )));
              },
              child: const Text('Buscar')),
          Expanded(
              flex: 2,
              child: ListenableBuilder(
                listenable: widget.homeController.isLoader,
                builder: (context, child) {
                  return widget.homeController.isLoader.value
                      ? const Center(
                          child: LinearProgressIndicator(
                          minHeight: 12,
                        ))
                      : const SizedBox.shrink();
                },
              )),
          Expanded(
              flex: 9,
              child: ValueListenableBuilder(
                valueListenable: widget.homeController.listCeps,
                builder: (BuildContext context, value, Widget? child) {
                  final list = widget.homeController.listCeps.value;
                  return ListView.builder(
                    itemCount: list.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                          leading: Text(list[index].localidade ?? ''),
                          title: Text(list[index].cep),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () async {
                              await widget.homeController
                                  .deleteCep(list[index].objectId);
                            },
                          ),
                        ),
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
