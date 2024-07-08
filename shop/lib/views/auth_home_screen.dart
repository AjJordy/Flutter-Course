import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/providers/auth.dart';
import 'package:shop/views/auth_screen.dart';
import 'package:shop/views/product_overview_screen.dart';

class AuthHomeScreen extends StatelessWidget {
  const AuthHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Auth auth = Provider.of(context);
    return auth.isAuth ? ProductOverviewScreen() : AuthScreen();
  }
}
