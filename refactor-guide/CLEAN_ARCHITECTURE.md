# Clean Architecture Detailed Guide

## What is Clean Architecture?

Clean Architecture is a software design philosophy that emphasizes **separation of concerns** through **layered architecture**. It was introduced by Robert C. Martin (Uncle Bob).

## Core Principles

### 1. Independence

The architecture should be independent of:
- **Frameworks**: Not tied to Flutter, GetX, Provider, etc.
- **UI**: Can change UI without changing business rules
- **Database**: Can swap databases without affecting business logic
- **External agencies**: Business rules don't know about external interfaces

### 2. Testability

Business rules can be tested without:
- UI
- Database
- Web server
- Any external element

### 3. The Dependency Rule

**Source code dependencies must point inward only.**

```
Presentation → Domain ← Data
     ↓           ↑        ↓
   (UI)    (Business)  (API/DB)
```

---

## Layer Breakdown

### Domain Layer (Innermost)

**Purpose**: Contains business logic and business rules.

**Components**:
- **Entities**: Business objects (e.g., `User`, `Employee`)
- **Use Cases**: Application-specific business rules
- **Repository Interfaces**: Contracts for data access

**Rules**:
- ✅ Pure Dart (no Flutter imports)
- ✅ No dependencies on other layers
- ✅ Contains only business logic
- ❌ No UI code
- ❌ No database code
- ❌ No network code

**Example**:
```dart
// domain/entities/employee.dart
class Employee extends Equatable {
  final int id;
  final String fullname;
  final String email;
  
  const Employee({
    required this.id,
    required this.fullname,
    required this.email,
  });
  
  @override
  List<Object?> get props => [id, fullname, email];
}

// domain/usecases/get_employee_profile.dart
class GetEmployeeProfile implements UseCase<Employee, NoParams> {
  final HomeRepository repository;
  
  GetEmployeeProfile(this.repository);
  
  @override
  Future<Either<Failure, Employee>> call(NoParams params) async {
    return await repository.getEmployeeProfile();
  }
}

// domain/repositories/home_repository.dart
abstract class HomeRepository {
  Future<Either<Failure, Employee>> getEmployeeProfile();
}
```

---

### Data Layer

**Purpose**: Implements data access and manages data sources.

**Components**:
- **Models**: Data transfer objects with JSON serialization
- **Repository Implementations**: Concrete implementations of repository interfaces
- **Data Sources**: Remote (API) and Local (Cache) data sources

**Rules**:
- ✅ Implements domain repository interfaces
- ✅ Handles data serialization/deserialization
- ✅ Manages caching strategies
- ✅ Depends on domain layer
- ❌ No UI code
- ❌ No business logic

**Example**:
```dart
// data/models/employee_model.dart
class EmployeeModel extends Employee {
  const EmployeeModel({
    required int id,
    required String fullname,
    required String email,
  }) : super(id: id, fullname: fullname, email: email);
  
  factory EmployeeModel.fromJson(Map<String, dynamic> json) {
    return EmployeeModel(
      id: json['id'],
      fullname: json['fullname'],
      email: json['email'],
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullname': fullname,
      'email': email,
    };
  }
}

// data/datasources/home_remote_datasource.dart
abstract class HomeRemoteDataSource {
  Future<EmployeeModel> getEmployeeProfile();
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final ApiClient client;
  
  HomeRemoteDataSourceImpl({required this.client});
  
  @override
  Future<EmployeeModel> getEmployeeProfile() async {
    final response = await client.get('/employee/profile');
    
    if (response.statusCode == 200) {
      return EmployeeModel.fromJson(response.data['data']);
    } else {
      throw ServerException('Failed to get employee profile');
    }
  }
}

// data/repositories/home_repository_impl.dart
class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource remoteDataSource;
  final HomeLocalDataSource localDataSource;
  final NetworkInfo networkInfo;
  
  HomeRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });
  
  @override
  Future<Either<Failure, Employee>> getEmployeeProfile() async {
    if (await networkInfo.isConnected) {
      try {
        final employeeModel = await remoteDataSource.getEmployeeProfile();
        await localDataSource.cacheEmployeeProfile(employeeModel);
        return Right(employeeModel);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      }
    } else {
      try {
        final cachedEmployee = await localDataSource.getCachedEmployeeProfile();
        if (cachedEmployee != null) {
          return Right(cachedEmployee);
        } else {
          return Left(CacheFailure('No cached data'));
        }
      } on CacheException catch (e) {
        return Left(CacheFailure(e.message));
      }
    }
  }
}
```

---

### Presentation Layer (Outermost)

**Purpose**: Handles UI and user interactions.

**Components**:
- **Pages**: Full-screen UI components
- **Widgets**: Reusable UI components
- **Providers**: State management (using Provider pattern)

**Rules**:
- ✅ Depends on domain layer
- ✅ Manages UI state
- ✅ Handles user input
- ✅ Displays data from domain
- ❌ No business logic
- ❌ No direct data access

**Example**:
```dart
// presentation/providers/home_provider.dart
class HomeProvider extends ChangeNotifier {
  final GetEmployeeProfile getEmployeeProfile;
  
  HomeProvider({required this.getEmployeeProfile});
  
  HomeStatus _status = HomeStatus.initial;
  Employee? _employee;
  String? _errorMessage;
  
  HomeStatus get status => _status;
  Employee? get employee => _employee;
  bool get isLoading => _status == HomeStatus.loading;
  
  Future<void> loadEmployeeProfile() async {
    _status = HomeStatus.loading;
    notifyListeners();
    
    final result = await getEmployeeProfile(NoParams());
    
    result.fold(
      (failure) {
        _status = HomeStatus.error;
        _errorMessage = failure.message;
      },
      (employee) {
        _status = HomeStatus.loaded;
        _employee = employee;
      },
    );
    
    notifyListeners();
  }
}

// presentation/pages/home_page.dart
class HomePage extends StatefulWidget {
  const HomePage({super.key});
  
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HomeProvider>().loadEmployeeProfile();
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<HomeProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          
          if (provider.employee != null) {
            return ProfileWidget(employee: provider.employee!);
          }
          
          return const Center(child: Text('No data'));
        },
      ),
    );
  }
}
```

---

## Data Flow

### Reading Data (API → UI)

```
1. UI triggers action
   ↓
2. Provider calls Use Case
   ↓
3. Use Case calls Repository (interface)
   ↓
4. Repository Implementation decides: Remote or Cache?
   ↓
5. Data Source fetches data
   ↓
6. Model converts JSON to Entity
   ↓
7. Repository returns Either<Failure, Entity>
   ↓
8. Use Case returns result to Provider
   ↓
9. Provider updates state
   ↓
10. UI rebuilds with new data
```

### Writing Data (UI → API)

```
1. UI triggers action with data
   ↓
2. Provider calls Use Case with params
   ↓
3. Use Case calls Repository
   ↓
4. Repository calls Remote Data Source
   ↓
5. Data Source sends to API
   ↓
6. Response comes back
   ↓
7. Repository caches if needed
   ↓
8. Returns Either<Failure, Success>
   ↓
9. Provider updates state
   ↓
10. UI shows success/error
```

---

## Benefits

### 1. Testability

Each layer can be tested independently:

```dart
// Test Use Case without UI or API
test('should get employee from repository', () async {
  // Mock repository
  when(mockRepository.getEmployeeProfile())
      .thenAnswer((_) async => Right(tEmployee));
  
  // Test use case
  final result = await useCase(NoParams());
  
  // Verify
  expect(result, Right(tEmployee));
});
```

### 2. Maintainability

Changes in one layer don't affect others:

- Change UI framework? Only update Presentation layer
- Change database? Only update Data layer
- Change business rules? Only update Domain layer

### 3. Scalability

Easy to add new features:

```
features/
├── authentication/
├── home/
├── profile/        ← Add new feature
├── attendance/     ← Add new feature
└── payroll/        ← Add new feature
```

### 4. Team Collaboration

Different teams can work on different layers:

- **Backend team**: Data layer (API integration)
- **Business team**: Domain layer (business rules)
- **Frontend team**: Presentation layer (UI/UX)

---

## Common Mistakes

### ❌ Mixing Layers

```dart
// ❌ BAD: UI logic in domain
class GetEmployeeProfile {
  Future<void> call() async {
    showDialog(...); // UI code in domain!
  }
}

// ✅ GOOD: Pure business logic
class GetEmployeeProfile {
  Future<Either<Failure, Employee>> call() async {
    return await repository.getEmployeeProfile();
  }
}
```

### ❌ Depending on Concrete Classes

```dart
// ❌ BAD: Depends on implementation
class HomeProvider {
  final HomeRepositoryImpl repository; // Concrete!
}

// ✅ GOOD: Depends on abstraction
class HomeProvider {
  final HomeRepository repository; // Interface!
}
```

### ❌ Business Logic in Presentation

```dart
// ❌ BAD: Validation in UI
class LoginPage extends StatelessWidget {
  void login() {
    if (email.contains('@') && password.length > 6) { // Business rule!
      // login
    }
  }
}

// ✅ GOOD: Validation in domain
class LoginUseCase {
  Future<Either<Failure, User>> call(LoginParams params) async {
    if (!_isValidEmail(params.email)) {
      return Left(ValidationFailure('Invalid email'));
    }
    // ...
  }
}
```

---

## Summary

Clean Architecture provides:

- ✅ **Clear separation** of concerns
- ✅ **Independent** layers
- ✅ **Testable** code
- ✅ **Maintainable** codebase
- ✅ **Scalable** structure
- ✅ **Flexible** for changes

Follow the **Dependency Rule**: dependencies point **inward** only!
