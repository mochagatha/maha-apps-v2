import 'package:flutter/material.dart';

class FamilyProvider extends ChangeNotifier {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isLoadingData = false;

  // --- Parent Controllers ---
  final TextEditingController fatherNameController = TextEditingController();
  final TextEditingController fatherAgeController = TextEditingController();
  final TextEditingController fatherJobController = TextEditingController();
  final TextEditingController fatherCompanyController = TextEditingController();

  final TextEditingController motherNameController = TextEditingController();
  final TextEditingController motherAgeController = TextEditingController();
  final TextEditingController motherJobController = TextEditingController();
  final TextEditingController motherCompanyController = TextEditingController();

  String? lifeFatherOption;
  String? lastEducationFatherOption;

  String? lifeMotherOption;
  String? lastEducationMotherOption;

  // --- Married Status Controllers ---
  final TextEditingController coupleNameController = TextEditingController();
  final TextEditingController coupleAgeController = TextEditingController();
  final TextEditingController coupleJobController = TextEditingController();
  final TextEditingController coupleCompanyController = TextEditingController();

  String? statusMarriedOption;
  String? coupleEducationOption;
  String? statusChildOption; // '1': Belum, '2': Sudah

  // --- Siblings Data ---
  List<TextEditingController> nameSiblingControllers = [];
  List<TextEditingController> ageSiblingControllers = [];
  List<TextEditingController> jobSiblingControllers = [];
  List<TextEditingController> companySiblingControllers = [];
  List<String?> educationSiblingOptions = [];
  List<String> genderSiblingControllers = [];
  List<bool> isNewSiblings = [];
  List<Map<String, dynamic>> siblingsData = []; // To store ID or other meta

  // --- Children Data ---
  List<TextEditingController> nameChildrenControllers = [];
  List<TextEditingController> ageChildrenControllers = [];
  List<TextEditingController> jobChildrenControllers = [];
  List<TextEditingController> companyChildrenControllers = [];
  List<String?> educationChildrenOptions = [];
  List<String> genderChildrenControllers = [];
  List<bool> isNewChildren = [];
  List<Map<String, dynamic>> childrenData = []; // To store ID or other meta

  // --- Options Maps ---
  final Map<int, String> itemsMapLife = {1: 'Masih Hidup', 2: 'Sudah Meninggal'};

  final Map<String, String> itemsEducation = {
    'sd': 'SD',
    'smp': 'SMP',
    'sma': 'SMA',
    'd i': 'D I',
    'd ii': 'D II',
    'd iii': 'D III',
    's1': 'D IV/S1',
    's2': 'S2',
    's3': 'S3',
  };

  final Map<String, String> itemsLastEducation = {
    'belum sekolah': 'Belum Sekolah',
    'sd': 'SD',
    'smp': 'SMP',
    'sma': 'SMA',
    'd i': 'D I',
    'd ii': 'D II',
    'd iii': 'D III',
    's1': 'D IV/S1',
    's2': 'S2',
    's3': 'S3',
  };

  final Map<String, String> statusMarriedMap = {
    'belum kawin': 'Belum Menikah',
    'kawin': 'Menikah',
    'janda': 'Janda',
    'duda': 'Duda',
  };

  final Map<String, String> statusChildMap = {'1': 'Belum', '2': 'Sudah'};

  // --- Setters ---
  void setLifeFatherOption(String? value) {
    lifeFatherOption = value;
    notifyListeners();
  }

  void setLastEducationFatherOption(String? value) {
    lastEducationFatherOption = value;
    notifyListeners();
  }

  void setLifeMotherOption(String? value) {
    lifeMotherOption = value;
    notifyListeners();
  }

  void setLastEducationMotherOption(String? value) {
    lastEducationMotherOption = value;
    notifyListeners();
  }

  void setStatusMarriedOption(String? value) {
    statusMarriedOption = value;
    notifyListeners();
  }

  void setCoupleEducationOption(String? value) {
    coupleEducationOption = value;
    notifyListeners();
  }

  void setStatusChildOption(String? value) {
    statusChildOption = value;
    notifyListeners();
  }

  // --- Sibling Logic ---
  void addSibling() {
    nameSiblingControllers.add(TextEditingController());
    ageSiblingControllers.add(TextEditingController());
    jobSiblingControllers.add(TextEditingController());
    companySiblingControllers.add(TextEditingController());
    educationSiblingOptions.add(null);
    genderSiblingControllers.add("L");
    isNewSiblings.add(true);
    // siblingsData.add({}); // Placeholder
    notifyListeners();
  }

  void removeSibling(int index) {
    if (index >= 0 && index < nameSiblingControllers.length) {
      nameSiblingControllers[index].dispose();
      ageSiblingControllers[index].dispose();
      jobSiblingControllers[index].dispose();
      companySiblingControllers[index].dispose();

      nameSiblingControllers.removeAt(index);
      ageSiblingControllers.removeAt(index);
      jobSiblingControllers.removeAt(index);
      companySiblingControllers.removeAt(index);
      educationSiblingOptions.removeAt(index);
      genderSiblingControllers.removeAt(index);
      isNewSiblings.removeAt(index);
      notifyListeners();
    }
  }

  void setSiblingGender(int index, String value) {
    if (index >= 0 && index < genderSiblingControllers.length) {
      genderSiblingControllers[index] = value;
      notifyListeners();
    }
  }

  void setSiblingEducation(int index, String? value) {
    if (index >= 0 && index < educationSiblingOptions.length) {
      educationSiblingOptions[index] = value;
      notifyListeners();
    }
  }

  // --- Children Logic ---
  void addChildren() {
    nameChildrenControllers.add(TextEditingController());
    ageChildrenControllers.add(TextEditingController());
    jobChildrenControllers.add(TextEditingController());
    companyChildrenControllers.add(TextEditingController());
    educationChildrenOptions.add(null);
    genderChildrenControllers.add('L');
    isNewChildren.add(true);
    notifyListeners();
  }

  void removeChildren(int index) {
    if (index >= 0 && index < nameChildrenControllers.length) {
      nameChildrenControllers[index].dispose();
      ageChildrenControllers[index].dispose();
      jobChildrenControllers[index].dispose();
      companyChildrenControllers[index].dispose();

      nameChildrenControllers.removeAt(index);
      ageChildrenControllers.removeAt(index);
      jobChildrenControllers.removeAt(index);
      companyChildrenControllers.removeAt(index);
      educationChildrenOptions.removeAt(index);
      genderChildrenControllers.removeAt(index);
      isNewChildren.removeAt(index);
      notifyListeners();
    }
  }

  void setChildGender(int index, String value) {
    if (index >= 0 && index < genderChildrenControllers.length) {
      genderChildrenControllers[index] = value;
      notifyListeners();
    }
  }

  void setChildEducation(int index, String? value) {
    if (index >= 0 && index < educationChildrenOptions.length) {
      educationChildrenOptions[index] = value;
      notifyListeners();
    }
  }

  Future<bool> submit() async {
    final isFormValid = formKey.currentState?.validate() ?? false;

    if (!isFormValid) {
      return false;
    }

    formKey.currentState?.save();
    debugPrint("Submitting Family Form...");
    // Handle data collection and API submission here
    return true;
  }

  @override
  void dispose() {
    fatherNameController.dispose();
    fatherAgeController.dispose();
    fatherJobController.dispose();
    fatherCompanyController.dispose();

    motherNameController.dispose();
    motherAgeController.dispose();
    motherJobController.dispose();
    motherCompanyController.dispose();

    coupleNameController.dispose();
    coupleAgeController.dispose();
    coupleJobController.dispose();
    coupleCompanyController.dispose();

    for (var c in nameSiblingControllers) c.dispose();
    for (var c in ageSiblingControllers) c.dispose();
    for (var c in jobSiblingControllers) c.dispose();
    for (var c in companySiblingControllers) c.dispose();

    for (var c in nameChildrenControllers) c.dispose();
    for (var c in ageChildrenControllers) c.dispose();
    for (var c in jobChildrenControllers) c.dispose();
    for (var c in companyChildrenControllers) c.dispose();

    super.dispose();
  }
}
