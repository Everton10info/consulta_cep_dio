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
    widget.homeController.showList();
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: SingleChildScrollView(
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
                  widget.homeController
                      .findCep(_textEditingController.text)
                      .then((value) =>
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(value),
                            backgroundColor: Colors.green[400],
                          )));
                },
                child: const Text('Buscar')),
            const SizedBox(
              height: 16,
            ),
            ListenableBuilder(
              listenable: widget.homeController.isLoader,
              builder: (context, child) {
                return widget.homeController.isLoader.value
                    ? const Center(
                        child: LinearProgressIndicator(
                        minHeight: 12,
                      ))
                    : const SizedBox.shrink();
              },
            ),
            const SizedBox(
              height: 16,
            ),
            ValueListenableBuilder(
              valueListenable: widget.homeController.listCeps,
              builder: (BuildContext context, value, Widget? child) {
                final list = widget.homeController.listCeps.value;
                return SizedBox(
                  height: MediaQuery.of(context).size.height * 0.6,
                  child: ListView.builder(
                    itemCount: list.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                          title: Text(
                            list[index].localidade,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(list[index].logradouro),
                          leading: Container(
                            alignment: Alignment.center,
                            height: 80,
                            width: 70,
                            decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(150)),
                                color: Color.fromARGB(255, 162, 222, 193)),
                            child: Text(
                              list[index].cep,
                              style: const TextStyle(
                                  fontSize: 10, fontWeight: FontWeight.bold),
                            ),
                          ),
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
                  ),
                );
              },
            ),
            SizedBox()
          ]),
        ),
      ),
    );
  }
}
