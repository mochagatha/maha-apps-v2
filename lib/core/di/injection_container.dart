// Dependency Injection Container using GetIt
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../network/api_client.dart';
import '../network/network_info.dart';

// Authentication feature imports
import '../../features/authentication/data/datasources/auth_local_datasource.dart';
import '../../features/authentication/data/datasources/auth_remote_datasource.dart';
import '../../features/authentication/data/repositories/auth_repository_impl.dart';
import '../../features/authentication/domain/repositories/auth_repository.dart';
import '../../features/authentication/domain/usecases/check_auth_status.dart';
import '../../features/authentication/domain/usecases/get_current_user.dart';
import '../../features/authentication/domain/usecases/login.dart';
import '../../features/authentication/domain/usecases/logout.dart';
import '../../features/authentication/domain/usecases/register.dart';
import '../../features/authentication/domain/usecases/save_login_status.dart';
import '../../features/authentication/domain/usecases/verify_company_code.dart';
import '../../features/authentication/domain/usecases/get_profile.dart';
import '../../features/authentication/domain/usecases/upload_admin_photo.dart';
import '../../features/authentication/presentation/providers/auth_provider.dart';
import '../../features/authentication/presentation/providers/admin_face_provider.dart';

// Forgot Password
import '../../features/authentication/data/datasources/forgot_password_remote_datasource.dart';
import '../../features/authentication/data/repositories/forgot_password_repository_impl.dart';
import '../../features/authentication/domain/repositories/forgot_password_repository.dart';
import '../../features/authentication/domain/usecases/send_otp.dart';
import '../../features/authentication/domain/usecases/verify_otp.dart';
import '../../features/authentication/domain/usecases/reset_password.dart';
import '../../features/authentication/presentation/providers/forgot_password_provider.dart';

// Home feature imports
import '../../features/home/data/datasources/home_local_datasource.dart';
import '../../features/home/data/datasources/home_remote_datasource.dart';
import '../../features/home/data/repositories/home_repository_impl.dart';
import '../../features/home/domain/repositories/home_repository.dart';
import '../../features/home/domain/usecases/get_employee_menus.dart';
import '../../features/home/domain/usecases/get_employee_profile.dart';
import '../../features/home/domain/usecases/get_hierarchical_menus.dart';
import '../../features/home/domain/usecases/get_kpi_summary.dart';
import '../../features/home/domain/usecases/get_notification_count.dart';
import '../../features/home/presentation/providers/home_provider.dart';
import '../../features/home/presentation/providers/admin_home_provider.dart';
import '../../features/home/presentation/usecases/get_admin_menus.dart';

// Profile feature imports
import '../../features/profile/data/datasources/profile_local_datasource.dart';
import '../../features/profile/data/datasources/profile_remote_datasource.dart';
import '../../features/profile/data/repositories/profile_repository_impl.dart';
import '../../features/profile/domain/repositories/profile_repository.dart';
import '../../features/profile/domain/usecases/get_employee_profile.dart' as profile_usecases;
import '../../features/profile/domain/usecases/update_employee_profile.dart';
import '../../features/profile/domain/usecases/update_profile_picture.dart';
import '../../features/profile/presentation/providers/profile_provider.dart';

// Absensi feature imports
import '../../features/absensi/data/datasources/attendance_remote_datasource.dart';
import '../../features/absensi/data/repositories/attendance_repository_impl.dart';
import '../../features/absensi/domain/repositories/attendance_repository.dart';
import '../../features/absensi/domain/usecases/get_absensi_menu_ids.dart';
import '../../features/absensi/domain/usecases/get_today_attendance.dart';
import '../../features/absensi/domain/usecases/submit_attendance.dart';
import '../../features/absensi/presentation/providers/attendance_provider.dart';

// Biodata feature imports
import '../../features/biodata/data/datasources/biodata_remote_datasource.dart';
import '../../features/biodata/data/repositories/biodata_repository_impl.dart';
import '../../features/biodata/domain/repositories/biodata_repository.dart';
import '../../features/biodata/domain/usecases/get_biodata.dart';
import '../../features/biodata/presentation/providers/biodata_provider.dart';

// Recruitment feature imports
import '../../features/recruitment/data/datasources/recruitment_remote_datasource.dart';
import '../../features/recruitment/data/repositories/recruitment_repository_impl.dart';
import '../../features/recruitment/domain/repositories/recruitment_repository.dart';
import '../../features/recruitment/domain/usecases/get_recruitment_menus.dart';
import '../../features/recruitment/presentation/providers/recruitment_provider.dart';

// Organizational Structure feature imports
import '../../features/settings/features/organizational_structure/data/datasources/organizational_structure_remote_data_source.dart';
import '../../features/settings/features/organizational_structure/data/repositories/organizational_structure_repository_impl.dart';
import '../../features/settings/features/organizational_structure/domain/repositories/organizational_structure_repository.dart';
import '../../features/settings/features/organizational_structure/domain/usecases/get_company_structure.dart';
import '../../features/settings/features/organizational_structure/domain/usecases/manage_structure_role.dart';
import '../../features/settings/features/organizational_structure/domain/usecases/manage_superior_employee.dart';
import '../../features/settings/features/organizational_structure/domain/usecases/get_organizational_data.dart';
import '../../features/settings/features/organizational_structure/domain/usecases/manage_job_title.dart';
import '../../features/settings/features/organizational_structure/domain/usecases/manage_department.dart';
import '../../features/settings/features/organizational_structure/domain/usecases/manage_employment_level.dart';
import '../../features/settings/features/organizational_structure/domain/usecases/manage_user_role.dart';
import '../../features/settings/features/organizational_structure/presentation/providers/job_title_provider.dart';
import '../../features/settings/features/organizational_structure/presentation/providers/department_provider.dart';
import '../../features/settings/features/organizational_structure/presentation/providers/employment_level_provider.dart';
import '../../features/settings/features/organizational_structure/presentation/providers/structure_provider.dart';
import '../../features/settings/features/organizational_structure/presentation/providers/user_role_provider.dart';

// Access Menu feature imports
import '../../features/settings/features/access_menu/data/datasources/access_menu_remote_data_source.dart';
import '../../features/settings/features/access_menu/data/repositories/access_menu_repository_impl.dart';
import '../../features/settings/features/access_menu/domain/repositories/access_menu_repository.dart';
import '../../features/settings/features/access_menu/domain/usecases/get_employee_menus.dart' as access_menu_usecases;
import '../../features/settings/features/access_menu/domain/usecases/get_all_menus.dart';
import '../../features/settings/features/access_menu/domain/usecases/manage_menu_access.dart';
import '../../features/settings/features/access_menu/presentation/providers/access_menu_provider.dart';

import '../../features/settings/features/access_menu/presentation/providers/employee_list_provider.dart';

// Permission feature imports
import '../../features/permissions/data/repositories/permission_repository_impl.dart';
import '../../features/permissions/domain/repositories/permission_repository.dart';
import '../../features/permissions/domain/usecases/check_permissions_status.dart';
import '../../features/permissions/domain/usecases/request_permissions.dart';
import '../../features/permissions/domain/usecases/open_settings.dart';
import '../../features/permissions/domain/usecases/is_permission_permanently_denied.dart';
import '../../features/permissions/domain/usecases/get_denied_permissions_detail.dart';
import '../../features/permissions/presentation/providers/permission_provider.dart';

// Access Screen feature imports
import '../../features/settings/features/access_screen/data/datasources/access_screen_remote_datasource.dart';
import '../../features/settings/features/access_screen/data/repositories/access_screen_repository_impl.dart';
import '../../features/settings/features/access_screen/domain/repositories/access_screen_repository.dart';
import '../../features/settings/features/access_screen/domain/usecases/get_access_screen.dart';
import '../../features/settings/features/access_screen/domain/usecases/update_access_screen.dart';
import '../../features/settings/features/access_screen/presentation/providers/access_screen_provider.dart';

// Screen Security feature imports
import '../../features/screen_security/data/datasources/screen_security_remote_datasource.dart';
import '../../features/screen_security/data/repositories/screen_security_repository_impl.dart';
import '../../features/screen_security/domain/repositories/screen_security_repository.dart';
import '../../features/screen_security/domain/usecases/get_screen_security_settings.dart';
import '../../features/screen_security/presentation/providers/screen_security_provider.dart';

// Pelacakan Jam Kerja feature imports
import '../../features/settings/features/pelacakan_jam_kerja/data/datasources/pelacakan_local_data_source.dart';
import '../../features/settings/features/pelacakan_jam_kerja/data/datasources/pelacakan_remote_data_source.dart';
import '../../features/settings/features/pelacakan_jam_kerja/data/repositories/pelacakan_repository_impl.dart';
import '../../features/settings/features/pelacakan_jam_kerja/domain/repositories/pelacakan_repository.dart';
import '../../features/settings/features/pelacakan_jam_kerja/domain/usecases/get_employees.dart';
import '../../features/settings/features/pelacakan_jam_kerja/domain/usecases/get_tracking_settings.dart';
import '../../features/settings/features/pelacakan_jam_kerja/domain/usecases/save_tracking_settings.dart';
import '../../features/settings/features/pelacakan_jam_kerja/presentation/providers/pelacakan_provider.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Features - Authentication
  // Provider
  sl.registerFactory(
    () => AuthProvider(
      login: sl(),
      logout: sl(),
      getCurrentUser: sl(),
      checkAuthStatus: sl(),
      register: sl(),
      saveLoginStatus: sl(),
      verifyCompanyCode: sl(),
      getProfile: sl(),
    ),
  );

  sl.registerFactory(
    () => ForgotPasswordProvider(
      sendOtpUseCase: sl(),
      verifyOtpUseCase: sl(),
      resetPasswordUseCase: sl(),
    ),
  );

  sl.registerFactory(() => AdminFaceProvider(uploadAdminPhoto: sl()));

  // Use cases
  sl.registerLazySingleton(() => Login(sl()));
  sl.registerLazySingleton(() => Logout(sl()));
  sl.registerLazySingleton(() => GetCurrentUser(sl()));
  sl.registerLazySingleton(() => CheckAuthStatus(sl()));
  sl.registerLazySingleton(() => Register(sl()));
  sl.registerLazySingleton(() => SaveLoginStatus(sl()));
  sl.registerLazySingleton(() => VerifyCompanyCode(sl()));

  sl.registerLazySingleton(() => SendOtp(sl()));
  sl.registerLazySingleton(() => VerifyOtp(sl()));
  sl.registerLazySingleton(() => ResetPassword(sl()));

  sl.registerLazySingleton(() => GetProfile(sl()));
  sl.registerLazySingleton(() => UploadAdminPhoto(sl()));

  // Repository
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(remoteDataSource: sl(), localDataSource: sl(), networkInfo: sl()),
  );

  sl.registerLazySingleton<ForgotPasswordRepository>(
    () => ForgotPasswordRepositoryImpl(remoteDataSource: sl(), networkInfo: sl()),
  );

  // Data sources
  sl.registerLazySingleton<AuthRemoteDataSource>(() => AuthRemoteDataSourceImpl(client: sl()));

  sl.registerLazySingleton<ForgotPasswordRemoteDataSource>(
    () => ForgotPasswordRemoteDataSourceImpl(client: sl()),
  );

  sl.registerLazySingleton<AuthLocalDataSource>(
    () => AuthLocalDataSourceImpl(sharedPreferences: sl()),
  );

  //! Features - Home
  // Provider
  sl.registerFactory(
    () => HomeProvider(
      getEmployeeProfile: sl(),
      getEmployeeMenus: sl(),
      getNotificationCount: sl(),
      getKpiSummary: sl(),
      getHierarchicalMenus: sl(),
    ),
  );

  sl.registerFactory(() => AdminHomeProvider(getAdminMenus: sl(), getNotificationCount: sl()));

  // Use cases
  sl.registerLazySingleton(() => GetEmployeeProfile(sl()));
  sl.registerLazySingleton(() => GetEmployeeMenus(sl()));
  sl.registerLazySingleton(() => GetAdminMenus(sl()));
  sl.registerLazySingleton(() => GetHierarchicalMenus(sl()));
  sl.registerLazySingleton(() => GetNotificationCount(sl()));
  sl.registerLazySingleton(() => GetKpiSummary(sl()));

  // Repository
  sl.registerLazySingleton<HomeRepository>(
    () => HomeRepositoryImpl(remoteDataSource: sl(), localDataSource: sl(), networkInfo: sl()),
  );

  // Data sources
  sl.registerLazySingleton<HomeRemoteDataSource>(() => HomeRemoteDataSourceImpl(client: sl()));

  sl.registerLazySingleton<HomeLocalDataSource>(
    () => HomeLocalDataSourceImpl(sharedPreferences: sl()),
  );

  //! Features - Profile
  // Provider
  sl.registerFactory(
    () => ProfileProvider(
      getEmployeeProfile: sl(),
      updateEmployeeProfile: sl(),
      updateProfilePicture: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => profile_usecases.GetEmployeeProfile(sl()));
  sl.registerLazySingleton(() => UpdateEmployeeProfile(sl()));
  sl.registerLazySingleton(() => UpdateProfilePicture(sl()));

  // Repository
  sl.registerLazySingleton<ProfileRepository>(
    () => ProfileRepositoryImpl(remoteDataSource: sl(), localDataSource: sl(), networkInfo: sl()),
  );

  // Data sources
  sl.registerLazySingleton<ProfileRemoteDataSource>(
    () => ProfileRemoteDataSourceImpl(client: sl(), sharedPreferences: sl()),
  );

  sl.registerLazySingleton<ProfileLocalDataSource>(
    () => ProfileLocalDataSourceImpl(sharedPreferences: sl()),
  );

  //! Features - Absensi
  // Provider
  sl.registerFactory(
    () => AttendanceProvider(
      getTodayAttendance: sl(),
      getAbsensiMenuIDs: sl(),
      submitAttendanceUseCase: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => GetTodayAttendance(sl()));
  sl.registerLazySingleton(() => GetAbsensiMenuIDs(sl()));
  sl.registerLazySingleton(() => SubmitAttendance(sl()));

  // Repository
  sl.registerLazySingleton<AttendanceRepository>(
    () => AttendanceRepositoryImpl(remoteDataSource: sl()),
  );

  // Data sources
  sl.registerLazySingleton<AttendanceRemoteDataSource>(
    () => AttendanceRemoteDataSourceImpl(client: sl()),
  );

  //! Features - Biodata
  sl.registerFactory(() => BiodataProvider(getBiodata: sl()));

  // Use cases
  sl.registerLazySingleton(() => GetBiodata(sl()));

  // Repository
  sl.registerLazySingleton<BiodataRepository>(() => BiodataRepositoryImpl(remoteDataSource: sl()));

  // Data sources
  sl.registerLazySingleton<BiodataRemoteDataSource>(
    () => BiodataRemoteDataSourceImpl(client: sl(), sharedPreferences: sl()),
  );

  //! Features - Recruitment
  // Provider
  sl.registerFactory(() => RecruitmentProvider(getRecruitmentMenus: sl()));

  // Use cases
  sl.registerLazySingleton(() => GetRecruitmentMenus(sl()));

  // Repository
  sl.registerLazySingleton<RecruitmentRepository>(
    () => RecruitmentRepositoryImpl(remoteDataSource: sl()),
  );

  // Data sources
  sl.registerLazySingleton<RecruitmentRemoteDataSource>(
    () => RecruitmentRemoteDataSourceImpl(client: sl()),
  );

  //! Features - Organizational Structure
  // Use cases
  sl.registerLazySingleton(() => GetCompanyStructure(sl()));
  sl.registerLazySingleton(() => ManageStructureRole(sl()));
  sl.registerLazySingleton(() => ManageSuperiorEmployee(sl()));
  sl.registerLazySingleton(() => GetOrganizationalData(sl()));
  sl.registerLazySingleton(() => ManageJobTitle(sl()));
  sl.registerLazySingleton(() => ManageDepartment(sl()));
  sl.registerLazySingleton(() => ManageEmploymentLevel(sl()));
  sl.registerLazySingleton(() => ManageUserRole(sl()));

  // Providers - Specialized
  sl.registerFactory(() => JobTitleProvider(getOrganizationalData: sl(), manageJobTitle: sl()));

  sl.registerFactory(() => DepartmentProvider(getOrganizationalData: sl(), manageDepartment: sl()));

  sl.registerFactory(
    () => EmploymentLevelProvider(getOrganizationalData: sl(), manageEmploymentLevel: sl()),
  );

  sl.registerFactory(
    () => StructureProvider(
      getCompanyStructure: sl(),
      manageStructureRole: sl(),
      manageSuperiorEmployee: sl(),
      getOrganizationalData: sl(),
    ),
  );

  sl.registerFactory(() => UserRoleProvider(getOrganizationalData: sl(), manageUserRole: sl()));

  // Repository
  sl.registerLazySingleton<OrganizationalStructureRepository>(
    () => OrganizationalStructureRepositoryImpl(remoteDataSource: sl()),
  );

  // Data sources
  sl.registerLazySingleton<OrganizationalStructureRemoteDataSource>(
    () => OrganizationalStructureRemoteDataSourceImpl(client: sl()),
  );

  //! Features - Access Menu
  // Provider
  sl.registerFactory(
    () => AccessMenuProvider(getEmployeeMenus: sl(), getAllMenus: sl(), manageMenuAccess: sl()),
  );

  sl.registerFactory(() => EmployeeListProvider(getOrganizationalData: sl()));

  // Use cases
  sl.registerLazySingleton(() => access_menu_usecases.GetEmployeeMenus(sl()));
  sl.registerLazySingleton(() => GetAllMenus(sl()));
  sl.registerLazySingleton(() => ManageMenuAccess(sl()));

  // Repository
  sl.registerLazySingleton<AccessMenuRepository>(
    () => AccessMenuRepositoryImpl(remoteDataSource: sl()),
  );

  // Data sources
  sl.registerLazySingleton<AccessMenuRemoteDataSource>(
    () => AccessMenuRemoteDataSourceImpl(client: sl()),
  );

  //! Features - Permissions
  // Provider
  sl.registerFactory(
    () => PermissionProvider(
      checkPermissionsStatus: sl(),
      requestPermissionsUseCase: sl(),
      openSettingsUseCase: sl(),
      isPermissionPermanentlyDeniedUseCase: sl(),
      getDeniedPermissionsDetailUseCase: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => CheckPermissionsStatus(sl()));
  sl.registerLazySingleton(() => RequestPermissions(sl()));
  sl.registerLazySingleton(() => OpenSettings(sl()));
  sl.registerLazySingleton(() => IsPermissionPermanentlyDenied(sl()));
  sl.registerLazySingleton(() => GetDeniedPermissionsDetail(sl()));

  // Repository
  sl.registerLazySingleton<PermissionRepository>(() => PermissionRepositoryImpl());

  //! Features - Access Screen
  // Provider
  sl.registerFactory(
    () => AccessScreenProvider(
      getAccessScreenList: sl(),
      getAccessScreenDetail: sl(),
      updateGlobalAccessScreen: sl(),
      updateDetailAccessScreen: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => GetAccessScreenList(sl()));
  sl.registerLazySingleton(() => GetAccessScreenDetail(sl()));
  sl.registerLazySingleton(() => UpdateGlobalAccessScreen(sl()));
  sl.registerLazySingleton(() => UpdateDetailAccessScreen(sl()));

  // Repository
  sl.registerLazySingleton<AccessScreenRepository>(
    () => AccessScreenRepositoryImpl(remoteDataSource: sl()),
  );

  // Data sources
  sl.registerLazySingleton<AccessScreenRemoteDataSource>(
    () => AccessScreenRemoteDataSourceImpl(client: sl()),
  );

  //! Features - Screen Security
  // Provider
  sl.registerFactory(() => ScreenSecurityProvider(getScreenSecuritySettings: sl()));

  // Use cases
  sl.registerLazySingleton(() => GetScreenSecuritySettings(sl()));

  // Repository
  sl.registerLazySingleton<ScreenSecurityRepository>(
    () => ScreenSecurityRepositoryImpl(remoteDataSource: sl()),
  );

  // Data sources
  sl.registerLazySingleton<ScreenSecurityRemoteDataSource>(
    () => ScreenSecurityRemoteDataSourceImpl(apiClient: sl()),
  );

  //! Features - Pelacakan Jam Kerja
  // Provider
  sl.registerFactory(
    () => PelacakanProvider(
      getTrackingSettings: sl(),
      getEmployees: sl(),
      saveTrackingSettings: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => GetTrackingSettings(sl()));
  sl.registerLazySingleton(() => GetEmployees(sl()));
  sl.registerLazySingleton(() => SaveTrackingSettings(sl()));

  // Repository
  sl.registerLazySingleton<PelacakanRepository>(
    () => PelacakanRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
    ),
  );

  // Data sources
  sl.registerLazySingleton<PelacakanRemoteDataSource>(
    () => PelacakanRemoteDataSourceImpl(apiClient: sl()),
  );

  sl.registerLazySingleton<PelacakanLocalDataSource>(
    () => PelacakanLocalDataSourceImpl(sharedPreferences: sl()),
  );

  //! Core
  // Network
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  // API Client
  sl.registerLazySingleton<ApiClient>(() => ApiClient());

  //! External Dependencies
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
