import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BiodataFormProvider extends ChangeNotifier {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // Text Controllers
  final TextEditingController nameController = TextEditingController();
  final TextEditingController nicknameController = TextEditingController();
  final TextEditingController nikController = TextEditingController();
  
  // Identity Address
  final TextEditingController postalCodeController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  
  // Domicile Address
  final TextEditingController postalCodeDomController = TextEditingController();
  final TextEditingController addressDomController = TextEditingController();
  
  // Contacts
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emergencyPhoneController = TextEditingController();
  
  // Birth
  final TextEditingController birthPlaceController = TextEditingController();
  final TextEditingController birthDateController = TextEditingController();

  // State Variables
  String? selectedProvince;
  String? selectedRegency;
  String? selectedDistrict;
  String? selectedVillage;

  String? selectedProvinceDom;
  String? selectedRegencyDom;
  String? selectedDistrictDom;
  String? selectedVillageDom;

  String? selectedGender = 'L'; // Default L
  String? selectedReligion;
  String? selectedResidenceStatus; // addressOption
  
  bool isSwitchOn = false; // "Alamat saat ini sama dengan KTP"
  
  // Loading States
  bool isLoadingRegency = false;
  bool isLoadingDistrict = false;
  bool isLoadingVillage = false;

  bool isLoadingRegencyDom = false;
  bool isLoadingDistrictDom = false;
  bool isLoadingVillageDom = false;
  bool isLoadingData = false;

  // Mock Data Maps (To be replaced with API calls)
  final Map<String, String> itemsMapAddress = {
    'kost': 'Kost',
    'Rumah kontrakan': 'Rumah Kontrakan',
    'Rumah sendiri': 'Rumah Sendiri',
    'Rumah orang tua': 'Rumah Orang Tua',
  };

  final Map<String, String> itemsMapReligi = {
    'islam': 'Islam',
    'kristen': 'Kristen',
    'hindu': 'Hindu',
    'buddha': 'Buddha',
    'konghucu': 'Konghucu',
  };

  // Mock Region Data
  final Map<String, String> provinces = {'1': 'Jawa Barat', '2': 'Jawa Tengah', '3': 'DKI Jakarta'};
  final Map<String, String> regencies = {'1': 'Bandung', '2': 'Bogor'};
  final Map<String, String> districts = {'1': 'Coblong', '2': 'Dago'};
  final Map<String, String> villages = {'1': 'Dago Atas', '2': 'Dago Bawah'};


  // Methods
  void toggleSwitch(bool value) {
    isSwitchOn = value;
    notifyListeners();
  }

  void setGender(String value) {
    selectedGender = value;
    notifyListeners();
  }

  void setReligion(String? value) {
    selectedReligion = value;
    notifyListeners();
  }
  
  void setResidenceStatus(String? value) {
    selectedResidenceStatus = value;
    notifyListeners();
  }

  // Region Handlers (Identity)
  void setProvince(String? value) {
    selectedProvince = value;
    selectedRegency = null;
    selectedDistrict = null;
    selectedVillage = null;
    notifyListeners();
    // if (value != null) _fetchRegencies(value);
  }

  void setRegency(String? value) {
    selectedRegency = value;
    selectedDistrict = null;
    selectedVillage = null;
    notifyListeners();
    // if (value != null) _fetchDistricts(value);
  }

  void setDistrict(String? value) {
    selectedDistrict = value;
    selectedVillage = null;
    notifyListeners();
    // if (value != null) _fetchVillages(value);
  }

  void setVillage(String? value) {
    selectedVillage = value;
    notifyListeners();
  }

  // Region Handlers (Domicile)
  void setProvinceDom(String? value) {
    selectedProvinceDom = value;
    selectedRegencyDom = null;
    selectedDistrictDom = null;
    selectedVillageDom = null;
    notifyListeners();
  }

  void setRegencyDom(String? value) {
    selectedRegencyDom = value;
    selectedDistrictDom = null;
    selectedVillageDom = null;
    notifyListeners();
  }

  void setDistrictDom(String? value) {
    selectedDistrictDom = value;
    selectedVillageDom = null;
    notifyListeners();
  }
  
  void setVillageDom(String? value) {
    selectedVillageDom = value;
    notifyListeners();
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      birthDateController.text = DateFormat.yMMMMd('id').format(picked);
      notifyListeners();
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    nicknameController.dispose();
    nikController.dispose();
    postalCodeController.dispose();
    addressController.dispose();
    postalCodeDomController.dispose();
    addressDomController.dispose();
    phoneController.dispose();
    emergencyPhoneController.dispose();
    birthPlaceController.dispose();
    birthDateController.dispose();
    super.dispose();
  }
  
  Future<void> submit() async {
    if (formKey.currentState?.validate() ?? false) {
      formKey.currentState?.save();
      // Logic from _submitForm in v1
      // final currentProvince = isSwitchOn ? selectedProvince! : selectedProvinceDom!;
      // ... construct model and send to API
      print("Submitting Form...");
    }
  }
}
