import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shop/providers/product.dart';
import 'package:shop/utils/constants.dart';
// import 'package:shop/data/dummy_data.dart';

class Products with ChangeNotifier {
  List<Product> _items = []; //DUMMY_PRODUCTS;
  String? _token;
  Products(this._token, this._items);

  final String _baseUrl = "${Constants.BASE_API_URL}/products";

  List<Product> get items => [..._items];

  List<Product> get favoriteItems {
    return _items.where((prod) => prod.isFavorite).toList();
  }

  int get itemsCount {
    return _items.length;
  }

  Future<void> loadProducts() async {
    _items.clear();
    final Uri _url = Uri.parse("$_baseUrl.json?auth=$_token");
    final response = await http.get(_url);
    // print(json.decode(response.body));
    Map<String, dynamic>? data = json.decode(response.body);
    if (data == null) return Future.value();

    data.forEach((productId, productData) {
      _items.add(Product(
        id: productId,
        title: productData['title'],
        description: productData['description'],
        price: productData['price'],
        imageUrl: productData['imageUrl'],
        isFavorite: productData['isFavorite'],
      ));
    });
    notifyListeners();
    return Future.value();
  }

  Future<void> addProduct(Product newProduct) async {
    final Uri _url = Uri.parse("$_baseUrl.json?auth=$_token");
    final response = await http.post(
      _url,
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

  Future<void> updateProduct(Product product) async {
    if (product.id == null) {
      return;
    }

    final index = _items.indexWhere((prod) => prod.id == product.id);
    if (index >= 0) {
      final Uri _url = Uri.parse("$_baseUrl/${product.id}.json?auth=$_token");
      await http.patch(
        _url,
        body: json.encode({
          'title': product.title,
          'description': product.description,
          'price': product.price,
          'imageUrl': product.imageUrl,
        }),
      );
      _items[index] = product;
      notifyListeners();
    }
  }

  Future<void> deleteProduct(String id) async {
    final index = _items.indexWhere((prod) => prod.id == id);
    if (index >= 0) {
      final product = _items[index];
      // _items.removeWhere((prod) => prod.id == id);
      _items.remove(product);
      notifyListeners();

      final Uri _url = Uri.parse("$_baseUrl/${product.id}.json?auth=$_token");
      final response = await http.delete(_url);
      if (response.statusCode >= 400) {
        print("Erro ao excluir o produto");
        _items.insert(index, product);
        notifyListeners();
        throw HttpException('Ocorreu um erro na exclusão do produto');
      }
    }
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
}
