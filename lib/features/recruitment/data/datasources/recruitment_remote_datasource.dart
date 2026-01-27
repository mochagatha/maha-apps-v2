import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/utils/constants.dart';
import '../models/recruitment_menu_item_model.dart';

abstract class RecruitmentRemoteDataSource {
  /// Get recruitment menus based on job title permissions
  Future<List<RecruitmentMenuItemModel>> getRecruitmentMenus();
}

class RecruitmentRemoteDataSourceImpl implements RecruitmentRemoteDataSource {
  final ApiClient client;

  RecruitmentRemoteDataSourceImpl({required this.client});

  // Define all available recruitment menus
  static const List<Map<String, dynamic>> _allRecruitmentMenus = [
    {
      'id': 'REKRUTMENT/VERIFIKASI_DATA',
      'label': 'Verifikasi Data',
      'icon': 'assets/images/icon/icon_verifikasi_data.svg',
      'route': '/recruitment/verification-data',
      'count': 0,
    },
    {
      'id': 'REKRUTMENT/PERJANJIAN_KERJA',
      'label': 'Perjanjian Kerja',
      'icon': 'assets/images/icon/icon_verifikasi_data_hrManager.svg',
      'route': null, // Will be implemented later
      'count': 0,
    },
    {
      'id': 'REKRUTMENT/AKTIVASI_BPJS',
      'label': 'Aktivasi BPJS',
      'icon': 'assets/images/icon/aktivasi_bpjs.svg',
      'route': null, // Will be implemented later
      'count': 0,
    },
    {
      'id': 'REKRUTMENT/KODE_PERUSAHAAN',
      'label': 'Kode Perusahaan',
      'icon': 'assets/images/icon/icon_verifikasi_data.svg',
      'route': '/recruitment/company-code',
      'count': 0,
    },
  ];

  @override
  Future<List<RecruitmentMenuItemModel>> getRecruitmentMenus() async {
    try {
      // Get job_title_id from SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      final jobTitleId = prefs.getInt('job_title_id');

      if (jobTitleId == null) {
        // If no job title, return default menus
        return _allRecruitmentMenus.map((json) => RecruitmentMenuItemModel.fromJson(json)).toList();
      }

      // Fetch menu permissions from API
      // V1 uses: /employee/job-title-menu-application?parent_menu_application_id=X&job_title_id=Y
      // First, we need to get the parent menu ID for REKRUTMENT
      // For now, we'll use a hardcoded approach similar to v1's defaultGridItemIDs

      try {
        // Get parent menu ID for REKRUTMENT (this would typically be fetched from menu API)
        // For simplicity, we'll fetch all job title menus and filter
        final response = await client.dioGolang.get(
          AppConstants.endpointJobTitleMenu,
          queryParameters: {'job_title_id': jobTitleId},
        );

        if (response.statusCode == 200) {
          final List<dynamic> menusJson = response.data['data'] ?? [];

          // Extract menu names that belong to REKRUTMENT
          final allowedMenuNames = menusJson
              .map((item) => item['menu_application']?['name'] as String?)
              .where((name) => name != null && name.startsWith('REKRUTMENT/'))
              .toSet();

          // Filter recruitment menus based on permissions
          if (allowedMenuNames.isEmpty) {
            // No specific permissions, return all default menus
            return _allRecruitmentMenus
                .map((json) => RecruitmentMenuItemModel.fromJson(json))
                .toList();
          }

          // Return only menus that user has permission for
          return _allRecruitmentMenus
              .where((menu) => allowedMenuNames.contains(menu['id']))
              .map((json) => RecruitmentMenuItemModel.fromJson(json))
              .toList();
        } else {
          // If API fails, return default menus
          return _allRecruitmentMenus
              .map((json) => RecruitmentMenuItemModel.fromJson(json))
              .toList();
        }
      } catch (e) {
        // If API call fails, return default menus
        return _allRecruitmentMenus.map((json) => RecruitmentMenuItemModel.fromJson(json)).toList();
      }
    } catch (e) {
      if (e is ServerException) {
        rethrow;
      }
      throw ServerException('Failed to get recruitment menus: ${e.toString()}');
    }
  }
}
