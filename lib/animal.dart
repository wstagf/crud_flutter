import 'package:hive/hive.dart';

part 'animal.g.dart';

@HiveType(typeId: 1)
class Animal {
  @HiveField(0)
  int id = 0;

  @HiveField(1)
  String name = "";

  @HiveField(2)
  int age = 0;

  @HiveField(3)
  String sex = "";

  @HiveField(4)
  String color = "";

  Animal(
      {required this.id,
      required this.name,
      required this.age,
      required this.sex,
      required this.color});
}
