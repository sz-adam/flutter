import 'package:flutter/material.dart';
import 'package:roll_dice_app/styled_text.dart';

class GradientContainer extends StatelessWidget {
  const GradientContainer(this.color1, this.color2, {super.key});

  final Color color1;
  final Color color2;

  void rollDice() {}

  @override
  Widget build(context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [color1, color2],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Center(
          child: Column(
        children: [
          Image.asset('assets/images/dice-2.png'),
          TextButton(onPressed: rollDice, child: const Text('Roll dice'))
        ],
      )),
    );
  }
}
