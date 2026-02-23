import 'package:flutter/material.dart';

class WorkerOvertimeSettingsProvider extends ChangeNotifier {
  final searchController = TextEditingController();
  
  bool _showPercentage = false;

  bool get showPercentage => _showPercentage;

  set showPercentage(bool value) {
    _showPercentage = value;
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
  }
}