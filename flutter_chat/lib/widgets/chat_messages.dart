import 'package:chat_app/widgets/message_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatMessages extends StatelessWidget {
  const ChatMessages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authenticatedUser = FirebaseAuth.instance.currentUser!;
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('chat')
          .orderBy('createdAt', descending: true)
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
            child: Text(
                'No messages found'), // Üzenet megjelenítése, ha nincsenek üzenetek
          );
        }

        if (chatSnapshot.hasError) {
          // Ha hiba történik az adatlekérés során
          return const Center(
            child: Text('Something went wrong...'), // Hibajelzés megjelenítése
          );
        }

        final loadedMessages =
            chatSnapshot.data!.docs; // Az üzenetek lekérése az adatokból

        return ListView.builder(
          padding: const EdgeInsets.only(
            bottom: 40,
            left: 13,
            right: 13,
          ),
          reverse:
              true, // Az üzenetek fordított sorrendben történő megjelenítése, hogy a legújabb üzenet legyen alul.
          itemCount: loadedMessages.length, // Az üzenetek száma a listában.
          itemBuilder: (ctx, index) {
            final chatMessage =
                loadedMessages[index].data(); // Az aktuális üzenet adatai.
            final nextChatMessage = index + 1 < loadedMessages.length
                ? loadedMessages[index + 1].data()
                : null; // A következő üzenet adatai, ha létezik.

            final currentMessageUserId = chatMessage[
                'userId']; // Az aktuális üzenet felhasználói azonosítója.
            final nextMessageUserId = nextChatMessage != null
                ? nextChatMessage['userId']
                : null; // A következő üzenet felhasználói azonosítója, ha létezik.
            final nextUserIsSame = nextMessageUserId ==
                currentMessageUserId; // Ellenőrzés, hogy a következő üzenet ugyanattól a felhasználótól származik-e.

            if (nextUserIsSame) {
              return MessageBubble.next(
                message: chatMessage['text'], // Az aktuális üzenet szövege.
                isMe: authenticatedUser.uid ==
                    currentMessageUserId, // Annak meghatározása, hogy az üzenet a bejelentkezett felhasználótól származik-e.
              );
            } else {
              return MessageBubble.first(
                userImage: chatMessage[
                    'userImage'], // Az aktuális üzenet felhasználójának képe.
                username: chatMessage[
                    'username'], // Az aktuális üzenet felhasználójának neve.
                message: chatMessage['text'], // Az aktuális üzenet szövege.
                isMe: authenticatedUser.uid ==
                    currentMessageUserId, // Annak meghatározása, hogy az üzenet a bejelentkezett felhasználótól származik-e.
              );
            }
          },
        );
      },
    );
  }
}
