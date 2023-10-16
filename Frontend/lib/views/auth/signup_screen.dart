import 'package:csse/providers/loading_provider.dart';
import 'package:csse/services/auth_service.dart';
import 'package:csse/utils/constants.dart';
import 'package:csse/utils/index.dart';
import 'package:csse/views/auth/home_screen.dart';
import 'package:csse/widgets/input_field.dart';
import 'package:csse/widgets/loading_wrapper.dart';
import 'package:csse/widgets/main_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController name = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final _key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final _loadingProvider = Provider.of<LoadingProvider>(context);
    return LoadingWrapper(
      secondScreen: Scaffold(
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          reverse: true,
          child: Form(
            key: _key,
            child: Column(
              children: [
                Image.asset("assets/logo.jpg"),
                CustomInputField(
                  label: "Name",
                  hint: "Name",
                  controller: name,
                ),
                CustomInputField(
                  label: "Email",
                  hint: "Email",
                  controller: email,
                ),
                CustomInputField(
                  label: "Password",
                  hint: "Password",
                  controller: password,
                  isPassword: true,
                ),
                MainButton(
                  onPressed: () async {
                    _loadingProvider.updateLoadingState(state: true);
                    if (_key.currentState!.validate()) {
                      try {
                        await AuthService()
                            .signupUser(email.text, password.text, name.text);
                        context.navigator(context, HomeScreen(),
                            shouldBack: false);
                      } catch (e) {
                        context.showSnackBar('$e');
                      }
                    }
                    _loadingProvider.updateLoadingState(state: false);
                  },
                  title: "Signup",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  InkWell rolePickerButton(VoidCallback onTap, String title, bool shouldShow) {
    return InkWell(
      onTap: onTap,
      child: AnimatedContainer(
        decoration: BoxDecoration(
          border: !shouldShow
              ? const Border(
                  bottom: BorderSide(
                  color: primaryColor,
                  width: 2,
                ))
              : null,
        ),
        duration: defaultDuration,
        child: Text(
          title,
        ),
      ),
    );
  }
}
