import 'package:shared_preferences/shared_preferences.dart';

class AuthStorage {
  static AuthStorage? _instance;
  SharedPreferences? _prefs;

  static Future<AuthStorage> getInstance() async {
    if (_instance == null) {
      _instance = AuthStorage();
      await _instance!._init();
    }
    return _instance!;
  }

  Future<void> _init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<void> saveToken(String token, String refreshToken) async {
    // var auth = await _prefs?.setString('auth_token', token);
    final expiration = DateTime.now()
        .add(const Duration(days: 1))
        .millisecondsSinceEpoch;
    await _prefs?.setInt('token_expiration', expiration);
    // var res = await _prefs?.setString('refresh_token', refreshToken);
    final expirationRefresh = DateTime.now()
        .add(const Duration(days: 7))
        .millisecondsSinceEpoch;
    await _prefs?.setInt('refresh_token_expiration', expirationRefresh);
  }

  Future<void> saveEmployeeData({
    required int id,
    required String name,
    required int role,
    required String jobTitle,
    required String branchCode,
    required String departmentCode,
    required String latLng,
    required String departmentId,
    required String email,
    required String departmentName,
    required String type,
    required String faceEmbedding,
    required String branchName,
    required int jobTitleId,
    required int isProject,
    required String globalPassword,
  }) async {
    await _prefs?.setInt('employee_id', id);
    await _prefs?.setString('employee_name', name);
    await _prefs?.setInt('employee_role', role);
    await _prefs?.setString('type', type);
    await _prefs?.setString('employee_job_title', jobTitle);
    await _prefs?.setString('branch_code', branchCode);
    await _prefs?.setString('department_id', departmentId);
    await _prefs?.setString('department_code', departmentCode);
    await _prefs?.setString('department_name', departmentName);
    await _prefs?.setString('latLng', latLng);
    await _prefs?.setString('email', email);
    await _prefs?.setString('face_embedding', faceEmbedding);
    await _prefs?.setString('branchName', branchName);
    await _prefs?.setInt('job_title_id', jobTitleId);
    await _prefs?.setInt('is_project', isProject);
    await _prefs?.setString('global_password', globalPassword);
  }

  Future<void> saveEmployeeBracnhLatLng({
    required String branchCode,
    required String latLng,
  }) async {
    await _prefs?.setString('branch_code', branchCode);

    await _prefs?.setString('latLng', latLng);
  }

  // Future<String?> getToken() async {
  //   return _prefs?.getString('auth_token');
  // }

  Future<String?> getToken() async {
    return _prefs?.getString('refresh_token');
  }

  Future<Map<String, dynamic>> getEmployeeData() async {
    final id = _prefs?.getInt('employee_id');
    final name = _prefs?.getString('employee_name');
    final role = _prefs?.getInt('employee_role');
    final jobTitle = _prefs?.getString('employee_job_title');
    final branchCode = _prefs?.getString('branch_code');
    final type = _prefs?.getString('type');
    final departmentCode = _prefs?.getString('department_code');
    final departmentId = _prefs?.getString('department_id');
    final departmentName = _prefs?.getString('department_name');
    final faceEmbedding = _prefs?.getString('face_embedding');
    final branchName = _prefs?.getString('branchName');
    final latLng = _prefs?.getString('latLng');
    final email = _prefs?.getString('email');
    final jobTitleId = _prefs?.getInt('job_title_id');
    final isProject = _prefs?.getInt('is_project');
    final globalPassword = _prefs?.getString('global_password');

    return {
      'id': id,
      'name': name,
      'role': role,
      'employee_job_title': jobTitle,
      'branchCode': branchCode,
      'department_code': departmentCode,
      'department_id': departmentId,
      'department_name': departmentName,
      'face_embedding': faceEmbedding,
      'branchName': branchName,
      'type': type,
      'latLng': latLng,
      'email': email,
      'job_title_id': jobTitleId,
      'is_project': isProject,
      'global_password': globalPassword,
    };
  }

  Future<bool> checkLoginUser() async {
    final String? token = _prefs?.getString('auth_token');
    final int? expiration = _prefs?.getInt('token_expiration');
    final String? refreshToken = _prefs?.getString('refresh_token');
    final int? refreshExpiration = _prefs?.getInt('refresh_token_expiration');
    final employeeData = await getEmployeeData();

    if (employeeData['id'] == null) {
      return true;
    }

    if (token != null &&
        expiration != null &&
        refreshToken != null &&
        refreshExpiration != null) {
      final bool isTokenExpired =
          DateTime.now().millisecondsSinceEpoch > expiration;
      final bool isRefreshTokenExpired =
          DateTime.now().millisecondsSinceEpoch > refreshExpiration;

      if (isTokenExpired && isRefreshTokenExpired) {
        return true;
      }

      if (isTokenExpired && !isRefreshTokenExpired) {
        await _prefs?.setString('auth_token', refreshToken);
        await _prefs?.setInt('token_expiration', refreshExpiration);
      }

      return false;
    }
    return true;
  }

  Future<void> saveLoginStatus(bool isLoggedIn) async {
    // var res = await _prefs?.setBool('is_logged_in', isLoggedIn);
  }

  Future<bool> getLoginStatus() async {
    return _prefs?.getBool('is_logged_in') ?? false;
  }

  Future<void> saveLoginForGetLocation(bool isLoggedIn) async {
    // var res = await _prefs?.setString(
    //   'is_logged_for_getLocation',
    //   "$isLoggedIn",
    // );
  }

  Future<void> saveOffline(bool isOffline) async {
    await _prefs?.setBool('is_offline', isOffline);
  }

  Future<bool> getOffline() async {
    return _prefs?.getBool('is_offline') ?? false;
  }
}
