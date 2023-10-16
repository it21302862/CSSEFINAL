import 'dart:math';

import 'package:csse/models/product_model.dart';
import 'package:csse/providers/supplier_provider.dart';
import 'package:csse/providers/user_provider.dart';
import 'package:csse/services/budgets_service.dart';
import 'package:csse/services/supplier_service.dart';
import 'package:csse/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ItemScreen extends StatefulWidget {
  const ItemScreen({super.key});

  @override
  State<ItemScreen> createState() => _ItemScreenState();
}

class _ItemScreenState extends State<ItemScreen> {
  List<Product> items = [];
  final _supplierService = SupplierService();
  bool shouldLoad = false;
  late SupplierProvider supplierProvider;
  @override
  void initState() {
    setState(() {
      shouldLoad = true;
    });
    supplierProvider = Provider.of<SupplierProvider>(context, listen: false);

    _supplierService.getAllSuppliers().then((value) {
      supplierProvider.setSuppliers(value);
    });
    setState(() {
      shouldLoad = false;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      body: shouldLoad
          ? const Center(
              child: CircularProgressIndicator(
                color: primaryColor,
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(defaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: kToolbarHeight / 2,
                  ),
                  SizedBox(
                    height: 54,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const CircleAvatar(
                          child: Icon(Icons.person),
                          backgroundColor: lightGrey,
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        Text('Hello ${userProvider.user?.name}')
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: kToolbarHeight / 2,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.all(defaultPadding),
                    decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(6)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Remaining Budget',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        FutureBuilder<double>(
                            future: BudgetsService()
                                .fetchBudget(userProvider.site?.id ?? ''),
                            builder: (context, snapshot) {
                              return snapshot.hasData
                                  ? Text(
                                      'Rs ${snapshot.data}',
                                      style: const TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    )
                                  : Text('0.0');
                            }),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: kToolbarHeight / 2,
                  ),
                  Expanded(
                    child: GridView.count(
                      crossAxisCount: 2,
                      children: items
                          .map(
                            (e) => Container(
                              margin: const EdgeInsets.symmetric(horizontal: 4),
                              decoration: BoxDecoration(
                                color: lightGrey,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              padding: const EdgeInsets.all(defaultPadding),
                              child: Column(
                                children: [
                                  Expanded(
                                    child: Image.network(
                                      e.imageUrl,
                                      width: 148,
                                    ),
                                  ),
                                  Text(
                                    e.name,
                                  )
                                ],
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
