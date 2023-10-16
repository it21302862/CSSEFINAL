import 'package:csse/models/add_order_model.dart';
import 'package:csse/providers/order_provider.dart';
import 'package:csse/providers/user_provider.dart';
import 'package:csse/utils/constants.dart';
import 'package:csse/utils/index.dart';
import 'package:csse/views/order/add_order_delivery_details.dart';
import 'package:csse/widgets/order_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderHome extends StatefulWidget {
  const OrderHome({super.key});

  @override
  State<OrderHome> createState() => _OrderHomeState();
}

class _OrderHomeState extends State<OrderHome> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final OrderProvider orderProvider =
        Provider.of<OrderProvider>(context, listen: false);
    final UserProvider userProvider = Provider.of<UserProvider>(context);
    orderProvider.setOrders();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Orders History'),
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      floatingActionButton: FloatingActionButton.extended(
        elevation: 0,
        onPressed: () {
          context.navigator(context, const AddOrderDeliveryDetials());
        },
        label: const Text("Add Order"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: TextFormField(
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.all(defaultPadding),
                  hintText: 'Search order details in here ...',
                  border: InputBorder.none,
                ),
              ),
            ),
            Consumer<OrderProvider>(
              builder: (context, value, _) => Expanded(
                  child: value.orders.isEmpty
                      ? const Center(
                          child: Text('No Orders'),
                        )
                      : ListView(
                          children: value.orders.map((e) {
                            return OrderCard(order: e);
                          }).toList(),
                        )),
            ),
          ],
        ),
      ),
    );
  }
}
