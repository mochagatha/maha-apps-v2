import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/network/api_client.dart';
import '../models/biodata_model.dart';
import '../models/employee_full_data_model.dart';
import '../models/region_models.dart';
import '../models/revision_verification_model.dart';

abstract class BiodataRemoteDataSource {
  Future<BiodataModel> getBiodata();
  Future<List<ProvinceModel>> getProvinces();
  Future<List<RegencyModel>> getRegencies(String provinceId);
  Future<List<DistrictModel>> getDistricts(String regencyId);
  Future<List<VillageModel>> getVillages(String districtId);
  Future<void> submitBiodata(Map<String, dynamic> body);
  Future<void> submitEducation(Map<String, dynamic> body);
  Future<void> submitFamily(Map<String, dynamic> body);
  Future<void> submitSibling(Map<String, dynamic> body);
  Future<void> submitMarital(int employeeId, Map<String, dynamic> body);
  Future<void> submitChildren(Map<String, dynamic> body);
  Future<void> submitDocument({
    required int employeeId,
    required String photoPath,
    required String ktpPath,
    required String kkPath,
    required String certificatePath,
    required String gradeTranscriptPath,
    String? certificateSkillPath,
    String? bankAccountPath,
    String? npwpPath,
    String? bpjsKtnPath,
    String? bpjsKesPath,
  });
  Future<RevisionVerificationModel> getRevisionVerification(int employeeId);
  Future<EmployeeFullDataModel> getEmployeeFullData(int employeeId);
  Future<void> submitRevision({required int employeeId, required Map<String, dynamic> body});
  Future<void> submitSkill({required int employeeId, required List<String> skills});
}

class BiodataRemoteDataSourceImpl implements BiodataRemoteDataSource {
  final ApiClient client;
  final SharedPreferences sharedPreferences;

  BiodataRemoteDataSourceImpl({required this.client, required this.sharedPreferences});

  @override
  Future<BiodataModel> getBiodata() async {
    try {
      final id = sharedPreferences.getInt('employee_id');
      if (id == null) {
        throw CacheException('Employee ID not found in cache');
      }

      final response = await client.dioGolang.get('/employee/$id');

      double totalPoint = 0.0;
      try {
        final pointsResponse = await client.dio.get(
          '/employee/employee-kpi/get-by-employee-existing/$id',
        );
        if (pointsResponse.statusCode == 200 && pointsResponse.data['data'] != null) {
          final pointsData = pointsResponse.data['data'];
          if (pointsData['total_point'] != null) {
            totalPoint = double.tryParse(pointsData['total_point'].toString()) ?? 0.0;
          }
        }
      } catch (e) {
        // Ignore points error, just default to 0.0
      }

      if (response.statusCode == 200) {
        final data = response.data['data'];
        if (data is Map<String, dynamic>) {
          data['total_point'] = totalPoint;
        }
        return BiodataModel.fromJson(data);
      } else {
        throw ServerException(response.data['message'] ?? 'Failed to get biodata');
      }
    } on DioException catch (e) {
      throw ServerException(e.response?.data['message'] ?? 'Network error occurred');
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<ProvinceModel>> getProvinces() async {
    try {
      final response = await client.dioRegion.get('/all-province');
      if (response.statusCode == 200) {
        final List data = response.data['data'];
        return data.map((json) => ProvinceModel.fromJson(json)).toList();
      } else {
        throw ServerException(response.data['message'] ?? 'Failed to load provinces');
      }
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<RegencyModel>> getRegencies(String provinceId) async {
    try {
      final response = await client.dioRegion.get('/all-regency/$provinceId');
      if (response.statusCode == 200) {
        final List data = response.data['data'];
        return data.map((json) => RegencyModel.fromJson(json)).toList();
      } else {
        throw ServerException(response.data['message'] ?? 'Failed to load regencies');
      }
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<DistrictModel>> getDistricts(String regencyId) async {
    try {
      final response = await client.dioRegion.get('/all-district/$regencyId');
      if (response.statusCode == 200) {
        final List data = response.data['data'];
        return data.map((json) => DistrictModel.fromJson(json)).toList();
      } else {
        throw ServerException(response.data['message'] ?? 'Failed to load districts');
      }
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<VillageModel>> getVillages(String districtId) async {
    try {
      final response = await client.dioRegion.get('/all-village/$districtId');
      if (response.statusCode == 200) {
        final List data = response.data['data'];
        return data.map((json) => VillageModel.fromJson(json)).toList();
      } else {
        throw ServerException(response.data['message'] ?? 'Failed to load villages');
      }
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> submitBiodata(Map<String, dynamic> body) async {
    try {
      final response = await client.dioGolang.post(
        '/employee/employee-biodata',
        data: body,
      );
      if (response.statusCode != 200 && response.statusCode != 201) {
        throw ServerException(
          response.data['message'] ?? 'Failed to submit biodata',
        );
      }
    } on DioException catch (e) {
      throw ServerException(
        e.response?.data['message'] ?? 'Network error occurred',
      );
    } catch (e) {
      if (e is ServerException) rethrow;
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> submitEducation(Map<String, dynamic> body) async {
    try {
      final response = await client.dioGolang.post(
        '/employee/employee-education',
        data: body,
      );
      if (response.statusCode != 200 && response.statusCode != 201) {
        throw ServerException(
          response.data['message'] ?? 'Failed to submit education',
        );
      }
    } on DioException catch (e) {
      throw ServerException(
        e.response?.data['message'] ?? 'Network error occurred',
      );
    } catch (e) {
      if (e is ServerException) rethrow;
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> submitFamily(Map<String, dynamic> body) async {
    try {
      final response = await client.dioGolang.post(
        '/employee/employee-family',
        data: body,
      );
      if (response.statusCode != 200 && response.statusCode != 201) {
        throw ServerException(
          response.data['message'] ?? 'Failed to submit family data',
        );
      }
    } on DioException catch (e) {
      throw ServerException(
        e.response?.data['message'] ?? 'Network error occurred',
      );
    } catch (e) {
      if (e is ServerException) rethrow;
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> submitSibling(Map<String, dynamic> body) async {
    try {
      final response = await client.dioGolang.post(
        '/employee/employee-sibling',
        data: body,
      );
      if (response.statusCode != 200 && response.statusCode != 201) {
        throw ServerException(
          response.data['message'] ?? 'Failed to submit sibling data',
        );
      }
    } on DioException catch (e) {
      throw ServerException(
        e.response?.data['message'] ?? 'Network error occurred',
      );
    } catch (e) {
      if (e is ServerException) rethrow;
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> submitMarital(int employeeId, Map<String, dynamic> body) async {
    try {
      final response = await client.dioGolang.put(
        '/employee/employee-marital/$employeeId',
        data: body,
      );
      if (response.statusCode != 200 && response.statusCode != 201) {
        throw ServerException(
          response.data['message'] ?? 'Failed to submit marital data',
        );
      }
    } on DioException catch (e) {
      throw ServerException(
        e.response?.data['message'] ?? 'Network error occurred',
      );
    } catch (e) {
      if (e is ServerException) rethrow;
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> submitChildren(Map<String, dynamic> body) async {
    try {
      final response = await client.dioGolang.post(
        '/employee/employee-children',
        data: body,
      );
      if (response.statusCode != 200 && response.statusCode != 201) {
        throw ServerException(
          response.data['message'] ?? 'Failed to submit children data',
        );
      }
    } on DioException catch (e) {
      throw ServerException(
        e.response?.data['message'] ?? 'Network error occurred',
      );
    } catch (e) {
      if (e is ServerException) rethrow;
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> submitDocument({
    required int employeeId,
    required String photoPath,
    required String ktpPath,
    required String kkPath,
    required String certificatePath,
    required String gradeTranscriptPath,
    String? certificateSkillPath,
    String? bankAccountPath,
    String? npwpPath,
    String? bpjsKtnPath,
    String? bpjsKesPath,
  }) async {
    try {
      final Map<String, dynamic> fields = {
        'employee_id': employeeId.toString(),
        'photo': await MultipartFile.fromFile(photoPath),
        'ktp': await MultipartFile.fromFile(ktpPath),
        'kk': await MultipartFile.fromFile(kkPath),
        'certificate': await MultipartFile.fromFile(certificatePath),
        'grade_transcript': await MultipartFile.fromFile(gradeTranscriptPath),
      };

      if (certificateSkillPath != null && certificateSkillPath.isNotEmpty) {
        fields['certificate_skill'] = await MultipartFile.fromFile(certificateSkillPath);
      }
      if (bankAccountPath != null && bankAccountPath.isNotEmpty) {
        fields['bank_account'] = await MultipartFile.fromFile(bankAccountPath);
      }
      if (npwpPath != null && npwpPath.isNotEmpty) {
        fields['npwp'] = await MultipartFile.fromFile(npwpPath);
      }
      if (bpjsKtnPath != null && bpjsKtnPath.isNotEmpty) {
        fields['bpjs_ktn'] = await MultipartFile.fromFile(bpjsKtnPath);
      }
      if (bpjsKesPath != null && bpjsKesPath.isNotEmpty) {
        fields['bpjs_kes'] = await MultipartFile.fromFile(bpjsKesPath);
      }

      final formData = FormData.fromMap(fields);

      final response = await client.dioGolang.post(
        '/employee/employee-document',
        data: formData,
        options: Options(contentType: 'multipart/form-data'),
      );

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw ServerException(
          response.data['message'] ?? 'Failed to submit documents',
        );
      }
    } on DioException catch (e) {
      throw ServerException(
        e.response?.data['message'] ?? 'Network error occurred',
      );
    } catch (e) {
      if (e is ServerException) rethrow;
      throw ServerException(e.toString());
    }
  }

  @override
  Future<RevisionVerificationModel> getRevisionVerification(int employeeId) async {
    try {
      final response = await client.dioGolang.get(
        '/employee/employee-verification-data/get-by-employee/$employeeId',
      );
      if (response.statusCode == 200 && response.data['data'] != null) {
        return RevisionVerificationModel.fromJson(
          response.data['data'] as Map<String, dynamic>,
        );
      }
      throw ServerException(response.data['message'] ?? 'Failed to get revision data');
    } on DioException catch (e) {
      throw ServerException(e.response?.data['message'] ?? 'Network error occurred');
    } catch (e) {
      if (e is ServerException) rethrow;
      throw ServerException(e.toString());
    }
  }

  @override
  Future<EmployeeFullDataModel> getEmployeeFullData(int employeeId) async {
    try {
      final response = await client.dioGolang.get('/employee/$employeeId');
      if (response.statusCode == 200 && response.data['data'] != null) {
        return EmployeeFullDataModel.fromJson(
          response.data['data'] as Map<String, dynamic>,
        );
      }
      throw ServerException(response.data['message'] ?? 'Failed to get employee data');
    } on DioException catch (e) {
      throw ServerException(e.response?.data['message'] ?? 'Network error occurred');
    } catch (e) {
      if (e is ServerException) rethrow;
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> submitRevision({
    required int employeeId,
    required Map<String, dynamic> body,
  }) async {
    try {
      final response = await client.dioGolang.put(
        '/employee/update-all-data/$employeeId',
        data: body,
      );
      if (response.statusCode != 200 && response.statusCode != 201) {
        throw ServerException(response.data['message'] ?? 'Failed to submit revision');
      }
    } on DioException catch (e) {
      throw ServerException(e.response?.data['message'] ?? 'Network error occurred');
    } catch (e) {
      if (e is ServerException) rethrow;
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> submitSkill({
    required int employeeId,
    required List<String> skills,
  }) async {
    try {
      final response = await client.dioGolang.post(
        '/employee/employee-skill/$employeeId',
        data: {'skills': skills},
      );
      if (response.statusCode != 200 && response.statusCode != 201) {
        throw ServerException(
          response.data['message'] ?? 'Failed to submit skills',
        );
      }
    } on DioException catch (e) {
      throw ServerException(
        e.response?.data['message'] ?? 'Network error occurred',
      );
    } catch (e) {
      if (e is ServerException) rethrow;
      throw ServerException(e.toString());
    }
  }
}
