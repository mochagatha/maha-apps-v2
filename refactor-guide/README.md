# MAHA Apps V2 Refactor Guide

## Table of Contents
1. [Overview](#overview)
2. [Architecture](#architecture)
3. [SOLID Principles](#solid-principles)
4. [Project Structure](#project-structure)
5. [API Compatibility](#api-compatibility)
6. [Internationalization (i18n)](#internationalization-i18n)
7. [UI/UX Consistency](#uiux-consistency)
8. [State Management](#state-management)
9. [Dependency Injection](#dependency-injection)
10. [Error Handling](#error-handling)
11. [Testing Strategy](#testing-strategy)
12. [Migration Checklist](#migration-checklist)

---

## Overview

MAHA Apps V2 is a complete refactor of V1 using **Clean Architecture** principles. The main goals are:

- ✅ **Maintainability**: Easier to understand, modify, and extend
- ✅ **Testability**: Comprehensive unit, widget, and integration tests
- ✅ **Scalability**: Support for growing features and team size
- ✅ **Separation of Concerns**: Clear boundaries between layers
- ✅ **API Compatibility**: Direct compatibility with existing V1 backend APIs
- ✅ **UI/UX Consistency**: Identical user experience to V1

---

## Architecture

### Clean Architecture Layers

```
┌─────────────────────────────────────────────────┐
│           Presentation Layer                    │
│  (UI, Widgets, Pages, Providers)               │
│  - Depends on: Domain Layer                     │
└─────────────────────────────────────────────────┘
                    ↓
┌─────────────────────────────────────────────────┐
│              Domain Layer                       │
│  (Entities, Use Cases, Repository Interfaces)  │
│  - No dependencies on other layers              │
│  - Pure Dart (no Flutter)                       │
└─────────────────────────────────────────────────┘
                    ↓
┌─────────────────────────────────────────────────┐
│               Data Layer                        │
│  (Models, Repository Impl, Data Sources)       │
│  - Depends on: Domain Layer                     │
└─────────────────────────────────────────────────┘
                    ↓
┌─────────────────────────────────────────────────┐
│            External Dependencies                │
│  (API, Database, SharedPreferences)            │
└─────────────────────────────────────────────────┘
```

### Dependency Rule

**The Dependency Rule**: Source code dependencies must point **inward** only.

- **Presentation** depends on **Domain**
- **Data** depends on **Domain**
- **Domain** depends on **nothing** (pure business logic)

---

## SOLID Principles

### 1. Single Responsibility Principle (SRP)

**Each class should have only one reason to change.**

✅ **Good Example:**
```dart
// ✅ Single responsibility: Handle employee profile data
class GetEmployeeProfile implements UseCase<Employee, NoParams> {
  final HomeRepository repository;
  
  GetEmployeeProfile(this.repository);
  
  @override
  Future<Either<Failure, Employee>> call(NoParams params) async {
    return await repository.getEmployeeProfile();
  }
}
```

❌ **Bad Example:**
```dart
// ❌ Multiple responsibilities: Data fetching + UI logic + caching
class EmployeeManager {
  Future<void> fetchAndDisplayEmployee() {
    // Fetches data
    // Updates UI
    // Caches data
    // Handles errors
  }
}
```

### 2. Open/Closed Principle (OCP)

**Open for extension, closed for modification.**

✅ **Good Example:**
```dart
// ✅ Abstract interface - can be extended without modification
abstract class AuthRepository {
  Future<Either<Failure, User>> login(LoginParams params);
  Future<Either<Failure, void>> logout();
}

// New implementation without modifying interface
class AuthRepositoryImpl implements AuthRepository {
  // Implementation
}
```

### 3. Liskov Substitution Principle (LSP)

**Subtypes must be substitutable for their base types.**

✅ **Good Example:**
```dart
// ✅ All implementations can be used interchangeably
abstract class DataSource {
  Future<Data> getData();
}

class RemoteDataSource implements DataSource {
  @override
  Future<Data> getData() => fetchFromAPI();
}

class LocalDataSource implements DataSource {
  @override
  Future<Data> getData() => fetchFromCache();
}
```

### 4. Interface Segregation Principle (ISP)

**Clients should not depend on interfaces they don't use.**

✅ **Good Example:**
```dart
// ✅ Separate interfaces for different concerns
abstract class Readable {
  Future<Data> read();
}

abstract class Writable {
  Future<void> write(Data data);
}

// Implement only what's needed
class ReadOnlyCache implements Readable {
  @override
  Future<Data> read() => // implementation
}
```

### 5. Dependency Inversion Principle (DIP)

**Depend on abstractions, not concretions.**

✅ **Good Example:**
```dart
// ✅ Depends on abstraction (HomeRepository)
class HomeProvider {
  final GetEmployeeProfile getEmployeeProfile;
  
  HomeProvider({required this.getEmployeeProfile});
}

// ✅ Use case depends on repository interface
class GetEmployeeProfile {
  final HomeRepository repository; // Abstract interface
  
  GetEmployeeProfile(this.repository);
}
```

❌ **Bad Example:**
```dart
// ❌ Depends on concrete implementation
class HomeProvider {
  final HomeRepositoryImpl repository; // Concrete class
  
  HomeProvider({required this.repository});
}
```

---

## Project Structure

```
lib/
├── core/                           # Core utilities and shared code
│   ├── di/                        # Dependency Injection
│   │   └── injection_container.dart
│   ├── error/                     # Error handling
│   │   ├── exceptions.dart
│   │   └── failures.dart
│   ├── network/                   # Network utilities
│   │   ├── api_client.dart
│   │   └── network_info.dart
│   ├── router/                    # Navigation
│   │   ├── app_router.dart
│   │   ├── route_names.dart
│   │   └── route_paths.dart
│   ├── usecases/                  # Base use case
│   │   └── usecase.dart
│   └── utils/                     # Utilities
│       ├── constants.dart
│       └── localization_extension.dart
│
├── features/                       # Feature modules
│   ├── authentication/            # Auth feature
│   │   ├── data/
│   │   │   ├── datasources/
│   │   │   │   ├── auth_local_datasource.dart
│   │   │   │   └── auth_remote_datasource.dart
│   │   │   ├── models/
│   │   │   │   ├── login_response_model.dart
│   │   │   │   └── user_model.dart
│   │   │   └── repositories/
│   │   │       └── auth_repository_impl.dart
│   │   ├── domain/
│   │   │   ├── entities/
│   │   │   │   └── user.dart
│   │   │   ├── repositories/
│   │   │   │   └── auth_repository.dart
│   │   │   └── usecases/
│   │   │       ├── login.dart
│   │   │       ├── logout.dart
│   │   │       └── register.dart
│   │   └── presentation/
│   │       ├── pages/
│   │       │   ├── login_page.dart
│   │       │   └── register_page.dart
│   │       ├── providers/
│   │       │   └── auth_provider.dart
│   │       └── widgets/
│   │           └── pin_verification_dialog.dart
│   │
│   ├── home/                      # Home feature
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   │
│   └── splash/                    # Splash feature
│       └── presentation/
│
├── l10n/                          # Localization files
│   ├── app_en.arb
│   └── app_id.arb
│
├── shared/                        # Shared UI components
│   └── theme/
│       └── app_theme.dart
│
└── main.dart                      # App entry point
```

### Feature Module Structure

Each feature follows this structure:

```
feature_name/
├── data/
│   ├── datasources/
│   │   ├── feature_local_datasource.dart
│   │   └── feature_remote_datasource.dart
│   ├── models/
│   │   └── feature_model.dart
│   └── repositories/
│       └── feature_repository_impl.dart
├── domain/
│   ├── entities/
│   │   └── feature_entity.dart
│   ├── repositories/
│   │   └── feature_repository.dart
│   └── usecases/
│       └── feature_usecase.dart
└── presentation/
    ├── pages/
    │   └── feature_page.dart
    ├── providers/
    │   └── feature_provider.dart
    └── widgets/
        └── feature_widget.dart
```

---

## API Compatibility

### V1 to V2 API Mapping

**Goal**: V2 must work with existing V1 backend APIs **without any backend changes**.

### Authentication APIs

| V1 Endpoint | V2 Endpoint | Method | Request Body | Response |
|-------------|-------------|--------|--------------|----------|
| `/auth/login` | `/auth/login` | POST | `{email, password}` | `{token, user}` |
| `/auth/register` | `/auth/register` | POST | `{fullname, email, password}` | `{message, user}` |
| `/auth/logout` | `/auth/logout` | POST | - | `{message}` |

### Home APIs

| V1 Endpoint | V2 Endpoint | Method | Response |
|-------------|-------------|--------|----------|
| `/employee/profile` | `/employee/profile` | GET | `{data: Employee}` |
| `/menu/employee` | `/menu/employee` | GET | `{data: [MenuItem]}` |
| `/notification/count` | `/notification/count` | GET | `{data: NotificationCount}` |

### API Client Configuration

```dart
// core/network/api_client.dart
class ApiClient {
  final Dio _dio;
  
  ApiClient() : _dio = Dio() {
    _dio.options.baseUrl = dotenv.env['API_BASE_URL'] ?? '';
    _dio.options.connectTimeout = const Duration(seconds: 30);
    _dio.options.receiveTimeout = const Duration(seconds: 30);
    
    // Add interceptors for token, logging, etc.
    _dio.interceptors.add(AuthInterceptor());
    _dio.interceptors.add(LoggingInterceptor());
  }
}
```

### Response Format Compatibility

V1 and V2 must handle the same response format:

```json
{
  "code": 200,
  "message": "Success",
  "data": {
    // Actual data here
  }
}
```

**Data Layer Handling:**
```dart
// Always extract 'data' field from response
if (response.statusCode == 200) {
  return EmployeeModel.fromJson(response.data['data']);
}
```

---

## Internationalization (i18n)

### Setup

V2 uses Flutter's official `intl` package with ARB files.

**Configuration (`l10n.yaml`):**
```yaml
arb-dir: lib/l10n
template-arb-file: app_id.arb
output-localization-file: app_localizations.dart
```

**Supported Languages:**
- 🇮🇩 Indonesian (default) - `app_id.arb`
- 🇬🇧 English - `app_en.arb`

### ARB File Structure

**`lib/l10n/app_id.arb`:**
```json
{
  "@@locale": "id",
  "appName": "MAHA Apps",
  "@appName": {
    "description": "Application name"
  },
  "login": "Masuk",
  "@login": {
    "description": "Login button text"
  }
}
```

### Usage in Code

**Extension Helper:**
```dart
// core/utils/localization_extension.dart
extension LocalizationExtension on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this)!;
}
```

**In Widgets:**
```dart
import 'package:maha_apps_v2/core/utils/localization_extension.dart';

Text(context.l10n.login)
Text(context.l10n.email)
Text(context.l10n.password)
```

### Adding New Strings

1. Add to `app_id.arb` (Indonesian)
2. Add to `app_en.arb` (English)
3. Run `flutter gen-l10n` or rebuild app
4. Use `context.l10n.yourNewString`

---

## UI/UX Consistency

### Design Principles

**V2 must maintain identical UI/UX to V1:**

1. **Same Color Scheme**
2. **Same Typography**
3. **Same Layout Structure**
4. **Same User Flows**
5. **Same Animations**

### Theme Configuration

**`shared/theme/app_theme.dart`:**
```dart
class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: AppColors.primary,
      scaffoldBackgroundColor: AppColors.background,
      fontFamily: 'Poppins',
      // Match V1 theme exactly
    );
  }
}
```

### Color Palette (Match V1)

```dart
class AppColors {
  // Primary colors (from V1)
  static const Color primary = Color(0xFF1976D2);
  static const Color secondary = Color(0xFF424242);
  
  // Neutral colors
  static const Color neutral1 = Color(0xFFFFFFFF);
  static const Color neutral2 = Color(0xFFF5F5F5);
  static const Color neutral3 = Color(0xFFEEEEEE);
  // ... match all V1 colors
}
```

### Component Consistency

| Component | V1 | V2 | Status |
|-----------|----|----|--------|
| Login Form | GetX | Provider | ✅ Same UI |
| Profile Card | GetX | Provider | ✅ Same UI |
| Menu Grid | GetX | Provider | ✅ Same UI |
| Bottom Nav | GetX | GoRouter | ✅ Same UI |

---

## State Management

### Provider Pattern

V2 uses **Provider** for state management (replacing GetX from V1).

**Provider Structure:**
```dart
class FeatureProvider extends ChangeNotifier {
  // State
  FeatureStatus _status = FeatureStatus.initial;
  Data? _data;
  String? _errorMessage;
  
  // Getters
  FeatureStatus get status => _status;
  Data? get data => _data;
  bool get isLoading => _status == FeatureStatus.loading;
  
  // Methods
  Future<void> loadData() async {
    _status = FeatureStatus.loading;
    notifyListeners();
    
    final result = await useCase(params);
    
    result.fold(
      (failure) {
        _status = FeatureStatus.error;
        _errorMessage = failure.message;
      },
      (data) {
        _status = FeatureStatus.loaded;
        _data = data;
      },
    );
    
    notifyListeners();
  }
}
```

**Usage in Widgets:**
```dart
// Provide
ChangeNotifierProvider(
  create: (_) => di.sl<FeatureProvider>(),
)

// Consume
Consumer<FeatureProvider>(
  builder: (context, provider, child) {
    if (provider.isLoading) return LoadingWidget();
    return DataWidget(data: provider.data);
  },
)

// Or use context
context.read<FeatureProvider>().loadData();
context.watch<FeatureProvider>().data;
```

---

## Dependency Injection

### GetIt Setup

V2 uses **GetIt** for dependency injection.

**Registration (`core/di/injection_container.dart`):**
```dart
final sl = GetIt.instance;

Future<void> init() async {
  //! Features
  // Provider (Factory - new instance each time)
  sl.registerFactory(() => FeatureProvider(useCase: sl()));
  
  // Use Cases (Lazy Singleton - created when first used)
  sl.registerLazySingleton(() => FeatureUseCase(sl()));
  
  // Repository (Lazy Singleton)
  sl.registerLazySingleton<FeatureRepository>(
    () => FeatureRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );
  
  // Data Sources (Lazy Singleton)
  sl.registerLazySingleton<FeatureRemoteDataSource>(
    () => FeatureRemoteDataSourceImpl(client: sl()),
  );
  
  sl.registerLazySingleton<FeatureLocalDataSource>(
    () => FeatureLocalDataSourceImpl(sharedPreferences: sl()),
  );
  
  //! Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
  sl.registerLazySingleton<ApiClient>(() => ApiClient());
  
  //! External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
```

**Usage:**
```dart
// In main.dart
await di.init();

// In providers
ChangeNotifierProvider(create: (_) => di.sl<FeatureProvider>())
```

---

## Error Handling

### Failure Classes

**`core/error/failures.dart`:**
```dart
abstract class Failure extends Equatable {
  final String message;
  
  const Failure(this.message);
  
  @override
  List<Object> get props => [message];
}

class ServerFailure extends Failure {
  const ServerFailure(String message) : super(message);
}

class CacheFailure extends Failure {
  const CacheFailure(String message) : super(message);
}

class NetworkFailure extends Failure {
  const NetworkFailure(String message) : super(message);
}
```

### Exception Classes

**`core/error/exceptions.dart`:**
```dart
class ServerException implements Exception {
  final String message;
  
  ServerException(this.message);
}

class CacheException implements Exception {
  final String message;
  
  CacheException(this.message);
}
```

### Error Handling Pattern

```dart
// In Repository
try {
  final data = await remoteDataSource.getData();
  return Right(data);
} on ServerException catch (e) {
  return Left(ServerFailure(e.message));
} on Exception catch (e) {
  return Left(ServerFailure(e.toString()));
}

// In Provider
result.fold(
  (failure) {
    _errorMessage = failure.message;
    _status = Status.error;
  },
  (data) {
    _data = data;
    _status = Status.loaded;
  },
);
```

---

## Testing Strategy

### Test Pyramid

```
        /\
       /  \
      / E2E \          ← Few (Integration Tests)
     /______\
    /        \
   /  Widget  \        ← Some (Widget Tests)
  /____________\
 /              \
/   Unit Tests   \     ← Many (Unit Tests)
/__________________\
```

### Unit Tests

**Test all business logic:**
- ✅ Use Cases
- ✅ Repositories
- ✅ Data Sources
- ✅ Models

**Example:**
```dart
// test/features/home/domain/usecases/get_employee_profile_test.dart
void main() {
  late GetEmployeeProfile useCase;
  late MockHomeRepository mockRepository;
  
  setUp(() {
    mockRepository = MockHomeRepository();
    useCase = GetEmployeeProfile(mockRepository);
  });
  
  test('should get employee from repository', () async {
    // arrange
    when(mockRepository.getEmployeeProfile())
        .thenAnswer((_) async => Right(tEmployee));
    
    // act
    final result = await useCase(NoParams());
    
    // assert
    expect(result, Right(tEmployee));
    verify(mockRepository.getEmployeeProfile());
  });
}
```

### Widget Tests

**Test UI components:**
- ✅ Pages
- ✅ Widgets
- ✅ User interactions

### Integration Tests

**Test complete flows:**
- ✅ Login flow
- ✅ Registration flow
- ✅ Home data loading

---

## Migration Checklist

### For Each Feature

- [ ] **1. Analyze V1 Implementation**
  - [ ] Identify UI components
  - [ ] Identify data models
  - [ ] Identify API endpoints
  - [ ] Identify business logic

- [ ] **2. Create Domain Layer**
  - [ ] Define entities
  - [ ] Create repository interface
  - [ ] Implement use cases

- [ ] **3. Create Data Layer**
  - [ ] Create models with JSON serialization
  - [ ] Implement remote data source
  - [ ] Implement local data source (if needed)
  - [ ] Implement repository

- [ ] **4. Create Presentation Layer**
  - [ ] Create provider
  - [ ] Create pages
  - [ ] Create widgets

- [ ] **5. Integration**
  - [ ] Add to dependency injection
  - [ ] Add routes
  - [ ] Add to main providers

- [ ] **6. i18n**
  - [ ] Add strings to ARB files
  - [ ] Replace hardcoded strings

- [ ] **7. Testing**
  - [ ] Write unit tests
  - [ ] Write widget tests
  - [ ] Manual testing

- [ ] **8. Verification**
  - [ ] UI matches V1
  - [ ] API calls work correctly
  - [ ] Error handling works
  - [ ] Offline mode works (if applicable)

---

## Best Practices

### DO ✅

- ✅ Follow Clean Architecture layers strictly
- ✅ Use dependency injection for all dependencies
- ✅ Write tests for all business logic
- ✅ Use meaningful variable and function names
- ✅ Keep functions small and focused
- ✅ Use const constructors where possible
- ✅ Handle all error cases
- ✅ Add documentation for complex logic
- ✅ Use i18n for all user-facing strings
- ✅ Match V1 UI/UX exactly

### DON'T ❌

- ❌ Mix layers (e.g., UI logic in domain)
- ❌ Use concrete classes in constructors (use abstractions)
- ❌ Hardcode strings (use i18n)
- ❌ Ignore error handling
- ❌ Skip tests
- ❌ Change V1 API contracts
- ❌ Modify V1 UI/UX without approval
- ❌ Use GetX (use Provider instead)
- ❌ Create god classes (violates SRP)

---

## Summary

This refactor guide provides the foundation for migrating MAHA Apps from V1 to V2 using Clean Architecture. Key principles:

1. **Clean Architecture** with clear layer separation
2. **SOLID Principles** for maintainable code
3. **API Compatibility** with V1 backend
4. **UI/UX Consistency** with V1 frontend
5. **i18n Support** for Indonesian and English
6. **Provider** for state management
7. **GetIt** for dependency injection
8. **Comprehensive Testing** at all levels

Follow this guide for all feature migrations to ensure consistency and quality across the V2 codebase.
