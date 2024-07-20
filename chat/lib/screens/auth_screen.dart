import 'package:chat/models/auth_data.dart';
import 'package:chat/widgets/auth_form.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _auth = FirebaseAuth.instance;
  final _scaffoldKey = GlobalKey<ScaffoldMessengerState>();

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    Firebase.initializeApp().whenComplete(() {
      setState(() {});
    });
  }

  Future<DocumentSnapshot> getData() async {
    await Firebase.initializeApp();
    return await FirebaseFirestore.instance
        .collection("users")
        .doc("docID")
        .get();
  }

  Future<void> _handleSubmit(AuthData authData) async {
    // print(authData.name);
    // print(authData.email);
    // print(authData.password);

    if (authData.email == null || authData.password == null) {
      return Future.value();
    }

    setState(() {
      _isLoading = true;
    });

    try {
      if (authData.isLogin) {
        await _auth.signInWithEmailAndPassword(
          email: authData.email!.trim(),
          password: authData.password!.trim(),
        );
      } else {
        UserCredential userCredential =
            await _auth.createUserWithEmailAndPassword(
          email: authData.email!.trim(),
          password: authData.password!.trim(),
        );
        final userData = {
          'name': authData.name,
          'email': authData.email,
        };
        await FirebaseFirestore.instance
            .collection('user')
            .doc(userCredential.user?.uid)
            .set(userData);
      }
    } on PlatformException catch (err) {
      final msg = err.message ?? "Ocorreu um erro. Verifique suas credenciais";
      _scaffoldKey.currentState?.showSnackBar(
        SnackBar(content: Text(msg)),
      );
    } catch (err) {
      print("Error: $err");
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              children: [
                AuthForm(_handleSubmit),
                if (_isLoading)
                  Positioned.fill(
                    child: Container(
                      margin: const EdgeInsets.all(20),
                      decoration: const BoxDecoration(
                        color: Color.fromRGBO(0, 0, 0, 0.5),
                      ),
                      child: const Center(child: CircularProgressIndicator()),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
