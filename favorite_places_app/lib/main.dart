import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:favorite_places_app/screens/places.dart';
import 'package:google_fonts/google_fonts.dart';

final colorScheme = ColorScheme.fromSeed(
  brightness: Brightness.dark,
  seedColor: const Color.fromARGB(255, 102, 6, 247),
  background: const Color.fromARGB(255, 56, 49, 66),
);

// Létrehoz egy új témát és testre szabja azt a scaffold háttérszínével, színsémával és szöveg témájával
final theme = ThemeData().copyWith(
  scaffoldBackgroundColor: colorScheme.background, // Beállítja a scaffold háttérszínét a colorScheme háttérszínére
  colorScheme: colorScheme, // Beállítja az alkalmazás színsémáját a colorScheme változóval
  textTheme: GoogleFonts.ubuntuCondensedTextTheme().copyWith( // Testre szabja a szöveg témáját az Ubuntu Condensed betűtípussal
    titleSmall: GoogleFonts.ubuntuCondensed( // Beállítja a kis címsorokat az Ubuntu Condensed betűtípussal
      fontWeight: FontWeight.bold, // Vastag betűtípus
    ),
    titleMedium: GoogleFonts.ubuntuCondensed( // Beállítja a közepes címsorokat az Ubuntu Condensed betűtípussal
      fontWeight: FontWeight.bold, // Vastag betűtípus
    ),
    titleLarge: GoogleFonts.ubuntuCondensed( // Beállítja a nagy címsorokat az Ubuntu Condensed betűtípussal
      fontWeight: FontWeight.bold, // Vastag betűtípus
    ),
  ),
);


void main() {
  runApp(
    // Enabled Riverpod for the entire application
   const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Great Places',
      theme: theme,
      home:PlacesScreen(),
    );
  }
}