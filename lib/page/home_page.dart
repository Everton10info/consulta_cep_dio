import 'package:consulta_cep_dio/controller/home_controller.dart';
import 'package:consulta_cep_dio/shared/utils.dart';
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
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    widget.homeController.showList();
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        persistentFooterButtons: [
          Align(
            child: ElevatedButton(
                style: ButtonStyle(
                  maximumSize: MaterialStateProperty.all(Size.infinite),
                  minimumSize: MaterialStateProperty.all(
                    const Size.fromWidth(324),
                  ),
                ),
                onPressed: () {
                  if (!_formKey.currentState!.validate()) return;
                  widget.homeController
                      .findCep(_textEditingController.text)
                      .then((value) =>
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(
                              value,
                              style: const TextStyle(fontSize: 16),
                            ),
                            backgroundColor: value == 'Cep Invalido'
                                ? const Color.fromARGB(255, 248, 193, 111)
                                : Colors.green[400],
                          )));
                },
                child: const Text('Buscar')),
          ),
        ],
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 162, 222, 193),
        ),
        body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: SingleChildScrollView(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
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
                  Form(
                    key: _formKey,
                    child: TextFormField(
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
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Campo Obrigatório!';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 36,
                  ),
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
                        height: MediaQuery.of(context).size.height * 0.5,
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
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(150)),
                                      color:
                                          Color.fromARGB(255, 162, 222, 193)),
                                  child: Text(
                                    list[index].cep,
                                    style: const TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold),
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
                ]),
          ),
        ),
      ),
    );
  }
}
