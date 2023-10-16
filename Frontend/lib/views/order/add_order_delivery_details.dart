import 'package:csse/models/order_model.dart';
import 'package:csse/providers/add_order_provider.dart';
import 'package:csse/providers/supplier_provider.dart';
import 'package:csse/providers/user_provider.dart';
import 'package:csse/utils/constants.dart';
import 'package:csse/utils/index.dart';
import 'package:csse/views/order/add_order_items.dart';
import 'package:csse/widgets/custom_subtitle.dart';
import 'package:csse/widgets/date_timer_picker_field.dart';
import 'package:csse/widgets/input_field.dart';
import 'package:csse/widgets/main_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:logger/logger.dart';

class AddOrderDeliveryDetials extends StatefulWidget {
  const AddOrderDeliveryDetials({super.key});

  @override
  State<AddOrderDeliveryDetials> createState() =>
      _AddOrderDeliveryDetialsState();
}

class _AddOrderDeliveryDetialsState extends State<AddOrderDeliveryDetials> {
  SupplierModel? selectedSupplier;
  final requestedBy = TextEditingController();
  final siteName = TextEditingController();
  final deliveryAddress = TextEditingController();
  final contactNumber = TextEditingController();

  final Logger logger = Logger();
//providers
  late UserProvider _userProvider;
  @override
  void initState() {
    _userProvider = Provider.of<UserProvider>(context, listen: false);
    if (_userProvider.user != null) {
      logger.d("User found");
      setState(() {
        requestedBy.text = _userProvider.user!.email;
        if (_userProvider.site != null) {
          siteName.text = _userProvider.site!.name;
        } else {
          logger.e('site is null');
        }
      });
    } else {
      logger.e("user null");
    }

    super.initState();
  }

  DateTime? dateSelected;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final supplierProvider = Provider.of<SupplierProvider>(context);
    final AddOrderProvider addOrderProvider =
        Provider.of<AddOrderProvider>(context);
    if (supplierProvider.suppliers.isNotEmpty) {
      selectedSupplier = supplierProvider.suppliers.first;
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text("Orders"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(defaultPadding),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const CustomSubTitle(text: 'Add delivery information'),
          const SizedBox(
            height: defaultPadding,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    DropdownButtonFormField<SupplierModel>(
                      value: selectedSupplier,
                      items: supplierProvider.suppliers
                          .map((e) => DropdownMenuItem<SupplierModel>(
                                value: e,
                                child: Text(e.name),
                              ))
                          .toList(),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        filled: true,
                        fillColor: Colors.grey[200],
                      ),
                      onChanged: (val) {
                        setState(() {
                          selectedSupplier = val;
                        });
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    CustomInputField(
                      label: "Requested by",
                      hint: 'Requested by',
                      controller: requestedBy,
                      disabled: false,
                    ),
                    CustomInputField(
                      label: "Site name",
                      hint: 'Site name',
                      controller: siteName,
                      disabled: false,
                    ),
                    DatePickerFormFieldWithLabel(
                      hintText: "Delivery Date",
                      label: "Delivery Date",
                      onChangeDate: (date) {
                        setState(() {
                          dateSelected = date;
                        });
                      },
                    ),
                    CustomInputField(
                      label: "Delivery address",
                      hint: 'Delivery address',
                      controller: deliveryAddress,
                    ),
                    CustomInputField(
                      label: "Contact number",
                      hint: 'Contact number',
                      controller: contactNumber,
                    ),
                  ],
                ),
              ),
            ),
          ),
          MainButton(
              onPressed: () {
                if (_formKey.currentState!.validate() &&
                    dateSelected != null &&
                    selectedSupplier != null) {
                  addOrderProvider.setDeliveryDetails(
                    requestedBy: requestedBy.text,
                    requestedTo: selectedSupplier!.id,
                    siteId: siteName.text,
                    deliveryDate: dateSelected!,
                    address: deliveryAddress.text,
                    contactNumber: contactNumber.text,
                  );

                  context.navigator(
                    context,
                    const AddOrderItems(),
                  );
                } else {
                  if (dateSelected == null) {
                    context.showSnackBar('Please pick a date');
                  }
                }
              },
              title: 'Continue')
        ]),
      ),
    );
  }
}
