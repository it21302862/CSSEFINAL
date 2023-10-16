import 'package:csse/models/add_order_model.dart';
import 'package:csse/models/order_model.dart';
import 'package:csse/providers/add_order_provider.dart';
import 'package:csse/providers/user_provider.dart';
import 'package:csse/services/supplier_service.dart';
import 'package:csse/utils/constants.dart';
import 'package:csse/utils/index.dart';
import 'package:csse/views/order/order_view.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

class OrderCard extends StatelessWidget {
  final OrderModel order;
  const OrderCard({
    super.key,
    required this.order,
  });

  @override
  Widget build(BuildContext context) {
    final AddOrderProvider addOrderProvider =
        Provider.of<AddOrderProvider>(context);
    final UserProvider userProvider = Provider.of<UserProvider>(context);
    return FutureBuilder<SupplierModel>(
        future: SupplierService().getSupplierById(order.supplier),
        builder: (context, snapshot) {
          return GestureDetector(
            onTap: () {
              try {
                addOrderProvider.setDeliveryDetails(
                  requestedBy: userProvider.user?.id ?? '',
                  requestedTo: addOrderProvider.orderModel.supplier,
                  siteId: userProvider.site?.id ?? '',
                  deliveryDate: order.requestedDate,
                  address: userProvider.site?.location ?? '',
                  contactNumber: snapshot.data?.contact ?? '',
                );

                addOrderProvider.orderModel.items = order.items
                    .map((e) => OrderItem.fromMap(e.toMap()))
                    .toList();

                double total = 0.0;
                try {
                  for (ItemModel product in order.items) {
                    total += (product.price *
                        int.parse(product.quantity.toString()));
                  }
                } catch (e) {
                  Logger().e(e);
                }
                context.navigator(
                  context,
                  OrderView(
                    status: order.status,
                    haveToCreate: false,
                    orders: order.items.map((e) => e.toMap()).toList(),
                    totalPrice: total,
                    orderId: order.id ?? '',
                    orderModel: order,
                  ),
                );
              } catch (e) {
                Logger().e(e);
              }
            },
            child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: lightGrey,
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.all(defaultPadding / 2),
              margin: const EdgeInsets.symmetric(vertical: defaultPadding / 4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Chip(
                        backgroundColor: orderStateColors(order.status),
                        label: Text(
                          order.status.toUpperCase(),
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Chip(
                        backgroundColor: lightGrey,
                        label: Text(
                          DateFormat('yyyy-MM-dd').format(order.requestedDate),
                          style: const TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    'Order : ${order.id}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Supplier : ${snapshot.data?.name}',
                        style: const TextStyle(
                          fontSize: 11,
                          color: darkGrey,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const Icon(
                        Icons.arrow_forward_ios,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }
}
