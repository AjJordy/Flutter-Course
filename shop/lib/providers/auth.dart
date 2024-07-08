import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shop/exceptions/auth_exception.dart';
import 'package:shop/utils/constants.dart';

class Auth with ChangeNotifier {
  String? _token;
  DateTime? _expiryDate;

  String? get token {
    if (_token != null &&
        _expiryDate != null &&
        _expiryDate!.isAfter(DateTime.now())) {
      return _token;
    }
    return null;
  }

  bool get isAuth {
    return token != null;
  }

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

    final responseBody = json.decode(response.body);
    print('response: $responseBody');
    if (responseBody["error"] != null) {
      throw AuthException(responseBody['error']['message']);
    } else {
      _token = responseBody['idToken'];
      _expiryDate = DateTime.now().add(
        Duration(
          seconds: int.parse(
            responseBody['expiresIn'],
          ),
        ),
      );
      notifyListeners();
    }

    return Future.value();
  }

  Future<void> signup(String email, String password) async {
    return _authenticate(email, password, "signUp");
  }

  Future<void> login(String email, String password) async {
    return _authenticate(email, password, "signInWithPassword");
  }
}
