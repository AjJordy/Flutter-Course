import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shop/utils/constants.dart';

class Auth with ChangeNotifier {
  // 'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=${Constants.API_KEY}';
  // 'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=${Constants.API_KEY}';
  Future<void> _authenticate(
      String email, String password, String _urlSegment) async {
    final url =
        'https://identitytoolkit.googleapis.com/v1/accounts:${_urlSegment}?key=${Constants.API_KEY}';
    final Uri uri = Uri.parse(url);
    final response = await http.post(
      uri,
      body: json.encode({
        'email': email,
        'password': password,
        'returnSecureToken': true,
      }),
    );

    print('response: ${json.decode(response.body)}');
    return Future.value();
  }

  Future<void> signup(String email, String password) async {
    return _authenticate(email, password, "signUp");
  }

  Future<void> login(String email, String password) async {
    return _authenticate(email, password, "signInWithPassword");
  }
}
