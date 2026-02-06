import 'package:flutter/material.dart';
import 'package:maha_apps_v2/core/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EducationFormProvider extends ChangeNotifier {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String? lastEducationOption;
  bool isLoadingData = false;

  // Primary School (SD)
  final TextEditingController namePrimarySchoolController =
      TextEditingController();
  final TextEditingController startYearPrimarySchoolController =
      TextEditingController();
  final TextEditingController endYearPrimarySchoolController =
      TextEditingController();

  // Junior High (SMP)
  final TextEditingController nameJuniorSchoolController =
      TextEditingController();
  final TextEditingController startYearJuniorSchoolController =
      TextEditingController();
  final TextEditingController endYearJuniorSchoolController =
      TextEditingController();

  // Senior High (SMA)
  final TextEditingController nameSeniorSchoolController =
      TextEditingController();
  final TextEditingController startYearSeniorSchoolController =
      TextEditingController();
  final TextEditingController endYearSeniorSchoolController =
      TextEditingController();

  // Bachelor (S1/D4)
  final TextEditingController nameBachelorController = TextEditingController();
  final TextEditingController majorBachelorController = TextEditingController();
  final TextEditingController startYearBachelorController =
      TextEditingController();
  final TextEditingController endYearBachelorController =
      TextEditingController();
  final TextEditingController ipkBachelorController = TextEditingController();
  final TextEditingController titleBachelorController = TextEditingController();

  // Master (S2)
  final TextEditingController nameMasterController = TextEditingController();
  final TextEditingController majorMasterController = TextEditingController();
  final TextEditingController startYearMasterController =
      TextEditingController();
  final TextEditingController endYearMasterController = TextEditingController();
  final TextEditingController ipkMasterController = TextEditingController();
  final TextEditingController titleMasterController = TextEditingController();

  // Doctoral (S3)
  final TextEditingController nameDoctorController = TextEditingController();
  final TextEditingController majorDoctorController = TextEditingController();
  final TextEditingController startYearDoctorController =
      TextEditingController();
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

  final List<String> educationBachelorValidate = ['d i', 'd ii', 'd iii', 's1'];

  void setLastEducation(String? value) async {
    lastEducationOption = value;
    final prefs = await SharedPreferences.getInstance();
    if (value != null) {
      prefs.setString(AppConstants.biodata.lastEducation, value);
    }
    notifyListeners();
  }

  // Setters for pickers
  void setYear(
    TextEditingController controller,
    String value,
    String prefKey,
  ) async {
    controller.text = value;
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(prefKey, value);
    notifyListeners();
  }

  void setIPK(
    TextEditingController controller,
    String value,
    String prefKey,
  ) async {
    controller.text = value;
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(prefKey, value);
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

  Future<void> initialize() async {
    final prefs = await SharedPreferences.getInstance();
    final lastEducation = prefs.getString(AppConstants.biodata.lastEducation);
    final namePrimarySchool = prefs.getString(
      AppConstants.biodata.namePrimarySchool,
    );
    final startYearPrimarySchool = prefs.getString(
      AppConstants.biodata.startYearPrimarySchool,
    );
    final endYearPrimarySchool = prefs.getString(
      AppConstants.biodata.endYearPrimarySchool,
    );
    final nameJuniorSchool = prefs.getString(
      AppConstants.biodata.nameJuniorSchool,
    );
    final startYearJuniorSchool = prefs.getString(
      AppConstants.biodata.startYearJuniorSchool,
    );
    final endYearJuniorSchool = prefs.getString(
      AppConstants.biodata.endYearJuniorSchool,
    );
    final nameSeniorSchool = prefs.getString(
      AppConstants.biodata.nameSeniorSchool,
    );
    final startYearSeniorSchool = prefs.getString(
      AppConstants.biodata.startYearSeniorSchool,
    );
    final endYearSeniorSchool = prefs.getString(
      AppConstants.biodata.endYearSeniorSchool,
    );
    final nameBachelor = prefs.getString(AppConstants.biodata.nameBachelor);
    final majorBachelor = prefs.getString(AppConstants.biodata.majorBachelor);
    final startYearBachelor = prefs.getString(
      AppConstants.biodata.startYearBachelor,
    );
    final endYearBachelor = prefs.getString(
      AppConstants.biodata.endYearBachelor,
    );
    final ipkBachelor = prefs.getString(AppConstants.biodata.ipkBachelor);
    final titleBachelor = prefs.getString(AppConstants.biodata.titleBachelor);
    final nameMaster = prefs.getString(AppConstants.biodata.nameMaster);
    final majorMaster = prefs.getString(AppConstants.biodata.majorMaster);
    final startYearMaster = prefs.getString(
      AppConstants.biodata.startYearMaster,
    );
    final endYearMaster = prefs.getString(AppConstants.biodata.endYearMaster);
    final ipkMaster = prefs.getString(AppConstants.biodata.ipkMaster);
    final titleMaster = prefs.getString(AppConstants.biodata.titleMaster);
    final nameDoctor = prefs.getString(AppConstants.biodata.nameDoctor);
    final majorDoctor = prefs.getString(AppConstants.biodata.majorDoctor);
    final startYearDoctor = prefs.getString(
      AppConstants.biodata.startYearDoctor,
    );
    final endYearDoctor = prefs.getString(AppConstants.biodata.endYearDoctor);
    final ipkDoctor = prefs.getString(AppConstants.biodata.ipkDoctor);
    final titleDoctor = prefs.getString(AppConstants.biodata.titleDoctor);

    lastEducationOption = lastEducation;
    namePrimarySchoolController.text = namePrimarySchool ?? "";
    startYearPrimarySchoolController.text = startYearPrimarySchool ?? "";
    endYearPrimarySchoolController.text = endYearPrimarySchool ?? "";
    nameJuniorSchoolController.text = nameJuniorSchool ?? "";
    startYearJuniorSchoolController.text = startYearJuniorSchool ?? "";
    endYearJuniorSchoolController.text = endYearJuniorSchool ?? "";
    nameSeniorSchoolController.text = nameSeniorSchool ?? "";
    startYearSeniorSchoolController.text = startYearSeniorSchool ?? "";
    endYearSeniorSchoolController.text = endYearSeniorSchool ?? "";
    nameBachelorController.text = nameBachelor ?? "";
    majorBachelorController.text = majorBachelor ?? "";
    startYearBachelorController.text = startYearBachelor ?? "";
    endYearBachelorController.text = endYearBachelor ?? "";
    ipkBachelorController.text = ipkBachelor ?? "";
    titleBachelorController.text = titleBachelor ?? "";
    nameMasterController.text = nameMaster ?? "";
    majorMasterController.text = majorMaster ?? "";
    startYearMasterController.text = startYearMaster ?? "";
    endYearMasterController.text = endYearMaster ?? "";
    ipkMasterController.text = ipkMaster ?? "";
    titleMasterController.text = titleMaster ?? "";
    nameDoctorController.text = nameDoctor ?? "";
    majorDoctorController.text = majorDoctor ?? "";
    startYearDoctorController.text = startYearDoctor ?? "";
    endYearDoctorController.text = endYearDoctor ?? "";
    ipkDoctorController.text = ipkDoctor ?? "";
    titleDoctorController.text = titleDoctor ?? "";

    notifyListeners();
  }

  Future<String?> submit() async {
    final isFormValid = formKey.currentState?.validate() ?? false;

    if (!isFormValid) {
      return "Ada data yang kosong!";
    }

    formKey.currentState?.save();
    debugPrint("Submitting Education Form...");
    // Implement submit logic
    return null;
  }
}
