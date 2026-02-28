import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/router/app_routes.dart';
import '../../../../core/usecases/usecase.dart';
import '../../domain/entities/bank.dart';
import '../../domain/services/biodata_step_manager.dart';
import '../../domain/usecases/get_banks.dart';
import '../../domain/usecases/submit_bank.dart';

class BankProvider extends ChangeNotifier {
  final GetBanks getBanksUseCase;
  final SubmitBank submitBankUseCase;

  BankProvider({
    required this.getBanksUseCase,
    required this.submitBankUseCase,
  });

  final formKey = GlobalKey<FormState>();
  final accountNumberController = TextEditingController();
  final accountNameController = TextEditingController();

  List<Bank> _banks = [];
  Bank? _selectedBank;
  bool _loadingBanks = false;
  String? _loadBanksError;

  List<Bank> get banks => _banks;
  Bank? get selectedBank => _selectedBank;
  bool get loadingBanks => _loadingBanks;
  String? get loadBanksError => _loadBanksError;

  set selectedBank(Bank? bank) {
    _selectedBank = bank;
    notifyListeners();
  }

  Bank bankFromId(int id) {
    return _banks.firstWhere((bank) => bank.id == id);
  }

  Future<void> loadBanks() async {
    _loadingBanks = true;
    _loadBanksError = null;
    notifyListeners();

    final result = await getBanksUseCase(const NoParams());

    result.fold(
      (failure) {
        _loadBanksError = failure.message;
        _loadingBanks = false;
        notifyListeners();
      },
      (banks) {
        _banks = banks;
        _loadingBanks = false;
        notifyListeners();
      },
    );
  }

  Future<String?> submit() async {
    if (!(formKey.currentState?.validate() ?? false) || _selectedBank == null) {
      return "Data ada yang kosong!";
    }

    final prefs = await SharedPreferences.getInstance();
    final employeeId = prefs.getInt('employee_id') ?? 0;

    final result = await submitBankUseCase(
      SubmitBankParams(
        employeeId: employeeId,
        bankId: _selectedBank!.id,
        accountNumber: accountNumberController.text,
        accountName: accountNameController.text,
      ),
    );

    return result.fold(
      (failure) => failure.message,
      (_) {
        BiodataStepManager.setNextStep(AppRoutes.selfieForm.path);
        return null;
      },
    );
  }
}
