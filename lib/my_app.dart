import 'package:exemplo_crud_hive/animal_widget.dart';
import 'package:exemplo_crud_hive/listCrud.dart';
import 'package:flutter/material.dart';

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

  @override
  void initState() {
    super.initState();
    initDB();
  }

  Future<void> initDB() async {
    box = await Hive.openBox<ListCrud>('animals');
    if (box.keys.isNotEmpty) {
      ls = box.getAt(box.keys.length - 1);
      setState(() {});
    }
  }

  Widget float1() {
    return FloatingActionButton(
      onPressed: () {
        print(ls.list.length);
      },
      heroTag: "btn1",
      tooltip: 'First button',
      child: Icon(Icons.add),
    );
  }

  Widget float2() {
    return FloatingActionButton(
      onPressed: () {
        box.add(
          ListCrud(
            list: [
              Animal(
                  id: 1, age: 1, color: "white", name: "Nome", sex: "feminino")
            ],
          ),
        );
      },
      heroTag: "btn2",
      tooltip: 'Second button',
      child: Icon(Icons.add),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Exemplo de Crud')),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              ls.list.isEmpty
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
                  : const SizedBox(),
              for (Animal item in ls.list)
                AnimalWidget(
                  animal: item,
                ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: AnimatedFloatingActionButton(
          fabButtons: <Widget>[float1(), float2()],
          key: key,
          colorStartAnimation: Colors.blue,
          colorEndAnimation: Colors.red,
          animatedIconData: AnimatedIcons.menu_close),
    );
  }
}
