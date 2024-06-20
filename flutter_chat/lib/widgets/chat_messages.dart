import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatMessages extends StatelessWidget {
  const ChatMessages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('chat')
          .orderBy('createdAt', descending: false)
          .snapshots(), // Firestore gyűjtemény lekérése és rendezése a 'createdAt' mező alapján növekvő sorrendben, folyamatos stream figyelése
      builder: (ctx, chatSnapshot) {
        // A StreamBuilder által figyelt adatok alapján építjük fel a widgetet

        if (chatSnapshot.connectionState == ConnectionState.waiting) {
          // Ha a kapcsolat állapota várakozás
          return const Center(
            child: CircularProgressIndicator(), // Mutatja a betöltési jelzőt
          );
        }

        if (!chatSnapshot.hasData || chatSnapshot.data!.docs.isEmpty) {
          // Ha nincs adat vagy az adatok üresek
          return const Center(
            child: Text('No messages found'), // Üzenet megjelenítése, ha nincsenek üzenetek
          );
        }

        if (chatSnapshot.hasError) {
          // Ha hiba történik az adatlekérés során
          return const Center(
            child: Text('Something went wrong...'), // Hibajelzés megjelenítése
          );
        }

        final loadedMessages = chatSnapshot.data!.docs; // Az üzenetek lekérése az adatokból

        return ListView.builder(
          itemCount: loadedMessages.length, // Az üzenetek számának megadása a ListView számára
          itemBuilder: (ctx, index) =>
              Text(loadedMessages[index].data()['text']), // Az üzenetek szövegének megjelenítése
        );
      },
    );
  }
}