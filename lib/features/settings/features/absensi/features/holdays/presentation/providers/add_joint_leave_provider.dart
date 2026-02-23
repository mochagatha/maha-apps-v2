import 'package:flutter/material.dart';

class AddJointLeaveProvider extends ChangeNotifier {
  final nameController = TextEditingController();
  final startDateController = TextEditingController();
  final endDateController = TextEditingController();
  
  DateTime? startDate;
  DateTime? endDate;
  bool valid = false;

  void validate() {
    valid = true;
    if (nameController.text.isEmpty) valid = false;
    if (startDate == null) valid = false;
    if (endDate == null) valid = false;
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    startDateController.dispose();
    endDateController.dispose();
  }
}