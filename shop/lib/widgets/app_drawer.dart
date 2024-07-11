import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/providers/auth.dart';
import 'package:shop/utils/app_routes.dart';
import 'package:shop/utils/custom_route.dart';
import 'package:shop/views/orders_screen.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: Text('Bem vindo Usuário'),
            automaticallyImplyLeading: false,
            backgroundColor: Theme.of(context).primaryColor,
            foregroundColor: Colors.white,
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.shop),
            title: Text('Loja'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(AppRoutes.AUTH_HOME);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.payment),
            title: Text('Pedidos'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(AppRoutes.ORDERS);
              // Navigator.of(context).pushReplacement(
              //   CustomRoute(
              //     builder: (ctx) => OrdersScreen(),
              //     // settings: settings,
              //   ),
              // );
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.edit),
            title: Text('Gerenciar Produtos'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(AppRoutes.PRODUCTS);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Sair'),
            onTap: () {
              Provider.of<Auth>(context, listen: false).logout();
            },
          ),
        ],
      ),
    );
  }
}
