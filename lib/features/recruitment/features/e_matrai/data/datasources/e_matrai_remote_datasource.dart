import 'package:dio/dio.dart';
import 'package:maha_apps_v2/core/error/exceptions.dart';
import 'package:maha_apps_v2/core/network/api_client.dart';
import '../models/e_matrai_models.dart';

abstract class EMatraiRemoteDataSource {
  /// [matraiStatus] – 0 = baru, 1 = upload, 2 = selesai
  /// [typeUser]    – "employee" or "worker"
  Future<EMatraiListModel> getEMatraiList({
    required int matraiStatus,
    required String typeUser,
  });

  /// Upload signed PDF via multipart/form-data.
  Future<void> uploadMatrai({
    required int employeeAgreementId,
    required String filePath,
  });
}

class EMatraiRemoteDataSourceImpl implements EMatraiRemoteDataSource {
  final ApiClient client;

  EMatraiRemoteDataSourceImpl({required this.client});

  @override
  Future<EMatraiListModel> getEMatraiList({
    required int matraiStatus,
    required String typeUser,
  }) async {
    try {
      final response = await client.dioGolang.get(
        '/employee/employee-agreement/get-all-matrai',
        queryParameters: {
          'matrai_status': matraiStatus,
          'type_user': typeUser,
        },
      );

      final body = response.data as Map<String, dynamic>;
      return EMatraiListModel.fromJson(body);
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException('Failed to fetch e-matrai list: $e');
    }
  }

  @override
  Future<void> uploadMatrai({
    required int employeeAgreementId,
    required String filePath,
  }) async {
    try {
      final formData = FormData.fromMap({
        'employee_agreement_id': employeeAgreementId.toString(),
        'files': await MultipartFile.fromFile(
          filePath,
          contentType: DioMediaType('application', 'pdf'),
        ),
      });

      final response = await client.dioGolang.post(
        '/employee/employee-agreement/upload-matrai',
        data: formData,
        options: Options(contentType: 'multipart/form-data'),
      );
      print(response.data);

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw ServerException(
          (response.data as Map<String, dynamic>?)?['message'] as String? ??
              'Failed to upload matrai',
        );
      }
    } on DioException catch (e) {
      throw ServerException(
        e.response?.data['message'] as String? ?? 'Failed to upload matrai: ${e.message}',
      );
    } catch (e) {
      print(e);
      throw ServerException('Failed to upload matrai: $e');
    }
  }
}
