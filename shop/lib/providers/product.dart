import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shop/utils/constants.dart';

class Product with ChangeNotifier {
  final String? id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Product({
    this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
    this.isFavorite = false,
  });

  void _toggleFavorite() {
    isFavorite = !isFavorite;
    notifyListeners();
  }

  void toggleFavorite(String? token, String? userId) async {
    _toggleFavorite();

    try {
      // final Uri _url =
      //     Uri.parse("${Constants.BASE_API_URL}/products/$id.json?auth=$token");
      final Uri _url = Uri.parse(
          "${Constants.BASE_API_URL}/userFavorites/$userId/$id.json?auth=$token");
      final response = await http.put(
        _url,
        body: json.encode(isFavorite),
      );
      if (response.statusCode >= 400) {
        _toggleFavorite();
      }
    } catch (error) {
      _toggleFavorite();
    }
  }
}
