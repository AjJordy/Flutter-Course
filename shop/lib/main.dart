import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/providers/auth.dart';
import 'package:shop/providers/cart.dart';
import 'package:shop/providers/orders.dart';
import 'package:shop/providers/products.dart';
import 'package:shop/utils/app_routes.dart';
import 'package:shop/views/auth_home_screen.dart';
import 'package:shop/views/auth_screen.dart';
import 'package:shop/views/cart_screen.dart';
import 'package:shop/views/orders_screen.dart';
import 'package:shop/views/product_detail_screen.dart';
import 'package:shop/views/product_form_screen.dart';
import 'package:shop/views/product_overview_screen.dart';
import 'package:shop/views/products_screen.dart';
// import 'package:shop/providers/counter_provider.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // return CounterProvider(

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => new Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, Products>(
          create: (_) => new Products(),
          update: (ctx, auth, previousProducts) => new Products(
            auth.token,
            auth.userId,
            previousProducts?.items ?? [],
          ),
        ),
        ChangeNotifierProxyProvider<Auth, Orders>(
          create: (_) => new Orders(),
          update: (ctx, auth, previousOrders) => new Orders(
            auth.token,
            auth.userId,
            previousOrders?.items ?? [],
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => new Cart(),
        ),
      ],
      child: MaterialApp(
        title: 'Minha Loja',
        theme: ThemeData(
          primarySwatch: Colors.purple,
          colorScheme: Theme.of(context).colorScheme.copyWith(
                secondary: Colors.deepOrange,
              ),
          fontFamily: 'Lato',
        ),
        // home: ProductOverviewScreen(),
        routes: {
          AppRoutes.AUTH_HOME: (ctx) => AuthHomeScreen(),
          AppRoutes.HOME: (ctx) => ProductOverviewScreen(),
          AppRoutes.CART: (ctx) => const CartScreen(),
          AppRoutes.ORDERS: (ctx) => OrdersScreen(),
          AppRoutes.PRODUCTS: (ctx) => const ProductsScreen(),
          AppRoutes.PRODUCT_FORM: (ctx) => const ProductFormScreen(),
          AppRoutes.PRODUCT_DETAIL: (ctx) => const ProductDetailScreen(),
        },
      ),
    );
  }
}
