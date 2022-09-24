import 'package:exemplo_crud_hive/animal_widget.dart';
import 'package:exemplo_crud_hive/listCrud.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:animated_floating_buttons/animated_floating_buttons.dart';

import 'animal.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GlobalKey<AnimatedFloatingActionButtonState> key =
      GlobalKey<AnimatedFloatingActionButtonState>();

  late Box box;

  late ListCrud ls = ListCrud(list: []);

  bool isLoading = true;

  String flow = "list";

  Animal? selectedAnimal;

  Animal newAnimal =
      Animal(id: 0, name: "name", age: 0, sex: "sex", color: "color");

  @override
  void initState() {
    super.initState();
    initDB();
  }

  Future<void> initDB() async {
    box = await Hive.openBox<ListCrud>('animals');
    getItensInDB(box);
  }

  Future<void> getItensInDB(Box box) async {
    isLoading = true;
    setState(() {
      if (box.keys.isNotEmpty) {
        ls = box.getAt(box.keys.length - 1);
      }
      Future.delayed(
          const Duration(
            seconds: 1,
          ), () {
        setState(() {
          isLoading = false;
        });
      });
    });
  }

  Future<void> updateItensInDB(ListCrud newList) async {
    setState(() {
      box.add(newList);
      getItensInDB(box);
    });
  }

  Widget btnAdd() {
    return FloatingActionButton(
      onPressed: () {
        print(ls.list.length);
      },
      heroTag: "btn1",
      tooltip: 'First button',
      child: const Icon(Icons.add),
    );
  }

  Widget float2() {
    return FloatingActionButton(
      onPressed: () {
        ls.list.add(Animal(
            id: 1, age: 1, color: "white", name: "Nome", sex: "feminino"));
        box.add(ls);

        getItensInDB(box);
      },
      heroTag: "btn2",
      tooltip: 'Second button',
      child: const Icon(Icons.add),
    );
  }

  Widget listPage(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Center(
        child: isLoading
            ? const CircularProgressIndicator()
            : ls.list.isEmpty
                ? const Padding(
                    padding: EdgeInsets.all(25.0),
                    child: Text(
                      'Não existem animais cadastrados, adicione já o primeiro...',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        height: 1.5,
                      ),
                    ),
                  )
                : SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          for (Animal item in ls.list)
                            AnimalWidget(
                                animal: item,
                                onEdit: () {
                                  setState(() {
                                    selectedAnimal = item;

                                    flow = 'edit';
                                  });
                                },
                                onDelete: () {
                                  ls.list.removeWhere(
                                      (element) => element.id == item.id);

                                  updateItensInDB(ls);
                                }),
                          Container(
                            height: 50,
                          ),
                        ],
                      ),
                    ),
                  ),
      ),
    );
  }

  Widget editPage(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(25),
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            TextFormField(
              initialValue: selectedAnimal!.name,
              onChanged: ((String value) {
                setState(() {
                  selectedAnimal!.name = value;
                });
              }),
              decoration: const InputDecoration(
                labelText: "Nome",
                helperText: "Nome do seu animalzinho",
                helperStyle: TextStyle(
                  fontSize: 10,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              initialValue: selectedAnimal!.age.toString(),
              onChanged: ((String value) {
                setState(() {
                  selectedAnimal!.age = int.parse(value);
                });
              }),

              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ], // Only nu
              decoration: const InputDecoration(
                labelText: "Idade",
                helperText:
                    "Idade em anos. ex: 18 meses = 1 ano e 6 meses, então digite 1",
                helperStyle: TextStyle(
                  fontSize: 10,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Sexo',
                  style: TextStyle(
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          selectedAnimal!.sex = "masculino";
                        });
                      },
                      child: Row(
                        children: [
                          Icon(
                            Icons.male,
                            color:
                                selectedAnimal!.sex.toLowerCase() == "masculino"
                                    ? Colors.blue
                                    : Colors.black87,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Masculino',
                            style: TextStyle(
                              color: selectedAnimal!.sex.toLowerCase() ==
                                      "masculino"
                                  ? Colors.blue
                                  : Colors.black87,
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 35,
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          selectedAnimal!.sex = "feminino";
                        });
                      },
                      child: Row(
                        children: [
                          Icon(
                            Icons.female,
                            color:
                                selectedAnimal!.sex.toLowerCase() == "feminino"
                                    ? Colors.blue
                                    : Colors.black87,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Feminino',
                            style: TextStyle(
                              color: selectedAnimal!.sex.toLowerCase() ==
                                      "feminino"
                                  ? Colors.blue
                                  : Colors.black87,
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                const Text(
                  'Macho ou Fêmea',
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 10,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              initialValue: selectedAnimal!.color,
              onChanged: ((String value) {
                setState(() {
                  selectedAnimal!.color = value;
                });
              }),
              decoration: const InputDecoration(
                labelText: "Cor",
                helperText: "Qual a cor do seu animalzinho",
                helperStyle: TextStyle(
                  fontSize: 10,
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      flow = 'list';
                      selectedAnimal = null;
                    });
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: const [
                      Icon(Icons.close),
                      SizedBox(width: 15),
                      Text("Cancelar")
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      ls.list.forEach((element) {
                        if (element.id == selectedAnimal!.id) {
                          element = selectedAnimal!;
                        }
                      });

                      updateItensInDB(ls);
                      flow = 'list';
                    });
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: const [
                      Icon(Icons.save),
                      SizedBox(width: 15),
                      Text("Salvar")
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget buildPage(BuildContext context) {
    if (flow == "list") {
      return listPage(context);
    } else {
      return editPage(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
        'Exemplo de Crud - Lista de Cachorros',
        style: TextStyle(
          fontSize: 14,
        ),
      )),
      body: buildPage(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: AnimatedFloatingActionButton(
        fabButtons: <Widget>[
          btnAdd(),
          float2(),
        ],
        key: key,
        colorStartAnimation: Colors.blue,
        colorEndAnimation: Colors.red,
        animatedIconData: AnimatedIcons.menu_close,
      ),
    );
  }
}
