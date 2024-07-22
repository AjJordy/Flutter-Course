import 'package:chat/widgets/messages.dart';
import 'package:chat/widgets/new_message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter chat'),
        actions: [
          DropdownButtonHideUnderline(
            child: DropdownButton(
              icon: Icon(
                Icons.more_vert,
                color: Theme.of(context).primaryIconTheme.color,
              ),
              items: const [
                DropdownMenuItem(
                  value: 'logout',
                  child: Row(
                    children: [
                      Icon(Icons.exit_to_app),
                      SizedBox(width: 8),
                      Text('Sair'),
                    ],
                  ),
                ),
              ],
              onChanged: (item) {
                if (item == 'logout') {
                  FirebaseAuth.instance.signOut();
                }
              },
            ),
          ),
        ],
      ),
      body: const Column(
        children: [
          Expanded(child: Messages()),
          NewMessage(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          FirebaseFirestore.instance.collection('chat').add({
            'text': 'Adicionado manualmente',
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
