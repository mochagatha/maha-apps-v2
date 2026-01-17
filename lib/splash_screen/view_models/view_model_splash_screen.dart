import 'package:flutter/material.dart';

import '../services/splash_screen_service.dart';

class ViewModelSplashScreen extends ChangeNotifier {
  final api = SplashScreenService();
  bool isLoading = false;
  final int gifDuration = 7000;

  Future<void> getSplashScreen() async {
    isLoading = true;
    notifyListeners();

    try {
      isLoading = true;
      // contoh API
      // await Future.delayed(Duration(seconds: 2));
      // await api.getOvertimeByEmployee();

      isLoading = false;
      notifyListeners();
    } catch (_) {
      // isLoading = false;
      notifyListeners();
    }
  }

  Future<void> playGif() async {
    await Future.delayed(Duration(milliseconds: gifDuration));
  }

  //  Future<void> getSplashScreen() async {
  //   isLoading = true;
  //   notifyListeners();

  //   await Future.delayed(Duration(seconds: 3)); // simulasi API

  //   isLoading = false;
  //   notifyListeners();
  // }

  // /// durasi "gif" atau video loop
  // Future<void> playGif() async {
  //   await Future.delayed(Duration(milliseconds: 2500));
  // }
}
