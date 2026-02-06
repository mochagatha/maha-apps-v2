import 'package:flutter/material.dart';

class EmploymentAgreementProvider extends ChangeNotifier {
  Future<String?> submit() async {
    // implement submit
    await Future.delayed(Duration(seconds: 1));
    return null;
  }
}