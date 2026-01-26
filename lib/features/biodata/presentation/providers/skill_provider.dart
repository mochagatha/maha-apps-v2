import 'package:flutter/material.dart';

class SkillModel {
  final int id;
  final String name;

  SkillModel({required this.id, required this.name});
}

class SkillProvider extends ChangeNotifier {
  bool isLoadingSkill = false;

  // Available skills (Mocked or loaded from API)
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

  // User's selected skills
  List<SkillModel> selectedSkills = [];

  // Skills to be added (User inputs manual string?)
  // v1 had 'addSkillList' as List<String>.
  // v1 dialog seems to allow searching and selecting existing skills.
  List<String> newSkills = [];

  // Skills marked for deletion (if updating existing data)
  List<int> deleteSkillList = [];

  Future<void> fetchSkills(String query) async {
    // Simulate API call or filtering
    // In real app, this would call UseCase
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

  Future<bool> submit() async {
    // Validate at least one skill is selected
    if (selectedSkills.isEmpty) {
      debugPrint("Validation Error: At least one skill must be selected");
      return false;
    }

    isLoadingSkill = true;
    notifyListeners();

    // Simulate submit
    await Future.delayed(const Duration(seconds: 1));

    isLoadingSkill = false;
    notifyListeners();

    debugPrint("Submitting Skills: ${selectedSkills.map((s) => s.name).toList()}");
    return true;
  }
}
