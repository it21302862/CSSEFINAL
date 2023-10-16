import 'package:csse/providers/loading_provider.dart';
import 'package:csse/providers/user_provider.dart';
import 'package:csse/services/auth_service.dart';
import 'package:csse/utils/constants.dart';
import 'package:csse/utils/index.dart';
import 'package:csse/views/auth/auth_checker.dart';
import 'package:csse/views/auth/signup_screen.dart';
import 'package:csse/widgets/CustomTitle.dart';
import 'package:csse/widgets/input_field.dart';
import 'package:csse/widgets/loading_wrapper.dart';
import 'package:csse/widgets/main_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordControlller = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final _loadingProvider =
        Provider.of<LoadingProvider>(context, listen: false);
    final _userProvider = Provider.of<UserProvider>(context);
    return LoadingWrapper(
      secondScreen: Scaffold(
        body: Container(
          padding: const EdgeInsets.all(defaultPadding),
          height: MediaQuery.of(context).size.height,
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                const SizedBox(
                  height: kToolbarHeight,
                ),
                const CustomTitle(title: "Login"),
                const SizedBox(
                  height: 64,
                ),
                CustomInputField(
                  label: 'Email',
                  hint: "Email",
                  controller: _emailController,
                  validatingMessage: "Email is required",
                  prefixIcon: const Icon(Icons.email),
                ),
                CustomInputField(
                  label: 'Password',
                  hint: "Password",
                  controller: _passwordControlller,
                  isPassword: true,
                  validatingMessage: "Password is required",
                  prefixIcon: const Icon(Icons.password),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextButton(
                        onPressed: () {},
                        child: const Text(
                          'Forgot password?',
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                              color: Color(0xFF185DCF)),
                        ))
                  ],
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account?"),
                    TextButton(
                      onPressed: () {
                        context.navigator(context, const SignupScreen());
                      },
                      child: const Text(
                        "Signup Now",
                        style: TextStyle(
                          color: primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
                MainButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      _loadingProvider.updateLoadingState(state: true);
                      try {
                        await AuthService()
                            .signinWithEmailAndPassword(_emailController.text,
                                _passwordControlller.text)
                            .then((value) async {
                          await AuthService().getCurrentUser().then((value) {
                            if (value != null) {
                              _userProvider.updateUser(value);
                              context.navigator(
                                context,
                                const AuthChecker(),
                                shouldBack: false,
                              );
                            }
                          });
                        });
                      } catch (e) {
                        await AuthService().signOutUser().then((value) {
                          context.showSnackBar(e.toString());
                        });
                      }
                      _loadingProvider.updateLoadingState(state: true);
                    }
                  },
                  title: "Login",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
