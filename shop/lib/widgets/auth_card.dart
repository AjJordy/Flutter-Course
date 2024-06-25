import 'package:flutter/material.dart';

enum AuthMode { Signup, Login }

class AuthCard extends StatefulWidget {
  const AuthCard({super.key});

  @override
  State<AuthCard> createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8.0,
      child: Text('card'),
    );
  }
}
