import 'package:flutter/material.dart';

class DiceRoller extends StatefulWidget {
  const DiceRoller({super.key});

  @override
  State<DiceRoller> createState() {
    return _DiceRollerState();
  }
}

class _DiceRollerState extends State<DiceRoller> {
  var activeDiceImage = 'assets/images/dice-2.png';

  void rollDice() {
    setState(() {
      activeDiceImage = 'assets/images/dice-4.png';
    });
  }

  @override
  Widget build(context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(activeDiceImage),
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
