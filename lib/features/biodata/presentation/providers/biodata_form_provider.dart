import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:maha_apps_v2/core/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  final TextEditingController emergencyPhoneController =
      TextEditingController();

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
  void toggleSwitch(bool value) async {
    isSwitchOn = value;
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(AppConstants.biodata.sameCurrentAddress, value);
    notifyListeners();
  }

  void setGender(String value) async {
    selectedGender = value;
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(AppConstants.biodata.gender, value);
    genderError = null; // Clear error when user selects
    notifyListeners();
  }

  void setReligion(String? value) async {
    selectedReligion = value;
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(AppConstants.biodata.religion, value!);
    notifyListeners();
  }

  void setResidenceStatus(String? value) async {
    selectedResidenceStatus = value;
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(AppConstants.biodata.residenceStatus, value!);
    notifyListeners();
  }

  // Region Handlers (Identity)
  Future<void> setProvince(dynamic value, {bool render = true}) async {
    selectedProvince = value;
    selectedRegency = null;
    selectedDistrict = null;
    selectedVillage = null;
    regencies = [];
    districts = [];
    villages = [];
    if (value != null) {
      await fetchRegencies(value.id.toString(), render: render);
    }
  }

  Future<void> setRegency(dynamic value, {bool render = true}) async {
    selectedRegency = value;
    selectedDistrict = null;
    selectedVillage = null;
    districts = [];
    villages = [];
    if (value != null) {
      await fetchDistricts(value.id.toString(), render: render);
    }
  }

  Future<void> setDistrict(dynamic value, {bool render = true}) async {
    selectedDistrict = value;
    selectedVillage = null;
    villages = [];
    if (value != null) await fetchVillages(value.id.toString(), render: render);
  }

  void setVillage(dynamic value, {bool render = true}) {
    selectedVillage = value;
    if (render) notifyListeners();
  }

  // Region Handlers (Domicile)
  Future<void> setProvinceDom(dynamic value, {bool render = true}) async {
    selectedProvinceDom = value;
    selectedRegencyDom = null;
    selectedDistrictDom = null;
    selectedVillageDom = null;
    regenciesDom = [];
    districtsDom = [];
    villagesDom = [];
    if (render) notifyListeners();
    if (value != null) {
      await fetchRegencies(value.id.toString(), isDom: true, render: render);
    }
  }

  Future<void> setRegencyDom(dynamic value, {bool render = true}) async {
    selectedRegencyDom = value;
    selectedDistrictDom = null;
    selectedVillageDom = null;
    districtsDom = [];
    villagesDom = [];
    if (render) notifyListeners();
    if (value != null) {
      await fetchDistricts(value.id.toString(), isDom: true, render: render);
    }
  }

  Future<void> setDistrictDom(dynamic value, {bool render = true}) async {
    selectedDistrictDom = value;
    selectedVillageDom = null;
    villagesDom = [];
    if (render) notifyListeners();
    if (value != null) {
      await fetchVillages(value.id.toString(), isDom: true, render: render);
    }
  }

  void setVillageDom(dynamic value, {bool render = true}) {
    selectedVillageDom = value;
    if (render) notifyListeners();
  }

  // --- Fetch Methods ---
  Future<void> fetchProvinces({bool render = true}) async {
    final result = await repository.getProvinces();
    result.fold(
      (failure) => print('Error fetching provinces: ${failure.message}'),
      (data) {
        provinces = data;
        provincesDom = data; // Same data
        if (render) notifyListeners();
      },
    );
  }

  Future<void> fetchRegencies(
    String provinceId, {
    bool isDom = false,
    bool render = true,
  }) async {
    if (isDom) {
      isLoadingRegencyDom = true;
    } else {
      isLoadingRegency = true;
    }
    if (render) notifyListeners();

    final result = await repository.getRegencies(provinceId);

    result.fold(
      (failure) => print('Error fetching regencies: ${failure.message}'),
      (data) {
        if (isDom) {
          regenciesDom = data;
          isLoadingRegencyDom = false;
        } else {
          regencies = data;
          isLoadingRegency = false;
        }
        if (render) notifyListeners();
      },
    );
  }

  Future<void> fetchDistricts(
    String regencyId, {
    bool isDom = false,
    bool render = true,
  }) async {
    if (isDom) {
      isLoadingDistrictDom = true;
    } else {
      isLoadingDistrict = true;
    }
    if (render) notifyListeners();

    final result = await repository.getDistricts(regencyId);
    result.fold(
      (failure) => print('Error fetching districts: ${failure.message}'),
      (data) {
        if (isDom) {
          districtsDom = data;
          isLoadingDistrictDom = false;
        } else {
          districts = data;
          isLoadingDistrict = false;
        }
        if (render) notifyListeners();
      },
    );
  }

  Future<void> fetchVillages(
    String districtId, {
    bool isDom = false,
    bool render = true,
  }) async {
    if (isDom) {
      isLoadingVillageDom = true;
    } else {
      isLoadingVillage = true;
    }
    if (render) notifyListeners();

    final result = await repository.getVillages(districtId);
    result.fold(
      (failure) => print('Error fetching villages: ${failure.message}'),
      (data) {
        if (isDom) {
          villagesDom = data;
          isLoadingVillageDom = false;
        } else {
          villages = data;
          isLoadingVillage = false;
        }
        if (render) notifyListeners();
      },
    );
  }

  Future<void> selectBirthDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      final value = DateFormat.yMMMMd('id').format(picked);
      birthDateController.text = value;
      final prefs = await SharedPreferences.getInstance();
      prefs.setString(AppConstants.biodata.birthDate, value);
      notifyListeners();
    }
  }

  void initialize() async {
    final prefs = await SharedPreferences.getInstance();

    selectedGender =
        prefs.getString(
          AppConstants.biodata.gender,
        ) ??
        selectedGender;
    selectedReligion =
        prefs.getString(
          AppConstants.biodata.religion,
        ) ??
        selectedReligion;
    selectedResidenceStatus =
        prefs.getString(
          AppConstants.biodata.residenceStatus,
        ) ??
        selectedResidenceStatus;
    birthDateController.text =
        prefs.getString(
          AppConstants.biodata.birthDate,
        ) ??
        birthDateController.text;
    isSwitchOn =
        prefs.getBool(AppConstants.biodata.sameCurrentAddress) ?? isSwitchOn;

    await fetchProvinces(render: false);
    final provinceId = prefs.getInt(AppConstants.biodata.province);
    final regencyId = prefs.getInt(AppConstants.biodata.regency);
    final districtId = prefs.getInt(AppConstants.biodata.district);
    final villageId = prefs.getInt(AppConstants.biodata.village);

    final currentProvinceId = prefs.getInt(
      AppConstants.biodata.currentProvince,
    );
    final currentRegencyId = prefs.getInt(
      AppConstants.biodata.currentRegency,
    );
    final currentDistrictId = prefs.getInt(
      AppConstants.biodata.currentDistrict,
    );
    final currentVillageId = prefs.getInt(
      AppConstants.biodata.currentVillage,
    );

    Future<void> ktpFuture() async {
      if (provinceId != null) {
        final province = provinces.firstWhere((e) => e.id == provinceId);
        await setProvince(province, render: false);
      }
      if (regencyId != null) {
        final regency = regencies.firstWhere((e) => e.id == regencyId);
        await setRegency(regency, render: false);
      }
      if (districtId != null) {
        final district = districts.firstWhere((e) => e.id == districtId);
        await setDistrict(district, render: false);
      }
      if (villageId != null) {
        final village = villages.firstWhere((e) => e.id == villageId);
        setVillage(village, render: false);
      }
    }

    Future<void> domFuture() async {
      if (currentProvinceId != null) {
        final currentProvince = provincesDom.firstWhere(
          (e) => e.id == currentProvinceId,
        );
        await setProvinceDom(currentProvince, render: false);
      }
      if (currentRegencyId != null) {
        final currentRegency = regenciesDom.firstWhere(
          (e) => e.id == currentRegencyId,
        );
        await setRegencyDom(currentRegency, render: false);
      }
      if (currentDistrictId != null) {
        final currentDistrict = districtsDom.firstWhere(
          (e) => e.id == currentDistrictId,
        );
        await setDistrictDom(currentDistrict, render: false);
      }
      if (currentVillageId != null) {
        final currentVillage = villagesDom.firstWhere(
          (e) => e.id == currentVillageId,
        );
        setVillageDom(currentVillage, render: false);
      }
    }

    await Future.wait([
      ktpFuture(),
      domFuture(),
    ]);

    notifyListeners();

    // await Future.wait([
    //   if (provinceId != null || currentProvinceId != null) fetchProvinces(),
    //   if (regencyId != null) fetchRegencies(provinceId.toString()),
    //   if (districtId != null) fetchDistricts(regencyId.toString()),
    //   if (villageId != null) fetchVillages(districtId.toString()),
    //   if (currentRegencyId != null)
    //     fetchRegencies(currentProvinceId.toString(), isDom: true),
    //   if (currentDistrictId != null)
    //     fetchDistricts(currentRegencyId.toString(), isDom: true),
    //   if (currentVillageId != null)
    //     fetchVillages(currentDistrictId.toString(), isDom: true),
    // ]);
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
