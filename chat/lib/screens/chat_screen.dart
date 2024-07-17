import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  // final chatCollection = FirebaseFirestore.instance.collection('chat');
  // chatCollection.snapshots().listen(
  //   (querySnapshot) {
  //     querySnapshot.docs.forEach((doc) {
  //       print(doc["text"]);
  //     });
  //   },
  // );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('chat').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          final documents = snapshot.data?.docs;
          return ListView.builder(
            itemCount: documents?.length ?? 0,
            itemBuilder: (ctx, i) => Container(
              padding: const EdgeInsets.all(10),
              child: Text(documents?[i]['text'] ?? ""),
            ),
          );
        },
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
