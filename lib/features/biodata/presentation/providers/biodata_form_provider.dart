import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../domain/entities/region.dart';
import '../../domain/repositories/biodata_repository.dart';
// For easier access if needed, but better passed in

class BiodataFormProvider extends ChangeNotifier {
  final BiodataRepository repository;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  BiodataFormProvider({required this.repository}) {
    fetchProvinces(); // Auto fetch on create
  }

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

  // State Variables - now using model objects
  dynamic selectedProvince;
  dynamic selectedRegency;
  dynamic selectedDistrict;
  dynamic selectedVillage;

  dynamic selectedProvinceDom;
  dynamic selectedRegencyDom;
  dynamic selectedDistrictDom;
  dynamic selectedVillageDom;

  String? selectedGender = 'L'; // Default L
  String? selectedReligion;
  String? selectedResidenceStatus; // addressOption

  bool isSwitchOn = false; // "Alamat saat ini sama dengan KTP"

  // Error message for gender field (others use form validators)
  String? genderError;

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

  // Region Data - now using List instead of Map
  List<Province> provinces = [];
  List<Regency> regencies = [];
  List<District> districts = [];
  List<Village> villages = [];

  List<Province> provincesDom = [];
  List<Regency> regenciesDom = [];
  List<District> districtsDom = [];
  List<Village> villagesDom = [];

  // Methods
  void toggleSwitch(bool value) {
    isSwitchOn = value;
    notifyListeners();
  }

  void setGender(String value) {
    selectedGender = value;
    genderError = null; // Clear error when user selects
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
  void setProvince(dynamic value) {
    selectedProvince = value;
    selectedRegency = null;
    selectedDistrict = null;
    selectedVillage = null;
    regencies = [];
    districts = [];
    villages = [];
    notifyListeners();
    if (value != null) fetchRegencies(value.id.toString());
  }

  void setRegency(dynamic value) {
    selectedRegency = value;
    selectedDistrict = null;
    selectedVillage = null;
    districts = [];
    villages = [];
    notifyListeners();
    if (value != null) fetchDistricts(value.id.toString());
  }

  void setDistrict(dynamic value) {
    selectedDistrict = value;
    selectedVillage = null;
    villages = [];
    notifyListeners();
    if (value != null) fetchVillages(value.id.toString());
  }

  void setVillage(dynamic value) {
    selectedVillage = value;
    notifyListeners();
  }

  // Region Handlers (Domicile)
  void setProvinceDom(dynamic value) {
    selectedProvinceDom = value;
    selectedRegencyDom = null;
    selectedDistrictDom = null;
    selectedVillageDom = null;
    regenciesDom = [];
    districtsDom = [];
    villagesDom = [];
    notifyListeners();
    if (value != null) fetchRegencies(value.id.toString(), isDom: true);
  }

  void setRegencyDom(dynamic value) {
    selectedRegencyDom = value;
    selectedDistrictDom = null;
    selectedVillageDom = null;
    districtsDom = [];
    villagesDom = [];
    notifyListeners();
    if (value != null) fetchDistricts(value.id.toString(), isDom: true);
  }

  void setDistrictDom(dynamic value) {
    selectedDistrictDom = value;
    selectedVillageDom = null;
    villagesDom = [];
    notifyListeners();
    if (value != null) fetchVillages(value.id.toString(), isDom: true);
  }

  void setVillageDom(dynamic value) {
    selectedVillageDom = value;
    notifyListeners();
  }

  // --- Fetch Methods ---
  Future<void> fetchProvinces() async {
    final result = await repository.getProvinces();
    result.fold((failure) => print('Error fetching provinces: ${failure.message}'), (data) {
      provinces = data;
      provincesDom = data; // Same data
      notifyListeners();
    });
  }

  Future<void> fetchRegencies(String provinceId, {bool isDom = false}) async {
    if (isDom) {
      isLoadingRegencyDom = true;
      notifyListeners();
    } else {
      isLoadingRegency = true;
      notifyListeners();
    }

    final result = await repository.getRegencies(provinceId);

    result.fold((failure) => print('Error fetching regencies: ${failure.message}'), (data) {
      if (isDom) {
        regenciesDom = data;
        isLoadingRegencyDom = false;
      } else {
        regencies = data;
        isLoadingRegency = false;
      }
      notifyListeners();
    });
  }

  Future<void> fetchDistricts(String regencyId, {bool isDom = false}) async {
    if (isDom) {
      isLoadingDistrictDom = true;
      notifyListeners();
    } else {
      isLoadingDistrict = true;
      notifyListeners();
    }

    final result = await repository.getDistricts(regencyId);
    result.fold((failure) => print('Error fetching districts: ${failure.message}'), (data) {
      if (isDom) {
        districtsDom = data;
        isLoadingDistrictDom = false;
      } else {
        districts = data;
        isLoadingDistrict = false;
      }
      notifyListeners();
    });
  }

  Future<void> fetchVillages(String districtId, {bool isDom = false}) async {
    if (isDom) {
      isLoadingVillageDom = true;
      notifyListeners();
    } else {
      isLoadingVillage = true;
      notifyListeners();
    }

    final result = await repository.getVillages(districtId);
    result.fold((failure) => print('Error fetching villages: ${failure.message}'), (data) {
      if (isDom) {
        villagesDom = data;
        isLoadingVillageDom = false;
      } else {
        villages = data;
        isLoadingVillage = false;
      }
      notifyListeners();
    });
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

  Future<bool> submit() async {
    // Clear previous errors
    genderError = null;

    // Validate form fields (includes all TextFormField and DropdownButtonFormField validators)
    final isFormValid = formKey.currentState?.validate() ?? false;

    bool hasErrors = false;

    // Additional validation for gender radio button (not covered by form validators)
    if (selectedGender == null || selectedGender!.isEmpty) {
      genderError = "Jenis kelamin harus dipilih";
      hasErrors = true;
      notifyListeners(); // Notify to show error message
    }

    if (!isFormValid || hasErrors) {
      return false;
    }

    formKey.currentState?.save();
    // Logic from _submitForm in v1
    // final currentProvince = isSwitchOn ? selectedProvince! : selectedProvinceDom!;
    // ... construct model and send to API
    debugPrint("Submitting Form...");
    return true;
  }
}
