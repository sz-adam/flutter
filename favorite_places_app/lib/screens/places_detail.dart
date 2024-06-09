import 'package:flutter/material.dart';

import '../models/place.dart';

class PlaceDetailScreen extends StatelessWidget {
  const PlaceDetailScreen({super.key, required this.place});

  final Places place;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(place.title),
        ),
        //Stack több widget egymásra helyezése /megjelenítése 
        body: Stack(
          children: [
            //fullscreen a kép
            Image.file(place.image,
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity),
          ],
        ));
  }
}
