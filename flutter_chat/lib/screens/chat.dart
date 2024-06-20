import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:chat_app/widgets/chat_messages.dart';
import 'package:chat_app/widgets/new_message.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  void setupPushNotifications() async {
  final fcm = FirebaseMessaging.instance;

  // Kérjük az értesítési engedélyt a felhasználótól.
  await fcm.requestPermission();

  // Feliratkozunk a 'chat' nevű témára.
  // Ezzel biztosítjuk, hogy az alkalmazás értesítéseket kapjon a 'chat' témakörbe küldött üzenetekről.
  fcm.subscribeToTopic('chat');
}

@override
void initState() {
  super.initState();

  // A push értesítések beállítása az alkalmazás indításakor.
  setupPushNotifications();
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FlutterChat'),
        actions: [
          IconButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
            },
            icon: Icon(
              Icons.exit_to_app,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ],
      ),
      body: Column(
        children: const [
          Expanded(
            child: ChatMessages(),
          ),
          NewMessage(),
        ],
      ),
    );
  }
}