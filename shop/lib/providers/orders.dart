import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shop/config.dart';
import 'package:shop/providers/cart.dart';

class Order {
  final String id;
  final double total;
  final List<CartItem> products;
  final DateTime date;

  Order({
    required this.id,
    required this.total,
    required this.products,
    required this.date,
  });
}

class Orders with ChangeNotifier {
  List<Order> _items = [];

  List<Order> get items {
    return [..._items];
  }

  int get itemsCount {
    return _items.length;
  }

  Future<void> loadOrders() async {
    List<Order> loadedItems = [];
    final Uri _url = Uri.parse("$ordersUrl.json");
    final response = await http.get(_url);
    // print(json.decode(response.body));
    Map<String, dynamic>? data = json.decode(response.body);

    // _items.clear();
    if (data == null) return Future.value();
    data.forEach((orderId, orderData) {
      loadedItems.add(
        Order(
          id: orderId,
          total: orderData['total'],
          products: (orderData['products'] as List<dynamic>).map((item) {
            return CartItem(
              id: item['id'],
              productId: item['productId'],
              title: item['title'],
              quantity: item['quantity'],
              price: item['price'],
            );
          }).toList(),
          date: DateTime.parse(orderData['date']),
        ),
      );
    });

    _items = loadedItems.reversed.toList();
    notifyListeners();
    return Future.value();
  }

  Future<void> addOrder(Cart cart) async {
    //List<CartItem> products, double total) {
    // final combine = (t, i) => t + (i.price * i.quantity);
    // final total = products.fold(0.0, combine);

    final date = DateTime.now();
    try {
      final Uri _url = Uri.parse("$ordersUrl.json");
      final response = await http.post(
        _url,
        body: json.encode({
          'total': cart.totalAmount,
          'date': date.toIso8601String(),
          'products': cart.items.values
              .map((cartItem) => {
                    'id': cartItem.id,
                    'productId': cartItem.productId,
                    'title': cartItem.title,
                    'quantity': cartItem.quantity,
                    'price': cartItem.price,
                  })
              .toList(),
        }),
      );

      _items.insert(
        0,
        Order(
          id: json.decode(response.body)['name'],
          total: cart.totalAmount, //total,
          products: cart.items.values.toList(), //products,
          date: date,
        ),
      );
      notifyListeners();
    } catch (error) {}
  }
}
