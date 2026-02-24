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
}
