import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/entities/employee_full_data.dart';
import '../../domain/entities/revision_verification.dart';
import '../../domain/usecases/get_employee_full_data.dart';
import '../../domain/usecases/get_revision_verification.dart';
import '../../domain/usecases/submit_revision.dart';

/// Maps backend column_name values to logical section keys used by the UI.
/// The key is the section identifier; the value is the list of possible
/// column_name strings that belong to that section.
const Map<String, List<String>> _sectionColumnNames = {
  // Biodata
  'biodata_fullname': ['Nama Lengkap'],
  'biodata_nickname': ['Nama Panggilan'],
  'biodata_nik': ['NIK'],
  'biodata_birth': ['Tempat Lahir', 'Tanggal Lahir'],
  'biodata_gender': ['Jenis Kelamin'],
  'biodata_religion': ['Agama'],
  'biodata_blood_type': ['Golongan Darah'],
  'biodata_body': ['Berat Badan', 'Tinggi Badan'],
  'biodata_phone': ['No. HP', 'No. Telepon'],
  'biodata_emergency_phone': ['No. HP Darurat', 'No. Telepon Darurat'],
  'biodata_residence_status': ['Status Tempat Tinggal'],
  'biodata_identity_address': ['Alamat KTP'],
  'biodata_current_address': ['Alamat Domisili', 'Alamat Saat Ini'],
  // Education
  'education_sd': ['Nama Sekolah SD', 'Tahun Masuk SD', 'Tahun Keluar SD'],
  'education_smp': ['Nama Sekolah SMP', 'Tahun Masuk SMP', 'Tahun Keluar SMP'],
  'education_sma': ['Nama Sekolah SMA', 'Tahun Masuk SMA', 'Tahun Keluar SMA'],
  'education_s1': [
    'Universitas S1',
    'Jurusan S1',
    'Tahun Masuk S1',
    'Tahun Keluar S1',
    'IPK S1',
    'Gelar S1',
  ],
  'education_s2': [
    'Universitas S2',
    'Jurusan S2',
    'Tahun Masuk S2',
    'Tahun Keluar S2',
    'IPK S2',
    'Gelar S2',
  ],
  'education_s3': [
    'Universitas S3',
    'Jurusan S3',
    'Tahun Masuk S3',
    'Tahun Keluar S3',
    'IPK S3',
    'Gelar S3',
  ],
  // Family
  'family_father': [
    'Nama Ayah',
    'Status Ayah',
    'Umur Ayah',
    'Pendidikan Ayah',
    'Pekerjaan Ayah',
    'Perusahaan Ayah',
  ],
  'family_mother': [
    'Nama Ibu',
    'Status Ibu',
    'Umur Ibu',
    'Pendidikan Ibu',
    'Pekerjaan Ibu',
    'Perusahaan Ibu',
  ],
  'family_spouse': [
    'Nama Pasangan',
    'Nama Istri',
    'Nama Suami',
    'Umur Pasangan',
    'Pendidikan Pasangan',
    'Status Pernikahan',
  ],
  // List sections
  'sibling': ['Nama Saudara', 'Saudara'],
  'children': ['Nama Anak', 'Anak'],
};

enum RevisionStatus { initial, loading, loaded, submitting, submitted, error }

class BiodataRevisionProvider extends ChangeNotifier {
  final GetRevisionVerification getRevisionVerification;
  final GetEmployeeFullData getEmployeeFullData;
  final SubmitRevision submitRevision;

  BiodataRevisionProvider({
    required this.getRevisionVerification,
    required this.getEmployeeFullData,
    required this.submitRevision,
  });

  // ── State ─────────────────────────────────────────────────────────────────
  RevisionStatus _status = RevisionStatus.initial;
  RevisionStatus get status => _status;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  RevisionVerification? _revisionVerification;
  RevisionVerification? get revisionVerification => _revisionVerification;

  EmployeeFullData? _employeeFullData;
  EmployeeFullData? get employeeFullData => _employeeFullData;

  /// Set of column_name values that need revision, from the API.
  Set<String> _revisionColumnNames = {};

  // ── Biodata controllers ───────────────────────────────────────────────────
  final nameController = TextEditingController();
  final nicknameController = TextEditingController();
  final nikController = TextEditingController();
  final birthPlaceController = TextEditingController();
  final birthDateController = TextEditingController();
  final genderController = TextEditingController();
  final religionController = TextEditingController();
  final bloodTypeController = TextEditingController();
  final weightController = TextEditingController();
  final heightController = TextEditingController();
  final phoneController = TextEditingController();
  final emergencyPhoneController = TextEditingController();
  final residenceStatusController = TextEditingController();
  final identityAddressController = TextEditingController();
  final currentAddressController = TextEditingController();

  // ── Education controllers ─────────────────────────────────────────────────
  final primarySchoolController = TextEditingController();
  final psStartYearController = TextEditingController();
  final psEndYearController = TextEditingController();
  final juniorHighSchoolController = TextEditingController();
  final jhsStartYearController = TextEditingController();
  final jhsEndYearController = TextEditingController();
  final seniorHighSchoolController = TextEditingController();
  final shsStartYearController = TextEditingController();
  final shsEndYearController = TextEditingController();
  final bachelorUniversityController = TextEditingController();
  final bachelorMajorController = TextEditingController();
  final bachelorStartYearController = TextEditingController();
  final bachelorEndYearController = TextEditingController();
  final bachelorGpaController = TextEditingController();
  final bachelorDegreeController = TextEditingController();
  final masterUniversityController = TextEditingController();
  final masterMajorController = TextEditingController();
  final masterStartYearController = TextEditingController();
  final masterEndYearController = TextEditingController();
  final masterGpaController = TextEditingController();
  final masterDegreeController = TextEditingController();
  final doctoralUniversityController = TextEditingController();
  final doctoralMajorController = TextEditingController();
  final doctoralStartYearController = TextEditingController();
  final doctoralEndYearController = TextEditingController();
  final doctoralGpaController = TextEditingController();
  final doctoralDegreeController = TextEditingController();

  // ── Family controllers ────────────────────────────────────────────────────
  final fatherNameController = TextEditingController();
  final fatherAgeController = TextEditingController();
  final fatherEducationController = TextEditingController();
  final fatherJobTitleController = TextEditingController();
  final fatherJobCompanyController = TextEditingController();
  final motherNameController = TextEditingController();
  final motherAgeController = TextEditingController();
  final motherEducationController = TextEditingController();
  final motherJobTitleController = TextEditingController();
  final motherJobCompanyController = TextEditingController();
  final spouseController = TextEditingController();
  final spouseAgeController = TextEditingController();
  final spouseEducationController = TextEditingController();

  // ── Section visibility helpers ────────────────────────────────────────────

  bool _sectionVisible(List<String> columnNames) =>
      columnNames.any((c) => _revisionColumnNames.contains(c));

  bool get showBiodataFullname => _sectionVisible(_sectionColumnNames['biodata_fullname']!);
  bool get showBiodataNickname => _sectionVisible(_sectionColumnNames['biodata_nickname']!);
  bool get showBiodataNik => _sectionVisible(_sectionColumnNames['biodata_nik']!);
  bool get showBiodataBirth => _sectionVisible(_sectionColumnNames['biodata_birth']!);
  bool get showBiodataGender => _sectionVisible(_sectionColumnNames['biodata_gender']!);
  bool get showBiodataReligion => _sectionVisible(_sectionColumnNames['biodata_religion']!);
  bool get showBiodataBloodType => _sectionVisible(_sectionColumnNames['biodata_blood_type']!);
  bool get showBiodataBody => _sectionVisible(_sectionColumnNames['biodata_body']!);
  bool get showBiodataPhone => _sectionVisible(_sectionColumnNames['biodata_phone']!);
  bool get showBiodataEmergencyPhone =>
      _sectionVisible(_sectionColumnNames['biodata_emergency_phone']!);
  bool get showBiodataResidenceStatus =>
      _sectionVisible(_sectionColumnNames['biodata_residence_status']!);
  bool get showBiodataIdentityAddress =>
      _sectionVisible(_sectionColumnNames['biodata_identity_address']!);
  bool get showBiodataCurrentAddress =>
      _sectionVisible(_sectionColumnNames['biodata_current_address']!);
  bool get showBiodataSection =>
      showBiodataFullname ||
      showBiodataNickname ||
      showBiodataNik ||
      showBiodataBirth ||
      showBiodataGender ||
      showBiodataReligion ||
      showBiodataBloodType ||
      showBiodataBody ||
      showBiodataPhone ||
      showBiodataEmergencyPhone ||
      showBiodataResidenceStatus ||
      showBiodataIdentityAddress ||
      showBiodataCurrentAddress;

  bool get showEducationSd => _sectionVisible(_sectionColumnNames['education_sd']!);
  bool get showEducationSmp => _sectionVisible(_sectionColumnNames['education_smp']!);
  bool get showEducationSma => _sectionVisible(_sectionColumnNames['education_sma']!);
  bool get showEducationS1 => _sectionVisible(_sectionColumnNames['education_s1']!);
  bool get showEducationS2 => _sectionVisible(_sectionColumnNames['education_s2']!);
  bool get showEducationS3 => _sectionVisible(_sectionColumnNames['education_s3']!);

  bool get showFamilyFather => _sectionVisible(_sectionColumnNames['family_father']!);
  bool get showFamilyMother => _sectionVisible(_sectionColumnNames['family_mother']!);
  bool get showFamilySpouse => _sectionVisible(_sectionColumnNames['family_spouse']!);
  bool get showSiblingSection => _sectionVisible(_sectionColumnNames['sibling']!);
  bool get showChildrenSection => _sectionVisible(_sectionColumnNames['children']!);

  List<RevisionItem> get revisionItems => _revisionVerification?.revision ?? [];
  String? get revisionDescription => _revisionVerification?.revisionDescription;

  // ── Load ────────────────────────────────────────────────────────────────
  Future<void> load() async {
    _status = RevisionStatus.loading;
    _errorMessage = null;
    notifyListeners();

    try {
      final prefs = await SharedPreferences.getInstance();
      final employeeId = prefs.getInt('employee_id');
      if (employeeId == null) {
        _status = RevisionStatus.error;
        _errorMessage = 'Employee ID tidak ditemukan';
        notifyListeners();
        return;
      }

      final results = await Future.wait([
        getRevisionVerification(GetRevisionVerificationParams(employeeId: employeeId)),
        getEmployeeFullData(GetEmployeeFullDataParams(employeeId: employeeId)),
      ]);

      bool hasError = false;

      results[0].fold(
        (failure) {
          _errorMessage = failure.message;
          hasError = true;
        },
        (data) {
          _revisionVerification = data as RevisionVerification;
          _revisionColumnNames = _revisionVerification!.revision.map((r) => r.columnName).toSet();
        },
      );

      if (!hasError) {
        results[1].fold(
          (failure) {
            _errorMessage = failure.message;
            hasError = true;
          },
          (data) {
            _employeeFullData = data as EmployeeFullData;
            _populateControllers(_employeeFullData!);
          },
        );
      }

      _status = hasError ? RevisionStatus.error : RevisionStatus.loaded;
    } catch (e) {
      _status = RevisionStatus.error;
      _errorMessage = e.toString();
    }

    notifyListeners();
  }

  // ── Populate controllers ──────────────────────────────────────────────────
  void _populateControllers(EmployeeFullData data) {
    final b = data.biodata;
    if (b != null) {
      nameController.text = b.fullname;
      nicknameController.text = b.nickname ?? '';
      nikController.text = b.nik ?? '';
      birthPlaceController.text = b.birthPlace ?? '';
      birthDateController.text = b.birthDate ?? '';
      genderController.text = b.gender ?? '';
      religionController.text = b.religion ?? '';
      bloodTypeController.text = b.bloodType ?? '';
      weightController.text = b.weight?.toString() ?? '';
      heightController.text = b.height?.toString() ?? '';
      phoneController.text = b.phoneNumber ?? '';
      emergencyPhoneController.text = b.emergencyPhoneNumber ?? '';
      residenceStatusController.text = b.residenceStatus ?? '';
      identityAddressController.text = b.identityAddress ?? '';
      currentAddressController.text = b.currentAddress ?? '';
    }

    final e = data.education;
    if (e != null) {
      primarySchoolController.text = e.primarySchool ?? '';
      psStartYearController.text = e.psStartYear ?? '';
      psEndYearController.text = e.psEndYear ?? '';
      juniorHighSchoolController.text = e.juniorHighSchool ?? '';
      jhsStartYearController.text = e.jhsStartYear ?? '';
      jhsEndYearController.text = e.jhsEndYear ?? '';
      seniorHighSchoolController.text = e.seniorHighSchool ?? '';
      shsStartYearController.text = e.shsStartYear ?? '';
      shsEndYearController.text = e.shsEndYear ?? '';
      bachelorUniversityController.text = e.bachelorUniversity ?? '';
      bachelorMajorController.text = e.bachelorMajor ?? '';
      bachelorStartYearController.text = e.bachelorStartYear ?? '';
      bachelorEndYearController.text = e.bachelorEndYear ?? '';
      bachelorGpaController.text = e.bachelorGpa ?? '';
      bachelorDegreeController.text = e.bachelorDegree ?? '';
      masterUniversityController.text = e.masterUniversity ?? '';
      masterMajorController.text = e.masterMajor ?? '';
      masterStartYearController.text = e.masterStartYear ?? '';
      masterEndYearController.text = e.masterEndYear ?? '';
      masterGpaController.text = e.masterGpa ?? '';
      masterDegreeController.text = e.masterDegree ?? '';
      doctoralUniversityController.text = e.doctoralUniversity ?? '';
      doctoralMajorController.text = e.doctoralMajor ?? '';
      doctoralStartYearController.text = e.doctoralStartYear ?? '';
      doctoralEndYearController.text = e.doctoralEndYear ?? '';
      doctoralGpaController.text = e.doctoralGpa ?? '';
      doctoralDegreeController.text = e.doctoralDegree ?? '';
    }

    final f = data.family;
    if (f != null) {
      fatherNameController.text = f.fatherName ?? '';
      fatherAgeController.text = f.fatherAge?.toString() ?? '';
      fatherEducationController.text = f.fatherLastEducation ?? '';
      fatherJobTitleController.text = f.fatherLastJobTitle ?? '';
      fatherJobCompanyController.text = f.fatherLastJobCompany ?? '';
      motherNameController.text = f.motherName ?? '';
      motherAgeController.text = f.motherAge?.toString() ?? '';
      motherEducationController.text = f.motherLastEducation ?? '';
      motherJobTitleController.text = f.motherLastJobTitle ?? '';
      motherJobCompanyController.text = f.motherLastJobCompany ?? '';
      spouseController.text = f.coupleName ?? '';
      spouseAgeController.text = f.coupleAge?.toString() ?? '';
      spouseEducationController.text = f.coupleLastEducation ?? '';
    }
  }

  // ── Submit ────────────────────────────────────────────────────────────────
  Future<bool> submit() async {
    _status = RevisionStatus.submitting;
    _errorMessage = null;
    notifyListeners();

    try {
      final prefs = await SharedPreferences.getInstance();
      final employeeId = prefs.getInt('employee_id');
      if (employeeId == null) {
        _status = RevisionStatus.error;
        _errorMessage = 'Employee ID tidak ditemukan';
        notifyListeners();
        return false;
      }

      final result = await submitRevision(
        SubmitRevisionParams(employeeId: employeeId, body: _buildBody()),
      );

      return result.fold(
        (failure) {
          _status = RevisionStatus.loaded;
          _errorMessage = failure.message;
          notifyListeners();
          return false;
        },
        (_) {
          _status = RevisionStatus.submitted;
          notifyListeners();
          return true;
        },
      );
    } catch (e) {
      _status = RevisionStatus.error;
      _errorMessage = e.toString();
      notifyListeners();
      return false;
    }
  }

  // ── Build body ────────────────────────────────────────────────────────────
  Map<String, dynamic> _buildBody() {
    final body = <String, dynamic>{};

    // employee_biodata
    if (showBiodataSection) {
      final b = <String, dynamic>{};
      if (showBiodataFullname) b['fullname'] = nameController.text.trim();
      if (showBiodataNickname) b['nickname'] = nicknameController.text.trim();
      if (showBiodataNik) b['nik'] = nikController.text.trim();
      if (showBiodataBirth) {
        b['birth_place'] = birthPlaceController.text.trim();
        b['birth_date'] = birthDateController.text.trim();
      }
      if (showBiodataGender) b['gender'] = genderController.text.trim();
      if (showBiodataReligion) b['religion'] = religionController.text.trim();
      if (showBiodataBloodType) b['blood_type'] = bloodTypeController.text.trim();
      if (showBiodataBody) {
        b['weight'] = int.tryParse(weightController.text.trim());
        b['height'] = int.tryParse(heightController.text.trim());
      }
      if (showBiodataPhone) b['phone_number'] = phoneController.text.trim();
      if (showBiodataEmergencyPhone)
        b['emergency_phone_number'] = emergencyPhoneController.text.trim();
      if (showBiodataResidenceStatus) b['residence_status'] = residenceStatusController.text.trim();
      if (showBiodataIdentityAddress) b['identity_address'] = identityAddressController.text.trim();
      if (showBiodataCurrentAddress) b['current_address'] = currentAddressController.text.trim();
      body['employee_biodata'] = b;
    }

    // employee_education
    final hasEdu =
        showEducationSd ||
        showEducationSmp ||
        showEducationSma ||
        showEducationS1 ||
        showEducationS2 ||
        showEducationS3;
    if (hasEdu) {
      final e = <String, dynamic>{};
      if (showEducationSd) {
        e['primary_school'] = primarySchoolController.text.trim();
        e['ps_start_year'] = int.tryParse(psStartYearController.text.trim());
        e['ps_end_year'] = int.tryParse(psEndYearController.text.trim());
      }
      if (showEducationSmp) {
        e['junior_high_school'] = juniorHighSchoolController.text.trim();
        e['jhs_start_year'] = int.tryParse(jhsStartYearController.text.trim());
        e['jhs_end_year'] = int.tryParse(jhsEndYearController.text.trim());
      }
      if (showEducationSma) {
        e['senior_high_school'] = seniorHighSchoolController.text.trim();
        e['shs_start_year'] = int.tryParse(shsStartYearController.text.trim());
        e['shs_end_year'] = int.tryParse(shsEndYearController.text.trim());
      }
      if (showEducationS1) {
        e['bachelor_university'] = bachelorUniversityController.text.trim();
        e['bachelor_major'] = bachelorMajorController.text.trim();
        e['bachelor_gpa'] = bachelorGpaController.text.trim();
        e['bachelor_degree'] = bachelorDegreeController.text.trim();
        e['bachelor_start_year'] = int.tryParse(bachelorStartYearController.text.trim());
        e['bachelor_end_year'] = int.tryParse(bachelorEndYearController.text.trim());
      }
      if (showEducationS2) {
        e['master_university'] = masterUniversityController.text.trim();
        e['master_major'] = masterMajorController.text.trim();
        e['master_gpa'] = masterGpaController.text.trim();
        e['master_degree'] = masterDegreeController.text.trim();
        e['master_start_year'] = masterStartYearController.text.trim();
        e['master_end_year'] = masterEndYearController.text.trim();
      }
      if (showEducationS3) {
        e['doctoral_university'] = doctoralUniversityController.text.trim();
        e['doctoral_major'] = doctoralMajorController.text.trim();
        e['doctoral_gpa'] = doctoralGpaController.text.trim();
        e['doctoral_degree'] = doctoralDegreeController.text.trim();
        e['doctoral_start_year'] = int.tryParse(doctoralStartYearController.text.trim());
        e['doctoral_end_year'] = int.tryParse(doctoralEndYearController.text.trim());
      }
      body['employee_education'] = e;
    }

    // employee_family
    if (showFamilyFather || showFamilyMother || showFamilySpouse) {
      final f = <String, dynamic>{};
      if (showFamilyFather) {
        f['father_name'] = fatherNameController.text.trim();
        f['father_age'] = int.tryParse(fatherAgeController.text.trim()) ?? 0;
        f['father_last_education'] = fatherEducationController.text.trim();
        f['father_last_job_title'] = fatherJobTitleController.text.trim();
        f['father_last_job_company'] = fatherJobCompanyController.text.trim();
        f['father_status'] = _employeeFullData?.family?.fatherStatus ?? 1;
      }
      if (showFamilyMother) {
        f['mother_name'] = motherNameController.text.trim();
        f['mother_age'] = int.tryParse(motherAgeController.text.trim()) ?? 0;
        f['mother_last_education'] = motherEducationController.text.trim();
        f['mother_last_job_title'] = motherJobTitleController.text.trim();
        f['mother_last_job_company'] = motherJobCompanyController.text.trim();
        f['mother_status'] = _employeeFullData?.family?.motherStatus ?? 1;
      }
      if (showFamilySpouse) {
        f['couple_name'] = spouseController.text.trim();
        f['couple_age'] = int.tryParse(spouseAgeController.text.trim()) ?? 0;
        f['couple_last_education'] = spouseEducationController.text.trim();
        f['marital_status'] = _employeeFullData?.family?.maritalStatus ?? 'kawin';
      }
      body['employee_family'] = f;
    }

    // employee_sibling
    if (showSiblingSection && (_employeeFullData?.siblings.isNotEmpty ?? false)) {
      body['employee_sibling'] = _employeeFullData!.siblings
          .map(
            (s) => {
              'sibling_id': s.id,
              'sibling_name': s.siblingName ?? '',
              'sibling_gender': s.siblingGender ?? 'L',
              'sibling_status': s.siblingStatus ?? 1,
              'sibling_age': s.siblingAge ?? 0,
              'sibling_last_education': s.siblingLastEducation ?? '',
              'sibling_last_job_title': s.siblingLastJobTitle ?? '',
              'sibling_last_job_company': s.siblingLastJobCompany ?? '',
            },
          )
          .toList();
    }

    // employee_children
    if (showChildrenSection && (_employeeFullData?.children.isNotEmpty ?? false)) {
      body['employee_children'] = _employeeFullData!.children
          .map(
            (c) => {
              'children_id': c.id,
              'child_name': c.childName ?? '',
              'child_gender': c.childGender ?? 'L',
              'child_age': c.childAge ?? 0,
              'child_status': c.childStatus ?? 1,
              'child_last_education': c.childLastEducation ?? '',
              'child_last_job_title': c.childLastJobTitle ?? '',
              'child_last_job_company': c.childLastJobCompany ?? '',
            },
          )
          .toList();
    }

    return body;
  }

  @override
  void dispose() {
    nameController.dispose();
    nicknameController.dispose();
    nikController.dispose();
    birthPlaceController.dispose();
    birthDateController.dispose();
    genderController.dispose();
    religionController.dispose();
    bloodTypeController.dispose();
    weightController.dispose();
    heightController.dispose();
    phoneController.dispose();
    emergencyPhoneController.dispose();
    residenceStatusController.dispose();
    identityAddressController.dispose();
    currentAddressController.dispose();
    primarySchoolController.dispose();
    psStartYearController.dispose();
    psEndYearController.dispose();
    juniorHighSchoolController.dispose();
    jhsStartYearController.dispose();
    jhsEndYearController.dispose();
    seniorHighSchoolController.dispose();
    shsStartYearController.dispose();
    shsEndYearController.dispose();
    bachelorUniversityController.dispose();
    bachelorMajorController.dispose();
    bachelorStartYearController.dispose();
    bachelorEndYearController.dispose();
    bachelorGpaController.dispose();
    bachelorDegreeController.dispose();
    masterUniversityController.dispose();
    masterMajorController.dispose();
    masterStartYearController.dispose();
    masterEndYearController.dispose();
    masterGpaController.dispose();
    masterDegreeController.dispose();
    doctoralUniversityController.dispose();
    doctoralMajorController.dispose();
    doctoralStartYearController.dispose();
    doctoralEndYearController.dispose();
    doctoralGpaController.dispose();
    doctoralDegreeController.dispose();
    fatherNameController.dispose();
    fatherAgeController.dispose();
    fatherEducationController.dispose();
    fatherJobTitleController.dispose();
    fatherJobCompanyController.dispose();
    motherNameController.dispose();
    motherAgeController.dispose();
    motherEducationController.dispose();
    motherJobTitleController.dispose();
    motherJobCompanyController.dispose();
    spouseController.dispose();
    spouseAgeController.dispose();
    spouseEducationController.dispose();
    super.dispose();
  }
}
