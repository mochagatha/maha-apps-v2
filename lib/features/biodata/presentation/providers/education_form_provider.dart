import 'package:flutter/material.dart';

class EducationFormProvider extends ChangeNotifier {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String? lastEducationOption;
  bool isLoadingData = false;

  // Primary School (SD)
  final TextEditingController namePrimarySchoolController = TextEditingController();
  final TextEditingController startYearPrimarySchoolController = TextEditingController();
  final TextEditingController endYearPrimarySchoolController = TextEditingController();

  // Junior High (SMP)
  final TextEditingController nameJuniorSchoolController = TextEditingController();
  final TextEditingController startYearJuniorSchoolController = TextEditingController();
  final TextEditingController endYearJuniorSchoolController = TextEditingController();

  // Senior High (SMA)
  final TextEditingController nameSeniorSchoolController = TextEditingController();
  final TextEditingController startYearSeniorSchoolController = TextEditingController();
  final TextEditingController endYearSeniorSchoolController = TextEditingController();

  // Bachelor (S1/D4)
  final TextEditingController nameBachelorController = TextEditingController();
  final TextEditingController majorBachelorController = TextEditingController();
  final TextEditingController startYearBachelorController = TextEditingController();
  final TextEditingController endYearBachelorController = TextEditingController();
  final TextEditingController ipkBachelorController = TextEditingController();
  final TextEditingController titleBachelorController = TextEditingController();

  // Master (S2)
  final TextEditingController nameMasterController = TextEditingController();
  final TextEditingController majorMasterController = TextEditingController();
  final TextEditingController startYearMasterController = TextEditingController();
  final TextEditingController endYearMasterController = TextEditingController();
  final TextEditingController ipkMasterController = TextEditingController();
  final TextEditingController titleMasterController = TextEditingController();

  // Doctoral (S3)
  final TextEditingController nameDoctorController = TextEditingController();
  final TextEditingController majorDoctorController = TextEditingController();
  final TextEditingController startYearDoctorController = TextEditingController();
  final TextEditingController endYearDoctorController = TextEditingController();
  final TextEditingController ipkDoctorController = TextEditingController();
  final TextEditingController titleDoctorController = TextEditingController();

  final Map<String, String> itemsLastEducation = {
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

  final List<String> educationBachelorValidate = [
    'd i', 'd ii', 'd iii', 's1',
  ];

  void setLastEducation(String? value) {
    lastEducationOption = value;
    notifyListeners();
  }

  // Setters for pickers
  void setYear(TextEditingController controller, String value) {
    controller.text = value;
    notifyListeners();
  }

  void setIPK(TextEditingController controller, String value) {
    controller.text = value;
    notifyListeners();
  }
  
  @override
  void dispose() {
    namePrimarySchoolController.dispose();
    startYearPrimarySchoolController.dispose();
    endYearPrimarySchoolController.dispose();
    nameJuniorSchoolController.dispose();
    startYearJuniorSchoolController.dispose();
    endYearJuniorSchoolController.dispose();
    nameSeniorSchoolController.dispose();
    startYearSeniorSchoolController.dispose();
    endYearSeniorSchoolController.dispose();
    nameBachelorController.dispose();
    majorBachelorController.dispose();
    startYearBachelorController.dispose();
    endYearBachelorController.dispose();
    ipkBachelorController.dispose();
    titleBachelorController.dispose();
    nameMasterController.dispose();
    majorMasterController.dispose();
    startYearMasterController.dispose();
    endYearMasterController.dispose();
    ipkMasterController.dispose();
    titleMasterController.dispose();
    nameDoctorController.dispose();
    majorDoctorController.dispose();
    startYearDoctorController.dispose();
    endYearDoctorController.dispose();
    ipkDoctorController.dispose();
    titleDoctorController.dispose();
    super.dispose();
  }

  Future<void> submit() async {
    if (formKey.currentState?.validate() ?? false) {
       print("Submitting Education Form...");
       // Implement submit logic
    }
  }
}
