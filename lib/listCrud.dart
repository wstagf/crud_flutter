import 'package:hive/hive.dart';

import 'animal.dart';

part 'listCrud.g.dart';

@HiveType(typeId: 2)
class ListCrud {
  @HiveField(0)
  List<Animal> list = [];

  ListCrud({required this.list});
}
