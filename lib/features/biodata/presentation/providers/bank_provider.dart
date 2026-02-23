import 'package:flutter/material.dart';

import '../../../../core/router/app_routes.dart';
import '../../domain/services/biodata_step_manager.dart';
import 'package:maha_apps_v2/features/biodata/domain/entities/bank.dart';

class BankProvider extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();
  final accountNumberController = TextEditingController();
  final accountNameController = TextEditingController();

  List<Bank> _banks = [
    Bank(
      id: 1,
      name: "Bank Mandiri 1",
    ),
    Bank(
      id: 2,
      name: "Bank Mandiri 2",
    ),
    Bank(
      id: 3,
      name: "BSI",
    ),
    Bank(
      id: 4,
      name: "BCA",
    ),
  ];
  Bank? _selectedBank;

  List<Bank> get banks => _banks;
  Bank? get selectedBank => _selectedBank;

  set selectedBank(Bank? bank) {
    _selectedBank = bank;
    notifyListeners();
  }

  Bank bankFromId(int id) {
    return _banks.firstWhere((bank) => bank.id == id);
  }

  Future<String?> submit() async {
    if (!(formKey.currentState?.validate() ?? false) || _selectedBank == null) {
      return "Data ada yang kosong!";
    }

    await Future.delayed(Duration(seconds: 1));

    // Save the next step on success
    BiodataStepManager.setNextStep(AppRoutes.selfieForm.path);

    return null;
  }
}
