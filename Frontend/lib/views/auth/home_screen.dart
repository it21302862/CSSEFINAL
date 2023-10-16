import 'package:csse/providers/supplier_provider.dart';
import 'package:csse/services/supplier_service.dart';
import 'package:csse/utils/constants.dart';
import 'package:csse/views/items/items_screen.dart';
import 'package:csse/views/order/order_home.dart';
import 'package:csse/views/profile/profile_view.dart';
import 'package:csse/widgets/app_drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int activeIndex = 0;
  List<Widget> get homeBody => [
        ItemScreen(),
        OrderHome(),
        ProfileView(),
      ];
  final _supplierService = SupplierService();
  late SupplierProvider _supplerProvider;
  @override
  void initState() {
    _supplerProvider = Provider.of(context, listen: false);
    _supplierService
        .getAllSuppliers()
        .then((value) => _supplerProvider.setSuppliers(value));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
        body: homeBody[activeIndex],
        drawer: const AppDrawer(),
        bottomNavigationBar: BottomNavigationBar(
          onTap: (val) {
            setState(() {
              activeIndex = val;
            });
          },
          backgroundColor: primaryColor,
          currentIndex: activeIndex,
          type: BottomNavigationBarType.shifting,
          fixedColor: darkBlue,
          unselectedItemColor: Colors.grey,
          showUnselectedLabels: true,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_bag),
              label: "Orders",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: "Profile",
            ),
          ],
        ),
      );
    });
  }
}
