import '../../../../../../../../core/network/api_client.dart';
import '../models/punishment_setting_model.dart';

abstract class UbahPeriodeSuratRemoteDataSource {
  Future<PunishmentSettingModel> getPunishmentSetting();
  Future<PunishmentSettingModel> updatePunishmentSetting({
    required bool isActive,
    required int longPunishment,
    required bool loanPoint,
  });
}

class UbahPeriodeSuratRemoteDataSourceImpl implements UbahPeriodeSuratRemoteDataSource {
  final ApiClient apiClient;

  UbahPeriodeSuratRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<PunishmentSettingModel> getPunishmentSetting() async {
    final response = await apiClient.dioGolang.get(
      '/employee/employee-kpi-setting/get-punishment-setting',
    );

    // Handle V1 API response format {code, message, data}
    final data = response.data['data'] ?? response.data;
    return PunishmentSettingModel.fromJson(data);
  }

  @override
  Future<PunishmentSettingModel> updatePunishmentSetting({
    required bool isActive,
    required int longPunishment,
    required bool loanPoint,
  }) async {
    final response = await apiClient.dioGolang.put(
      '/employee/employee-kpi-setting/update-punishment-setting',
      data: {
        'is_active': isActive,
        'long_punishment': longPunishment,
        'loan_point': loanPoint,
      },
    );

    // Handle V1 API response format {code, message, data}
    final data = response.data['data'] ?? response.data;
    return PunishmentSettingModel.fromJson(data);
  }
}
