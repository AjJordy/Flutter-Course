import 'package:flutter/material.dart';
import 'package:shop/models/product.dart';
import 'package:shop/providers/counter_provider.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({super.key});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final Product product =
        ModalRoute.of(context)?.settings.arguments as Product;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          product.title,
        ),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
      ),
      // body: Column(
      //   children: [
      //     Text(CounterProvider.of(context)!.state.value.toString()),
      //     ElevatedButton(
      //       onPressed: () {
      //         setState(() {
      //           CounterProvider.of(context)?.state.inc();
      //         });
      //         print(CounterProvider.of(context)?.state.value);
      //       },
      //       child: const Text('+'),
      //     ),
      //   ],
      // ),
    );
  }
}
