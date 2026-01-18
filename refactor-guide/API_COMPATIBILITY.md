# API Compatibility Guide

## Overview

V2 must maintain **100% compatibility** with V1 backend APIs. No backend changes are required for V2 to work.

---

## API Base Configuration

### Environment Variables

**`.env` file:**
```env
API_BASE_URL=https://api.maha.com/v1
API_TIMEOUT=30000
```

### API Client Setup

**`core/network/api_client.dart`:**
```dart
class ApiClient {
  final Dio _dio;
  
  ApiClient() : _dio = Dio() {
    _dio.options.baseUrl = dotenv.env['API_BASE_URL'] ?? '';
    _dio.options.connectTimeout = const Duration(seconds: 30);
    _dio.options.receiveTimeout = const Duration(seconds: 30);
    
    // Add interceptors
    _dio.interceptors.add(AuthInterceptor());
    _dio.interceptors.add(LoggingInterceptor());
    _dio.interceptors.add(ErrorInterceptor());
  }
  
  Future<Response> get(String path, {Map<String, dynamic>? queryParameters}) {
    return _dio.get(path, queryParameters: queryParameters);
  }
  
  Future<Response> post(String path, {dynamic data}) {
    return _dio.post(path, data: data);
  }
  
  Future<Response> put(String path, {dynamic data}) {
    return _dio.put(path, data: data);
  }
  
  Future<Response> delete(String path) {
    return _dio.delete(path);
  }
}
```

---

## Standard Response Format

### V1 Response Structure

All V1 APIs return this format:

```json
{
  "code": 200,
  "message": "Success",
  "data": {
    // Actual data here
  }
}
```

### Handling in V2

**Always extract `data` field:**

```dart
// In Remote Data Source
Future<EmployeeModel> getEmployeeProfile() async {
  final response = await client.get('/employee/profile');
  
  if (response.statusCode == 200) {
    // Extract 'data' field
    return EmployeeModel.fromJson(response.data['data']);
  } else {
    throw ServerException(
      response.data['message'] ?? 'Unknown error',
    );
  }
}
```

---

## Authentication APIs

### 1. Login

**Endpoint**: `POST /auth/login`

**V1 Request:**
```json
{
  "email": "user@example.com",
  "password": "password123"
}
```

**V1 Response:**
```json
{
  "code": 200,
  "message": "Login successful",
  "data": {
    "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
    "refresh_token": "refresh_token_here",
    "user": {
      "id": 1,
      "fullname": "John Doe",
      "email": "user@example.com",
      "job_title_id": 5,
      "job_title_name": "Software Engineer"
    }
  }
}
```

**V2 Implementation:**
```dart
// data/datasources/auth_remote_datasource.dart
@override
Future<LoginResponseModel> login(LoginParams params) async {
  final response = await client.post(
    AppConstants.endpointLogin,
    data: {
      'email': params.email,
      'password': params.password,
    },
  );
  
  if (response.statusCode == 200) {
    return LoginResponseModel.fromJson(response.data['data']);
  } else {
    throw ServerException(response.data['message']);
  }
}
```

### 2. Register

**Endpoint**: `POST /auth/register`

**V1 Request:**
```json
{
  "fullname": "Jane Doe",
  "email": "jane@example.com",
  "password": "password123"
}
```

**V1 Response:**
```json
{
  "code": 201,
  "message": "Registration successful",
  "data": {
    "id": 2,
    "fullname": "Jane Doe",
    "email": "jane@example.com"
  }
}
```

**V2 Implementation:**
```dart
@override
Future<RegisterResponseModel> register(RegisterParams params) async {
  final response = await client.post(
    AppConstants.endpointRegister,
    data: {
      'fullname': params.fullname,
      'email': params.email,
      'password': params.password,
    },
  );
  
  if (response.statusCode == 201 || response.statusCode == 200) {
    return RegisterResponseModel.fromJson(response.data['data']);
  } else {
    throw ServerException(response.data['message']);
  }
}
```

### 3. Logout

**Endpoint**: `POST /auth/logout`

**V1 Request:** (No body, uses token from header)

**V1 Response:**
```json
{
  "code": 200,
  "message": "Logout successful",
  "data": null
}
```

**V2 Implementation:**
```dart
@override
Future<void> logout() async {
  final response = await client.post(AppConstants.endpointLogout);
  
  if (response.statusCode != 200) {
    throw ServerException(response.data['message']);
  }
}
```

---

## Home APIs

### 1. Get Employee Profile

**Endpoint**: `GET /employee/profile`

**V1 Response:**
```json
{
  "code": 200,
  "message": "Success",
  "data": {
    "id": 1,
    "fullname": "John Doe",
    "email": "john@example.com",
    "job_title_id": 5,
    "job_title_name": "Software Engineer",
    "department_id": 2,
    "department_name": "IT",
    "branch_code": "JKT",
    "branch_name": "Jakarta",
    "status": 3,
    "type": "employee",
    "biodata": {
      "gender": "male",
      "phone": "08123456789",
      "address": "Jakarta",
      "photo_url": "https://example.com/photo.jpg"
    }
  }
}
```

**V2 Implementation:**
```dart
@override
Future<EmployeeModel> getEmployeeProfile() async {
  final response = await client.get(AppConstants.endpointEmployeeProfile);
  
  if (response.statusCode == 200) {
    return EmployeeModel.fromJson(response.data['data']);
  } else {
    throw ServerException(response.data['message']);
  }
}
```

### 2. Get Employee Menus

**Endpoint**: `GET /menu/employee`

**V1 Response:**
```json
{
  "code": 200,
  "message": "Success",
  "data": [
    {
      "id": "attendance",
      "name": "attendance",
      "label": "Presensi",
      "icon": "assets/icons/attendance.png",
      "is_asset": true,
      "order": 1
    },
    {
      "id": "leave",
      "name": "leave",
      "label": "Cuti",
      "icon": "event_busy",
      "is_asset": false,
      "order": 2
    }
  ]
}
```

**V2 Implementation:**
```dart
@override
Future<List<MenuItemModel>> getEmployeeMenus() async {
  final response = await client.get(AppConstants.endpointEmployeeMenus);
  
  if (response.statusCode == 200) {
    final List<dynamic> menusJson = response.data['data'] ?? [];
    return menusJson.map((json) => MenuItemModel.fromJson(json)).toList();
  } else {
    throw ServerException(response.data['message']);
  }
}
```

### 3. Get Notification Count

**Endpoint**: `GET /notification/count`

**V1 Response:**
```json
{
  "code": 200,
  "message": "Success",
  "data": {
    "notification_count": 5,
    "approval_count": 3,
    "approval_request": 2
  }
}
```

**V2 Implementation:**
```dart
@override
Future<NotificationCountModel> getNotificationCount() async {
  final response = await client.get(AppConstants.endpointNotificationCount);
  
  if (response.statusCode == 200) {
    return NotificationCountModel.fromJson(response.data['data']);
  } else {
    throw ServerException(response.data['message']);
  }
}
```

---

## Authentication Header

### Token Management

V1 uses **Bearer token** authentication.

**Auth Interceptor:**
```dart
class AuthInterceptor extends Interceptor {
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await AuthHelper.getToken();
    
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    
    handler.next(options);
  }
}
```

---

## Error Handling

### V1 Error Response Format

```json
{
  "code": 400,
  "message": "Invalid credentials",
  "data": null
}
```

### V2 Error Handling

```dart
// In Remote Data Source
if (response.statusCode == 200) {
  return Model.fromJson(response.data['data']);
} else {
  throw ServerException(
    response.data['message'] ?? 'Unknown error',
  );
}

// In Repository
try {
  final data = await remoteDataSource.getData();
  return Right(data);
} on ServerException catch (e) {
  return Left(ServerFailure(e.message));
} on DioException catch (e) {
  if (e.type == DioExceptionType.connectionTimeout) {
    return Left(NetworkFailure('Connection timeout'));
  } else if (e.type == DioExceptionType.receiveTimeout) {
    return Left(NetworkFailure('Receive timeout'));
  } else {
    return Left(ServerFailure(e.message ?? 'Unknown error'));
  }
}
```

---

## Field Name Mapping

### Snake Case to Camel Case

V1 uses **snake_case** in JSON, V2 uses **camelCase** in Dart.

**Example:**

```dart
class EmployeeModel extends Employee {
  factory EmployeeModel.fromJson(Map<String, dynamic> json) {
    return EmployeeModel(
      id: json['id'],
      fullname: json['fullname'],
      email: json['email'],
      jobTitleId: json['job_title_id'],      // snake_case → camelCase
      jobTitleName: json['job_title_name'],  // snake_case → camelCase
      departmentId: json['department_id'],   // snake_case → camelCase
      departmentName: json['department_name'], // snake_case → camelCase
      branchCode: json['branch_code'],       // snake_case → camelCase
      branchName: json['branch_name'],       // snake_case → camelCase
      status: json['status'],
      type: json['type'],
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullname': fullname,
      'email': email,
      'job_title_id': jobTitleId,      // camelCase → snake_case
      'job_title_name': jobTitleName,  // camelCase → snake_case
      'department_id': departmentId,   // camelCase → snake_case
      'department_name': departmentName, // camelCase → snake_case
      'branch_code': branchCode,       // camelCase → snake_case
      'branch_name': branchName,       // camelCase → snake_case
      'status': status,
      'type': type,
    };
  }
}
```

---

## Testing API Compatibility

### Mock Server

Use **mock server** to test V2 with V1 API format:

```dart
// test/fixtures/employee_fixture.dart
const employeeFixture = '''
{
  "code": 200,
  "message": "Success",
  "data": {
    "id": 1,
    "fullname": "John Doe",
    "email": "john@example.com",
    "job_title_id": 5,
    "job_title_name": "Software Engineer"
  }
}
''';

// test/features/home/data/datasources/home_remote_datasource_test.dart
test('should return EmployeeModel when response is 200', () async {
  // arrange
  when(mockClient.get(any)).thenAnswer(
    (_) async => Response(
      data: json.decode(employeeFixture),
      statusCode: 200,
      requestOptions: RequestOptions(path: ''),
    ),
  );
  
  // act
  final result = await dataSource.getEmployeeProfile();
  
  // assert
  expect(result, isA<EmployeeModel>());
});
```

---

## Checklist for API Compatibility

- [ ] Use same endpoint paths as V1
- [ ] Use same HTTP methods as V1
- [ ] Send same request body format as V1
- [ ] Handle same response format as V1
- [ ] Extract `data` field from response
- [ ] Map snake_case to camelCase correctly
- [ ] Include Bearer token in headers
- [ ] Handle all V1 error responses
- [ ] Test with actual V1 backend
- [ ] Verify all status codes match V1

---

## Summary

V2 maintains **100% API compatibility** with V1 by:

1. Using same endpoints
2. Same request/response formats
3. Same authentication mechanism
4. Proper field name mapping
5. Consistent error handling

**No backend changes required!**
