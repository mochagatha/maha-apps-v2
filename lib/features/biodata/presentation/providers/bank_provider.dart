import 'package:flutter/material.dart';
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
      name: "BSI",
    ),
    Bank(
      id: 3,
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

    // implement submit
    await Future.delayed(Duration(seconds: 1));

    return null;
  }
}
