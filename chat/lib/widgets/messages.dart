import 'package:chat/widgets/message_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Messages extends StatelessWidget {
  const Messages({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('chat')
          .orderBy('createdAt', descending: true)
          .snapshots(),
      builder: (ctx, chatSnapshot) {
        if (chatSnapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        final chatDocs = chatSnapshot.data?.docs;
        return ListView.builder(
          reverse: true,
          itemCount: chatDocs?.length ?? 0,
          itemBuilder: (ctx, i) {
            return chatDocs != null && user != null
                ? MessageBubble(
                    chatDocs[i]['text'],
                    chatDocs[i]['userId'] == user.uid,
                    key: ValueKey(chatDocs[i].id),
                  )
                : Container();
          },
        );
      },
    );
  }
}
