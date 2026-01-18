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
import '../../features/authentication/presentation/providers/auth_provider.dart';

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
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => Login(sl()));
  sl.registerLazySingleton(() => Logout(sl()));
  sl.registerLazySingleton(() => GetCurrentUser(sl()));
  sl.registerLazySingleton(() => CheckAuthStatus(sl()));
  sl.registerLazySingleton(() => Register(sl()));

  // Repository
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  // Data sources
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(client: sl()),
  );

  sl.registerLazySingleton<AuthLocalDataSource>(
    () => AuthLocalDataSourceImpl(sharedPreferences: sl()),
  );

  //! Core
  // Network
  sl.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(sl()),
  );
  
  // API Client
  sl.registerLazySingleton<ApiClient>(() => ApiClient());

  //! External Dependencies
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
