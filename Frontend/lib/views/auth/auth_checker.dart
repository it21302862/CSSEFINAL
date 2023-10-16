import 'package:csse/providers/loading_provider.dart';
import 'package:csse/providers/user_provider.dart';
import 'package:csse/services/auth_service.dart';
import 'package:csse/services/local_prefs.dart';
import 'package:csse/services/site_service.dart';
import 'package:csse/views/auth/home_screen.dart';
import 'package:csse/views/auth/login_screen.dart';
import 'package:csse/views/no_permissions.dart';
import 'package:csse/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

class AuthChecker extends StatefulWidget {
  const AuthChecker({super.key});

  @override
  State<AuthChecker> createState() => _AuthCheckerState();
}

class _AuthCheckerState extends State<AuthChecker> {
  final _localPrefs = LocalPreferences.instance;
  final _authService = AuthService();
  final _siteService = SiteService();
  late LoadingProvider loadingProvider;
  late UserProvider userProvider;
  @override
  void initState() {
    userProvider = Provider.of<UserProvider>(context, listen: false);
    loadingProvider = Provider.of<LoadingProvider>(context, listen: false);
    loadingProvider.updateLoadingState(state: true);
    _authService.getCurrentUser().then((user) {
      if (user != null) {
        userProvider.updateUser(user);
        _siteService.getAllSites(user.id ?? '').then((value) {
          if (value != null) {
            userProvider.setSite(value[0]);
            Logger().d('site setted');
          } else {
            Logger().e('Site not found');
          }
        });
      }
    });
    loadingProvider.updateLoadingState(state: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _localPrefs.getEmail(),
      builder: (context, AsyncSnapshot<String?> snapshot) {
        return snapshot.connectionState == ConnectionState.done
            ? snapshot.data != null
                ? Consumer<UserProvider>(builder: (context, value, child) {
                    return value.user != null
                        ? value.user!.role == 'admin'
                            ? const NoPermissions()
                            : value.user!.role == "site manager"
                                ? const HomeScreen()
                                : Container(
                                    width: double.maxFinite,
                                    height: double.maxFinite,
                                    color: Colors.red,
                                  )
                        : Container(
                            width: double.maxFinite,
                            height: double.maxFinite,
                            color: Colors.green,
                          );
                  })
                : const LoginScreen()
            : const Loading();
      },
    );
  }
}
