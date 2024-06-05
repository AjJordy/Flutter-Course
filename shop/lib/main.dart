import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/providers/counter_provider.dart';
import 'package:shop/providers/products.dart';
import 'package:shop/utils/app_routes.dart';
import 'package:shop/views/product_detail_screen.dart';
import 'package:shop/views/product_overview_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // return CounterProvider(
    return ChangeNotifierProvider(
      create: (_) => new Products(),
      child: MaterialApp(
        title: 'Minha Loja',
        theme: ThemeData(
          primarySwatch: Colors.purple,
          colorScheme: Theme.of(context).colorScheme.copyWith(
                secondary: Colors.deepOrange,
              ),
          fontFamily: 'Lato',
        ),
        home: ProductOverviewScreen(),
        routes: {
          AppRoutes.PRODUCT_DETAIL: (ctx) => const ProductDetailScreen(),
        },
      ),
    );
  }
}
