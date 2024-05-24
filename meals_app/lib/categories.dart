import 'package:flutter/material.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pick your Category'),
      ),
      body: GridView(
        //grid elem :crossAxisCount 2 oszlop ,childAspectRatio: 3 / 2, // Szélesség / Magasság arány
        //rács elemek közötti távolság crossAxisSpacing: 20, mainAxisSpacing: 20
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20),
        children: [
          Text(
            '1',
            style: TextStyle(color: Colors.amber),
          ),
          Text(
            '1',
            style: TextStyle(color: Colors.amber),
          ),
          Text(
            '1',
            style: TextStyle(color: Colors.amber),
          ),
          Text(
            '1',
            style: TextStyle(color: Colors.amber),
          ),
          Text(
            '1',
            style: TextStyle(color: Colors.amber),
          ),
          Text(
            '1',
            style: TextStyle(color: Colors.amber),
          ),
          Text(
            '1',
            style: TextStyle(color: Colors.amber),
          ),
          Text(
            '1',
            style: TextStyle(color: Colors.amber),
          ),
          
        ],
      ),
    );
  }
}
