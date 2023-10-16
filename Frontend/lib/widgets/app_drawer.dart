import 'package:csse/services/auth_service.dart';
import 'package:csse/utils/constants.dart';
import 'package:csse/utils/index.dart';
import 'package:csse/views/auth/login_screen.dart';
import 'package:csse/widgets/drawer_button.dart';
import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Padding(
        padding: const EdgeInsets.all(defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 32,
            ),
            CustomDrawerButton(
              title: "Home",
              onPressed: () {},
              icon: const Icon(Icons.home),
            ),
            CustomDrawerButton(
              title: "Profile",
              onPressed: () {},
              icon: const Icon(Icons.person),
            ),
            CustomDrawerButton(
              title: "Requisitions",
              onPressed: () {},
              icon: const Icon(Icons.request_page),
            ),
            CustomDrawerButton(
              title: "Deliveries",
              onPressed: () {},
              icon: const Icon(Icons.bike_scooter),
            ),
            CustomDrawerButton(
              title: "Items",
              onPressed: () {},
              icon: const Icon(Icons.card_travel),
            ),
            CustomDrawerButton(
              title: "Signout",
              onPressed: () async {
                final _authService = AuthService();
                await _authService.signOutUser().then((value) {
                  context.navigator(context, const LoginScreen());
                });
              },
              icon: const Icon(Icons.logout),
            ),
          ],
        ),
      ),
    );
  }
}
