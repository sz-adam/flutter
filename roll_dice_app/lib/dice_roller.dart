import 'dart:math';

import 'package:flutter/material.dart';

final randomizer = Random();

class DiceRoller extends StatefulWidget {
  const DiceRoller({super.key});

  @override
  State<DiceRoller> createState() {
    return _DiceRollerState();
  }
}

class _DiceRollerState extends State<DiceRoller> {
  var currentDiceRoll = 2;

  void rollDice() {
    setState(() {
      currentDiceRoll = randomizer.nextInt(6) + 1; //1-6
    });
  }

  @override
  Widget build(context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset('assets/images/dice-$currentDiceRoll.png'),
        const SizedBox(
            height:
                20), //fix méret ha van gyermek eleme , és annak a tartalma tulcsordul akkor azt levágja
        TextButton(
          onPressed: rollDice,
          style: TextButton.styleFrom(
            // padding: const EdgeInsets.only(top:20),
            foregroundColor: Colors.amber,
            textStyle: const TextStyle(fontSize: 28),
          ),
          child: const Text('Roll dice'),
        )
      ],
    );
  }
}
