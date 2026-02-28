import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/router/app_routes.dart';
import '../../domain/services/biodata_step_manager.dart';
import '../../domain/usecases/submit_skill.dart';

class SkillModel {
  final int id;
  final String name;

  SkillModel({required this.id, required this.name});
}

class SkillProvider extends ChangeNotifier {
  final SubmitSkill submitSkillUseCase;

  SkillProvider({required this.submitSkillUseCase});

  bool isLoadingSkill = false;
  String? errorMessage;

  // Available skills (predefined list for the selection dialog)
  List<SkillModel> availableSkills = [
    SkillModel(id: 1, name: 'Memasak'),
    SkillModel(id: 2, name: 'Bahasa Jerman'),
    SkillModel(id: 3, name: 'Bermain Gitar'),
    SkillModel(id: 4, name: 'Flutter Development'),
    SkillModel(id: 5, name: 'Dart'),
    SkillModel(id: 6, name: 'UI/UX Design'),
    SkillModel(id: 7, name: 'Project Management'),
    SkillModel(id: 8, name: 'Public Speaking'),
  ];

  // User's selected skills (from predefined list)
  List<SkillModel> selectedSkills = [];

  // Manually typed new skills
  List<String> newSkills = [];

  // Skills marked for deletion (if updating existing data)
  List<int> deleteSkillList = [];

  /// All skill names to be submitted (predefined + manually typed)
  List<String> get allSkillNames => [
    ...selectedSkills.map((s) => s.name),
    ...newSkills,
  ];

  Future<void> fetchSkills(String query) async {
    notifyListeners();
  }

  void addSkill(SkillModel skill) {
    if (!selectedSkills.any((s) => s.id == skill.id)) {
      selectedSkills.add(skill);
      notifyListeners();
    }
  }

  void removeSkill(SkillModel skill) {
    selectedSkills.removeWhere((s) => s.id == skill.id);
    deleteSkillList.add(skill.id);
    notifyListeners();
  }

  void addNewSkill(String skillName) {
    if (!newSkills.contains(skillName) && !selectedSkills.any((s) => s.name == skillName)) {
      newSkills.add(skillName);
      notifyListeners();
    }
  }

  void removeNewSkill(String skillName) {
    newSkills.remove(skillName);
    notifyListeners();
  }

  /// Sync selected skills from dialog (replaces current selection)
  void syncSelectedSkills(List<SkillModel> selected, List<String> customSkills) {
    // Track removed predefined skills for deletion list
    for (final existing in selectedSkills) {
      if (!selected.any((s) => s.id == existing.id)) {
        deleteSkillList.add(existing.id);
      }
    }
    selectedSkills = List.from(selected);
    newSkills = List.from(customSkills);
    notifyListeners();
  }

  Future<bool> submit() async {
    // Validate at least one skill is selected
    if (allSkillNames.isEmpty) {
      debugPrint("Validation Error: At least one skill must be selected");
      return false;
    }

    isLoadingSkill = true;
    errorMessage = null;
    notifyListeners();

    try {
      final prefs = await SharedPreferences.getInstance();
      final employeeId = prefs.getInt('employee_id');

      if (employeeId == null) {
        errorMessage = 'Employee ID tidak ditemukan. Silahkan login ulang.';
        isLoadingSkill = false;
        notifyListeners();
        return false;
      }

      final result = await submitSkillUseCase(
        SubmitSkillParams(
          employeeId: employeeId,
          skills: allSkillNames,
        ),
      );

      isLoadingSkill = false;

      return result.fold(
        (failure) {
          errorMessage = _mapFailureToMessage(failure);
          notifyListeners();
          return false;
        },
        (_) {
          debugPrint("Skills submitted successfully: $allSkillNames");
          // Save the next step on success
          BiodataStepManager.setNextStep(AppRoutes.biodataBank.path);
          notifyListeners();
          return true;
        },
      );
    } catch (e) {
      errorMessage = 'Terjadi kesalahan: ${e.toString()}';
      isLoadingSkill = false;
      notifyListeners();
      return false;
    }
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return (failure as ServerFailure).message;
      case NetworkFailure:
        return 'Tidak ada koneksi internet. Periksa koneksi Anda.';
      case CacheFailure:
        return (failure as CacheFailure).message;
      default:
        return 'Terjadi kesalahan yang tidak diketahui.';
    }
  }
}
