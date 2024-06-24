import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/providers/orders.dart';
import 'package:shop/widgets/app_drawer.dart';
import 'package:shop/widgets/order_widget.dart';

// class OrdersScreen extends StatefulWidget {
//   const OrdersScreen({super.key});

//   @override
//   State<OrdersScreen> createState() => _OrdersScreenState();
// }

// class _OrdersScreenState extends State<OrdersScreen> {
// bool _isLoading = true;

// @override
// void initState() {
//   super.initState();
//   Provider.of<Orders>(context, listen: false).loadOrders().then((_) {
//     setState(() {
//       _isLoading = false;
//     });
//   });
// }

class OrdersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final Orders orders = Provider.of<Orders>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text('Meus Pedidos'),
      ),
      drawer: AppDrawer(),
      body: FutureBuilder(
        future: Provider.of<Orders>(context, listen: false).loadOrders(),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.error != null) {
            return Center(child: Text('Ocorreu um erro!'));
          } else {
            return Consumer<Orders>(
              builder: (ctx, orders, child) {
                return ListView.builder(
                  itemCount: orders.itemsCount,
                  itemBuilder: (ctx, i) => OrderWidget(orders.items[i]),
                );
              },
            );
          }
        },
      ),
      // body: _isLoading
      //     ? Center(child: CircularProgressIndicator())
      //     : ListView.builder(
      //         itemCount: orders.itemsCount,
      //         itemBuilder: (ctx, i) => OrderWidget(orders.items[i]),
      //       ),
    );
  }
}
