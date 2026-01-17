import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'sign_in/view_models/view_model_sign_in.dart';
import 'sign_up/view_models/view_model_sign_up.dart';
import 'splash_screen/screens/splash_screen.dart';
import 'splash_screen/view_models/view_model_splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ViewModelSplashScreen()),
        ChangeNotifierProvider(create: (_) => ViewModelSignIn()),
        ChangeNotifierProvider(create: (_) => ViewModelSignUp()),
      ],
      child: SafeArea(
        top: false,
        child: MaterialApp(
          theme: ThemeData(
            textTheme: GoogleFonts.poppinsTextTheme(
              Theme.of(context).textTheme,
            ),
          ),
          debugShowCheckedModeBanner: false,
          home: const SplashScreen(),
        ),
      ),
    );
  }
}
