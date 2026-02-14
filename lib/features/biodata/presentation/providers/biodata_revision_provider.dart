import 'package:flutter/material.dart';

class BiodataRevisionProvider extends ChangeNotifier {
  final nameController = TextEditingController();
  final seniorSchoolNameController = TextEditingController();
  final spouseController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    seniorSchoolNameController.dispose();
    spouseController.dispose();
  }
}