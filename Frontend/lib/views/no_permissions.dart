import 'package:csse/services/auth_service.dart';
import 'package:csse/utils/constants.dart';
import 'package:csse/utils/index.dart';
import 'package:csse/views/auth/auth_checker.dart';
import 'package:csse/widgets/main_button.dart';
import 'package:flutter/material.dart';

class NoPermissions extends StatelessWidget {
  const NoPermissions({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            const Spacer(),
            const Text("You dont have permissions for this app"),
            const Spacer(),
            MainButton(
                onPressed: () async {
                  final _authService = AuthService();
                  await _authService.signOutUser();
                  context.navigator(context, const AuthChecker());
                },
                title: "Back")
          ],
        ),
      ),
    );
  }
}
