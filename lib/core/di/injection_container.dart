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
import '../../features/authentication/presentation/providers/auth_provider.dart';

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
import '../../features/home/domain/usecases/get_kpi_summary.dart';
import '../../features/home/domain/usecases/get_notification_count.dart';
import '../../features/home/presentation/providers/home_provider.dart';

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
    ),
  );

  sl.registerFactory(
    () => ForgotPasswordProvider(
      sendOtpUseCase: sl(),
      verifyOtpUseCase: sl(),
      resetPasswordUseCase: sl(),
    ),
  );

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
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => GetEmployeeProfile(sl()));
  sl.registerLazySingleton(() => GetEmployeeMenus(sl()));
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
