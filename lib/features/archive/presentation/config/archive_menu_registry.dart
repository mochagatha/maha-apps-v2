import 'package:maha_apps_v2/core/router/app_routes.dart';
import 'package:maha_apps_v2/core/config/sub_menu_config.dart';
import 'package:maha_apps_v2/core/utils/constants.dart';
import 'package:maha_apps_v2/features/archive/domain/entities/archive_options.dart';

/// Centralized registry for all settings menu items
/// This makes it easy to maintain menu configurations in one place
class ArchiveMenuRegistry {
  /// Private ructor to prevent instantiation
  ArchiveMenuRegistry._();

  /// Map of menu code to configuration
  static final Map<String, SubMenuConfig> _registry = {
    AppConstants.menu.subArsip.registrasi: SubMenuConfig(
      code: AppConstants.menu.subArsip.registrasi,
      titleKey: 'arsipRegistrasi',
      iconPath: 'assets/images/svg/arsip/registrasi.svg',
      routePath: AppRoutes.archiveYearMenu.path,
      extra: {
        "options": ArchiveOptions(
          title: "Arsip Registrasi",
          pagePath: AppRoutes.archiveRegistrationMenu.path,
        ),
      },
      order: 1,
    ),
    AppConstants.menu.subArsip.pernyataan: SubMenuConfig(
      code: AppConstants.menu.subArsip.pernyataan,
      titleKey: 'arsipPernyataan',
      iconPath: 'assets/images/svg/arsip/pernyataan.svg',
      routePath: AppRoutes.archiveYearMenu.path,
      extra: {
        "options": ArchiveOptions(
          title: "Arsip Pernyataan",
          pagePath: AppRoutes.archiveStatementMenu.path,
        ),
      },
      order: 2,
    ),
    AppConstants.menu.subArsip.perjanjian: SubMenuConfig(
      code: AppConstants.menu.subArsip.perjanjian,
      titleKey: 'arsipPerjanjian',
      iconPath: 'assets/images/svg/arsip/perjanjian.svg',
      routePath: AppRoutes.archiveYearMenu.path,
      extra: {
        "options": ArchiveOptions(
          title: "Arsip Perjanjian",
          pagePath: AppRoutes.archiveAgreementMenu.path,
        ),
      },
      order: 3,
    ),
  };

  /// Get configuration for a specific menu code
  /// Returns null if not found
  static SubMenuConfig? getConfig(String code) {
    return _registry[code];
  }

  /// Check if menu code exists in registry
  static bool hasConfig(String code) {
    return _registry.containsKey(code);
  }
}
