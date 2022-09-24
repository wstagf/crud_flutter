import 'package:flutter/material.dart';

import 'animal.dart';

class AnimalWidget extends StatelessWidget {
  final Animal animal;
  const AnimalWidget({super.key, required this.animal});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.fromLTRB(15, 20, 15, 20),
      height: 100,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 186, 206, 255),
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(30.0),
          bottomLeft: Radius.circular(30.0),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 5.0,
            spreadRadius: 5.0,
            offset: Offset(2.0, 2.0),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Nome: ' + animal.name,
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Idade: ' + animal.age.toString()),
              Text('Sexo: ' + animal.sex),
              Text('Cor: ' + animal.color),
              const SizedBox(
                width: 5,
              ),
            ],
          )
        ],
      ),
    );
  }
}
