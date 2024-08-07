import 'package:favorite_places_app/models/place.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'; // Riverpod állapotkezelő csomag importálása
import 'dart:io'; // Fájlkezeléshez szükséges csomag
import 'package:path_provider/path_provider.dart'
    as syspaths; // Helyi fájlútvonalak eléréséhez szükséges csomag
import 'package:path/path.dart'
    as path; // Útvonalak kezeléséhez szükséges csomag
import 'package:sqflite/sqflite.dart' as sql; // SQLite adatbázis kezelő csomag
import 'package:sqflite/sqlite_api.dart'; // SQLite API csomag

Future<Database> _getDatabase() async {
  // Adatbázis útvonalának lekérése
  final dbPath = await sql.getDatabasesPath();
  // Adatbázis megnyitása vagy létrehozása, ha nem létezik
  final db = await sql.openDatabase(
    path.join(dbPath, 'places.db'),
    onCreate: (db, version) {
      // Táblázat létrehozása, ha az adatbázis létrehozásra kerül
      return db.execute(
          'CREATE TABLE user_places(id TEXT PRIMARY KEY, title TEXT, image TEXT, lat REAL, lng REAL, city TEXT)');
    },
    version: 1,
  );
  return db;
}

class UserPlacesNotifier extends StateNotifier<List<Places>> {
  UserPlacesNotifier() : super(const []);

  Future<void> loadPlaces() async {
    final db = await _getDatabase();
    final data = await db.query('user_places');
    final places =data.map(
      (row) => Places(
        id: row['id'] as String,
        title: row['title'] as String,
        image: File(row['image'] as String),
        location: PlaceLocation(
            latitude: row['lat'] as double,
            longItude: row['lng'] as double,
            city: row['city'] as String),
      ),
    ).toList();
    state=places;
  }

  void addPlace(String title, File image, PlaceLocation location) async {
    final appDir = await syspaths
        .getApplicationDocumentsDirectory(); // Az alkalmazás dokumentum könyvtárának elérése
    final filename =
        path.basename(image.path); // Az eredeti kép fájlnevének kinyerése
    final copiedImage = await image.copy(
        '${appDir.path}/$filename'); // Kép másolása az alkalmazás dokumentum könyvtárába

    final newPlace =
        Places(title: title, image: copiedImage, location: location);

    final db = await _getDatabase();

    // Új hely adatok beszúrása az adatbázisba
    db.insert('user_places', {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path,
      'lat': newPlace.location.latitude,
      'lng': newPlace.location.longItude,
      'city': newPlace.location.city
    });

    // Az állapot frissítése az új hely hozzáadásával
    state = [newPlace, ...state];
  }
}

final userPlacesProvider =
    StateNotifierProvider<UserPlacesNotifier, List<Places>>(
  (ref) => UserPlacesNotifier(),
);
