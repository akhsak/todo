import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mimo/authentication/controller/auth_controller.dart';
import 'package:mimo/features/task/controller/category_controller.dart';
import 'package:mimo/features/task/controller/task_controller.dart';
import 'package:mimo/features/user/controller/user_controller.dart';
import 'package:mimo/firebase_options.dart';
import 'package:mimo/widgets/splash_page.dart';

import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthController(),
        ),
        ChangeNotifierProvider(
          create: (context) => CategoryController(),
        ),
        ChangeNotifierProvider(
          create: (context) => TaskController(),
        ),
        ChangeNotifierProvider(
          create: (context) => UserController(),
        ),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      ),
    );
  }
}
