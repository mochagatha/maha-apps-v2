import 'package:flutter/material.dart';

class ViewModelSignUp extends ChangeNotifier {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isLoading = false;

  void signUp() {
    if (formKey.currentState!.validate()) {
      isLoading = true;
      notifyListeners();

      // Simulate a network call
      Future.delayed(Duration(seconds: 2), () {
        isLoading = false;
        notifyListeners();
      });
    }
  }
}