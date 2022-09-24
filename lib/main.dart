import 'package:exemplo_crud_hive/animal.dart';
import 'package:exemplo_crud_hive/listCrud.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'my_app.dart';

Future<void> main() async {
  await openHiveBox('crud');

  runApp(
    MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyApp(),
    ),
  );
}

Future<Box> openHiveBox(String boxName) async {
  Hive.registerAdapter(AnimalAdapter());
  Hive.registerAdapter(ListCrudAdapter());

  if (!kIsWeb && !Hive.isBoxOpen(boxName)) {
    await Hive.initFlutter();
  }

  return await Hive.openBox(boxName);
}
