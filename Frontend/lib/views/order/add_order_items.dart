import 'package:csse/models/add_order_model.dart';
import 'package:csse/models/product_model.dart';
import 'package:csse/providers/add_order_provider.dart';
import 'package:csse/services/supplier_service.dart';
import 'package:csse/utils/constants.dart';
import 'package:csse/utils/index.dart';
import 'package:csse/utils/strings.dart';
import 'package:csse/utils/styles.dart';
import 'package:csse/views/order/order_view.dart';
import 'package:csse/widgets/input_field.dart';
import 'package:csse/widgets/loading.dart';
import 'package:csse/widgets/main_button.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

class AddOrderItems extends StatefulWidget {
  const AddOrderItems({super.key});

  @override
  State<AddOrderItems> createState() => _AddOrderItemsState();
}

class _AddOrderItemsState extends State<AddOrderItems> {
  bool shouldLoad = false;
  List<Product> products = [];
  List<Map> selectedProducts = [];
  double totalPrice = 0.0;
  late AddOrderProvider addOrderProvider;

  final quantity = TextEditingController();
  TextEditingController itemName = TextEditingController();
  TextEditingController price = TextEditingController();
  @override
  void initState() {
    addOrderProvider = Provider.of<AddOrderProvider>(context, listen: false);
    setState(() {
      shouldLoad = true;
    });
    try {
      // SupplierService()
      //     .getSupplierProducts(addOrderProvider.orderModel.supplier?.id ?? '')
      //     .then((value) => setState(() {
      //           products = value;
      //           if (products.isNotEmpty) {
      //             selectedValue = products[0];
      //           }
      //         }));
    } catch (e) {
      Logger().e(e);
      context.showSnackBar(e.toString());
    }
    setState(() {
      shouldLoad = false;
    });
    super.initState();
  }

  void addProduct() {
    if (itemName.text.isNotEmpty &&
        quantity.text.isNotEmpty &&
        price.text.isNotEmpty) {
      setState(() {
        selectedProducts.add({
          'name': itemName.text,
          "quantity": quantity.text,
          'price': double.parse(price.text),
        });
      });
    }
  }

  void calculateTotalBill() {
    totalPrice = 0;
    for (Map product in selectedProducts) {
      totalPrice += (product['price'] * int.parse(product['quantity']));
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return shouldLoad
        ? const Loading()
        : Scaffold(
            appBar: AppBar(
              title: Text(
                AppStrings.titleOrder,
                style: titleStyle,
              ),
              centerTitle: true,
            ),
            body: Column(
              children: [
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.all(defaultPadding),
                    children: [
                      const SizedBox(
                        height: defaultPadding,
                      ),
                      Text(
                        AppStrings.subTitleAddItem,
                        style: subTitleStyle,
                      ),
                      Row(
                        children: [
                          Flexible(
                            flex: 1,
                            fit: FlexFit.tight,
                            child: CustomInputField(
                              controller: itemName,
                              hint: 'Item Name',
                              label: 'Item Name',
                            ),
                          ),
                          Flexible(
                            flex: 1,
                            fit: FlexFit.tight,
                            child: CustomInputField(
                              controller: quantity,
                              label: 'Quantity',
                              hint: 'Quantity',
                              inputType: TextInputType.number,
                            ),
                          ),
                          Flexible(
                            flex: 1,
                            fit: FlexFit.tight,
                            child: CustomInputField(
                              controller: price,
                              label: 'Price',
                              hint: 'Price',
                              inputType: TextInputType.number,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Divider(
                              height: 10,
                              color: Colors.grey[900],
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Colors.grey[900],
                              shape: BoxShape.circle,
                            ),
                            child: IconButton(
                              onPressed: () {
                                addProduct();
                                calculateTotalBill();
                                itemName.clear();
                                quantity.clear();
                                price.clear();
                                setState(() {});
                              },
                              icon: const Icon(
                                Icons.add,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Expanded(
                            child: Divider(
                              height: 10,
                              color: Colors.grey[900],
                            ),
                          ),
                        ],
                      ),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Item",
                            style: subTitleStyle,
                          ),
                          Text(
                            "Quantity",
                            style: subTitleStyle,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      ...selectedProducts
                          .map(
                            (e) => Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  e["name"],
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      e["quantity"],
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        setState(() {
                                          selectedProducts.remove(e);
                                        });
                                        calculateTotalBill();
                                      },
                                      icon: const Icon(
                                        Icons.delete,
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          )
                          .toList()
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(defaultPadding),
                  child: MainButton(
                    onPressed: () {
                      addOrderProvider.orderModel.setItems = selectedProducts
                          .map((e) => OrderItem.fromMap(e))
                          .toList();
                      context.navigator(
                          context,
                          OrderView(
                            orders: selectedProducts,
                            totalPrice: totalPrice,
                            orderId: '',
                            orderModel: null,
                          ));
                    },
                    title: 'Total Amount Rs. ${totalPrice.toStringAsFixed(2)}',
                  ),
                )
              ],
            ),
          );
  }
}
