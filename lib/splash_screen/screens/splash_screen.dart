import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../sign_in/screens/sign_in.dart';
import '../view_models/view_model_splash_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late ViewModelSplashScreen viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = Provider.of<ViewModelSplashScreen>(context, listen: false);
    startSplashFlow();
  }

  void startSplashFlow() async {
    viewModel.getSplashScreen();

    while (mounted) {
      await viewModel.playGif();
      if (viewModel.isLoading == false) {
        if (!mounted) return;

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => SignInScreen()),
        );
        break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Lottie.asset(
          'assets/splash_modified.json',
          // width: 320,
          // height: 220,
          // fit: BoxFit.contain,
          repeat: true,
        ),
      ),
    );
  }
}
