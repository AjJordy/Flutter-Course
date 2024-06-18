import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shop/config.dart';
import 'package:shop/data/dummy_data.dart';
import 'package:shop/providers/product.dart';

class Products with ChangeNotifier {
  List<Product> _items = DUMMY_PRODUCTS;

  List<Product> get items => [..._items];

  List<Product> get favoriteItems {
    return _items.where((prod) => prod.isFavorite).toList();
  }

  int get itemsCount {
    return _items.length;
  }

  // bool _showFavoriteOnly = false;

  // List<Product> get items {
  //   if (_showFavoriteOnly) {
  //     return _items.where((prod) => prod.isFavorite).toList();
  //   }
  //   return [..._items];
  // }

  // void showFavoriteOnly() {
  //   _showFavoriteOnly = true;
  //   notifyListeners();
  // }

  // void showAll() {
  //   _showFavoriteOnly = false;
  //   notifyListeners();
  // }

  // Future<void> addProduct(Product newProduct) {
  //   Uri url = Uri.parse('$baseUrl/products.json');
  //   return http.post(
  //     url,
  //     body: json.encode({
  //       'title': newProduct.title,
  //       'description': newProduct.description,
  //       'price': newProduct.price,
  //       'imageUrl': newProduct.imageUrl,
  //       'isFavorite': newProduct.isFavorite,
  //     }),
  //   )
  //   .then((response) {
  //     String id = json.decode(response.body)['name'];
  //     _items.add(Product(
  //       id: id, //Random().nextDouble().toString(),
  //       title: newProduct.title,
  //       description: newProduct.description,
  //       price: newProduct.price,
  //       imageUrl: newProduct.imageUrl,
  //     ));
  //     notifyListeners();
  //   });
  //   // .catchError((error) {
  //   //   print(error);
  //   //   throw error;
  //   // });
  // }

  Future<void> addProduct(Product newProduct) async {
    Uri url = Uri.parse('$baseUrl/products.json');
    final response = await http.post(
      url,
      body: json.encode({
        'title': newProduct.title,
        'description': newProduct.description,
        'price': newProduct.price,
        'imageUrl': newProduct.imageUrl,
        'isFavorite': newProduct.isFavorite,
      }),
    );

    String id = json.decode(response.body)['name'];
    _items.add(Product(
      id: id, //Random().nextDouble().toString(),
      title: newProduct.title,
      description: newProduct.description,
      price: newProduct.price,
      imageUrl: newProduct.imageUrl,
    ));
    notifyListeners();
  }

  void updateProduct(Product product) {
    if (product.id == null) {
      return;
    }

    final index = _items.indexWhere((prod) => prod.id == product.id);
    if (index >= 0) {
      _items[index] = product;
      notifyListeners();
    }
  }

  void deleteProduct(String id) {
    final index = _items.indexWhere((prod) => prod.id == id);
    if (index >= 0) {
      _items.removeWhere((prod) => prod.id == id);
      notifyListeners();
    }
  }
}
