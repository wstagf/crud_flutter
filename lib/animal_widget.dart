import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'animal.dart';

class AnimalWidget extends StatelessWidget {
  final Animal animal;
  const AnimalWidget({super.key, required this.animal});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      height: 100,
      width: MediaQuery.of(context).size.width,
      color: Colors.red,
      child: Text(animal.name),
    );
  }
}
