import 'dart:io';
import 'package:uuid/uuid.dart';

final uuid = Uuid();

class PlaceLocation {
  PlaceLocation(
      {required this.city, required this.latitude, required this.longItude});
  final double latitude;
  final double longItude;
  final String city;
}

class Places {
  Places({required this.title, required this.image, })
      : id = uuid.v4();
  final String id;
  final String title;
  final File image;
 // final PlaceLocation location;
}
