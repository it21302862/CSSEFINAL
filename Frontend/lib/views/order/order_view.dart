import 'package:csse/models/add_order_model.dart';
import 'package:csse/models/order_model.dart';
import 'package:csse/providers/add_order_provider.dart';
import 'package:csse/providers/loading_provider.dart';
import 'package:csse/services/order_service.dart';
import 'package:csse/utils/constants.dart';
import 'package:csse/utils/index.dart';
import 'package:csse/utils/styles.dart';
import 'package:csse/views/auth/home_screen.dart';
import 'package:csse/widgets/loading_wrapper.dart';
import 'package:csse/widgets/main_button.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class OrderView extends StatefulWidget {
  final List<Map> orders;
  final double totalPrice;
  final bool haveToCreate;
  final String? status;
  final String orderId;
  final OrderModel? orderModel;
  const OrderView({
    super.key,
    required this.orders,
    required this.totalPrice,
    this.haveToCreate = true,
    this.status,
    required this.orderId,
    required this.orderModel,
  });

  @override
  State<OrderView> createState() => _OrderViewState();
}

class _OrderViewState extends State<OrderView> {
  late String status;
  @override
  void initState() {
    status = widget.status ?? 'pending';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final AddOrderProvider addOrderProvider =
        Provider.of<AddOrderProvider>(context);

    final LoadingProvider loadingProvider =
        Provider.of<LoadingProvider>(context);
    return LoadingWrapper(
      secondScreen: Scaffold(
        appBar: AppBar(
          title: Text(
            widget.haveToCreate ? "Order" : 'Track Order',
            style: titleStyle,
          ),
        ),
        body: DefaultTextStyle(
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w400,
            color: Colors.black,
          ),
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(defaultPadding),
                  children: [
                    const Text('Summary', style: subTitleStyle),
                    const SizedBox(
                      height: 8,
                    ),
                    if (widget.status != null) const Divider(),
                    if (widget.status != null)
                      const Text(
                        'Order information',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 13,
                        ),
                      ),
                    if (widget.status != null)
                      const SizedBox(
                        height: 8,
                      ),
                    if (widget.status != null)
                      Text.rich(
                        TextSpan(
                            text: 'Status : ',
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                            ),
                            children: [
                              TextSpan(
                                text: widget.status?.toUpperCase(),
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: orderStateColors(
                                      widget.status ?? 'pending'),
                                ),
                              )
                            ]),
                      ),
                    if (widget.status != null) const Divider(),
                    const Text(
                      'Deliver information',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 13,
                      ),
                    ),
                    const Divider(),
                    Text(
                      'Supplier : ${addOrderProvider.orderModel.supplier}',
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      'Site : ${addOrderProvider.orderModel.siteId}',
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      'Required Date : ${DateFormat('yyyy/MM/dd').format(addOrderProvider.orderModel.requesingDate)}',
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      'Delivery Address : ${addOrderProvider.orderModel.address}',
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      'Contact Number : ${addOrderProvider.orderModel.contactNumber}',
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    if (widget.haveToCreate)
                      const Text(
                        'Item Information',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 13,
                        ),
                      ),
                    if (widget.haveToCreate) const Divider(),
                    if (widget.haveToCreate)
                      const DefaultTextStyle(
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              flex: 1,
                              fit: FlexFit.tight,
                              child: Text(
                                'Item',
                                textAlign: TextAlign.start,
                              ),
                            ),
                            Flexible(
                              flex: 1,
                              fit: FlexFit.tight,
                              child: Text(
                                'Quantity',
                                textAlign: TextAlign.end,
                              ),
                            ),
                            Flexible(
                              flex: 1,
                              fit: FlexFit.tight,
                              child: Text(
                                'Unit Price',
                                textAlign: TextAlign.end,
                              ),
                            ),
                            Flexible(
                              flex: 1,
                              fit: FlexFit.tight,
                              child: Text(
                                'Total Amount',
                                textAlign: TextAlign.end,
                              ),
                            ),
                          ],
                        ),
                      ),
                    if (widget.haveToCreate) const Divider(),
                    if (!widget.haveToCreate)
                      DropdownButtonFormField(
                        value: status,
                        items: const [
                          DropdownMenuItem(
                            child: Text('Pending'),
                            value: 'pending',
                          ),
                          DropdownMenuItem(
                            child: Text('Accepted'),
                            value: 'accepted',
                          ),
                          DropdownMenuItem(
                            child: Text('Completed'),
                            value: 'completed',
                          ),
                        ],
                        onChanged: (val) {
                          setState(() {
                            status = val ?? 'pending';
                          });
                        },
                      ),
                    if (widget.haveToCreate)
                      ...addOrderProvider.orderModel.items
                          .map(
                            (e) => DefaultTextStyle(
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                              child: Row(
                                children: [
                                  Flexible(
                                    flex: 1,
                                    fit: FlexFit.tight,
                                    child: Text(
                                      e.name,
                                      textAlign: TextAlign.start,
                                    ),
                                  ),
                                  Flexible(
                                    flex: 1,
                                    fit: FlexFit.tight,
                                    child: Text(
                                      e.qty.toString(),
                                      textAlign: TextAlign.end,
                                    ),
                                  ),
                                  Flexible(
                                    flex: 1,
                                    fit: FlexFit.tight,
                                    child: Text(
                                      e.price.toStringAsFixed(2),
                                      textAlign: TextAlign.end,
                                    ),
                                  ),
                                  Flexible(
                                    flex: 1,
                                    fit: FlexFit.tight,
                                    child: Text(
                                      (e.price * e.qty).toStringAsFixed(2),
                                      textAlign: TextAlign.end,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                          .toList(),
                    const Divider(),
                    if (widget.haveToCreate)
                      DefaultTextStyle(
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Flexible(
                              flex: 1,
                              fit: FlexFit.tight,
                              child: Text(
                                'Total',
                                textAlign: TextAlign.start,
                              ),
                            ),
                            Flexible(
                              flex: 1,
                              fit: FlexFit.tight,
                              child: Text(
                                widget.totalPrice.toStringAsFixed(2),
                                textAlign: TextAlign.end,
                              ),
                            ),
                          ],
                        ),
                      ),
                    const Divider(
                      height: 8,
                      color: Colors.black,
                    ),
                  ],
                ),
              ),
              if (!widget.haveToCreate)
                Padding(
                  padding: const EdgeInsets.all(defaultPadding),
                  child: MainButton(
                      onPressed: () async {
                        if (widget.orderModel != null) {
                          try {
                            OrderModel o = widget.orderModel!;
                            o.setStatus = status;
                            print(status);
                            await OrderService().updateOrder(o);
                            context.showSnackBar('Updated successfully');
                          } catch (e) {
                            context.showSnackBar(e.toString());
                          }
                        }
                      },
                      title: 'Update'),
                ),
              if (widget.haveToCreate)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: MainButton(
                    onPressed: () async {
                      try {
                        loadingProvider.updateLoadingState(state: true);
                        OrderModel order = OrderModel(
                          items: addOrderProvider.orderModel.items
                              .map(
                                (e) => ItemModel.fromMap(
                                  e.toJson(),
                                ),
                              )
                              .toList(),
                          requestedDate:
                              addOrderProvider.orderModel.requesingDate,
                          status: 'pending',
                          supplier: addOrderProvider.orderModel.supplier,
                        );
                        await OrderService().addOrder(order);
                        loadingProvider.updateLoadingState(state: false);
                        addOrderProvider.clearOrder();
                        Alert(
                          context: context,
                          title: 'Order Success',
                          desc: 'Order created successfully',
                          type: AlertType.success,
                          buttons: [
                            DialogButton(
                                child: Text("Okay"),
                                onPressed: () {
                                  Navigator.pop(context);
                                  context.navigator(
                                      context, const HomeScreen());
                                })
                          ],
                        ).show();
                      } catch (e) {
                        context.showSnackBar(e.toString());
                        loadingProvider.updateLoadingState(state: false);
                      }
                    },
                    title: 'Make Order',
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}
