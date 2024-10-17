import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:techtrove_admin/provider/app_provider.dart';
import 'package:techtrove_admin/screens/home_page.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  await dotenv.load();
  WidgetsFlutterBinding.ensureInitialized();
  try {
    final apikkey = dotenv.env["API_KEY"] ?? "";
    //firebase was returning a null value, so this helped to solve the problem;
    Platform.isAndroid
        ? await Firebase.initializeApp(
            options: FirebaseOptions(
              apiKey: apikkey,
              appId: "1:973121984053:android:eb57c772b96d8a919b437c",
              messagingSenderId: "973121984053",
              projectId: "tech-trove-shop-3ea50",
              storageBucket: "tech-trove-shop-3ea50.appspot.com",
            ),
          )
        : await Firebase.initializeApp();
  } catch (_) {}
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AppProvider>(
      create: (context) => AppProvider(),
      child: MaterialApp(
          debugShowCheckedModeBanner:
              false, // for removing the debug banner in the screen of the app;
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: const HomePage()),
    );
  }
}
