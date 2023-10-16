import 'package:csse/providers/add_order_provider.dart';
import 'package:csse/providers/loading_provider.dart';
import 'package:csse/providers/order_provider.dart';
import 'package:csse/providers/site_manager_provider.dart';
import 'package:csse/providers/supplier_provider.dart';
import 'package:csse/providers/user_provider.dart';
import 'package:csse/services/local_prefs.dart';
import 'package:csse/utils/constants.dart';
import 'package:csse/views/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final LocalPreferences localPreferences = LocalPreferences.instance;
  await localPreferences.init();
  !kIsWeb
      ? await Firebase.initializeApp()
      : await Firebase.initializeApp(
          options: const FirebaseOptions(
            apiKey: "AIzaSyDapuYZ_8cJhXxrNd7V3rbcC1EQmAex7qU",
            authDomain: "spm-project-cd3d5.firebaseapp.com",
            projectId: "spm-project-cd3d5",
            storageBucket: "spm-project-cd3d5.appspot.com",
            messagingSenderId: "953427963506",
            appId: "1:953427963506:web:45697c02fbf480a2409ceb",
          ),
        );
  ;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<LoadingProvider>(
          create: (context) => LoadingProvider(),
        ),
        ChangeNotifierProvider<UserProvider>(
          create: (context) => UserProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => SiteManagerProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => SupplierProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => AddOrderProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => OrderProvider(),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(
            appBarTheme: const AppBarTheme(
          backgroundColor: primaryColor,
          centerTitle: false,
        )),
        home: SplashScreen(),
      ),
    );
  }
}
