import '../../../../core/config/api_endpoints.dart';
import '../../../../core/network/api_client.dart';
import '../models/access_screen_model.dart';

abstract class AccessScreenRemoteDataSource {
  Future<AccessScreenModel> getAccessScreenList(String type);
  Future<AccessScreenDetailModel> getAccessScreenDetail(String type, int id);
  Future<void> updateGlobalAccessScreen(int id, bool isRecord, bool isCatch);
  Future<void> updateDetailAccessScreen(int id, bool isRecord, bool isCatch);
}

class AccessScreenRemoteDataSourceImpl implements AccessScreenRemoteDataSource {
  final ApiClient client;

  AccessScreenRemoteDataSourceImpl({required this.client});

  @override
  Future<AccessScreenModel> getAccessScreenList(String type) async {
    try {
      final response = await client.dioGolang.get(
        "${ApiEndpoints.screenSetting}/get-all",
        queryParameters: {'type': type},
      );
      return AccessScreenModel.fromJson(response.data['data']);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<AccessScreenDetailModel> getAccessScreenDetail(String type, int id) async {
    try {
      print('🌐 API Request - Get detail: type=$type, id=$id');
      final response = await client.dioGolang.get(
        "${ApiEndpoints.screenSetting}/get-by-employee-worker-id",
        queryParameters: {'type': type, 'employee_worker_id': id},
      );
      print('📦 API Response - Detail data: ${response.data}');
      return AccessScreenDetailModel.fromJson(response.data['data']);
    } catch (e) {
      print('❌ API Error - Get detail: $e');
      rethrow;
    }
  }

  @override
  Future<void> updateGlobalAccessScreen(int id, bool isRecord, bool isCatch) async {
    try {
      await client.dioGolang.put(
        "${ApiEndpoints.screenSetting}/global/$id",
        data: {'is_record': isRecord, 'is_catch': isCatch},
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> updateDetailAccessScreen(int id, bool isRecord, bool isCatch) async {
    try {
      await client.dioGolang.put(
        "${ApiEndpoints.screenSetting}/$id",
        data: {'is_record': isRecord, 'is_catch': isCatch},
      );
    } catch (e) {
      rethrow;
    }
  }
}
