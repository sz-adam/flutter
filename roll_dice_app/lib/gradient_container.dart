import 'package:flutter/material.dart';

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
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset('assets/images/dice-2.png'),
          const SizedBox(height: 20), //fix méret ha van gyermek eleme , és annak a tartalma tulcsordul akkor azt levágja 
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
      )),
    );
  }
}
