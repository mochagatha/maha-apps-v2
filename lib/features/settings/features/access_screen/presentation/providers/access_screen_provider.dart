import 'package:flutter/material.dart';

import '../../domain/entities/access_screen_entity.dart';
import '../../domain/usecases/get_access_screen.dart';
import '../../domain/usecases/update_access_screen.dart';

class AccessScreenProvider extends ChangeNotifier {
  final GetAccessScreenList getAccessScreenList;
  final GetAccessScreenDetail getAccessScreenDetail;
  final UpdateGlobalAccessScreen updateGlobalAccessScreen;
  final UpdateDetailAccessScreen updateDetailAccessScreen;

  AccessScreenProvider({
    required this.getAccessScreenList,
    required this.getAccessScreenDetail,
    required this.updateGlobalAccessScreen,
    required this.updateDetailAccessScreen,
  });

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  AccessScreenGlobalEntity? _data;
  AccessScreenGlobalEntity? get data => _data;

  AccessScreenDetailEntity? _detailData;
  AccessScreenDetailEntity? get detailData => _detailData;

  String _errorMessage = '';
  String get errorMessage => _errorMessage;

  // Global Switch States
  bool _isRecord = false;
  bool get isRecord => _isRecord;
  set isRecord(bool value) {
    _isRecord = value;
    notifyListeners();
  }

  bool _isCatch = false;
  bool get isCatch => _isCatch;
  set isCatch(bool value) {
    _isCatch = value;
    notifyListeners();
  }

  // Detail Switch States
  bool _isDetailRecord = false;
  bool get isDetailRecord => _isDetailRecord;
  set isDetailRecord(bool value) {
    _isDetailRecord = value;
    notifyListeners();
  }

  bool _isDetailCatch = false;
  bool get isDetailCatch => _isDetailCatch;
  set isDetailCatch(bool value) {
    _isDetailCatch = value;
    notifyListeners();
  }

  Future<void> fetchAccessScreenList(String type) async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    final result = await getAccessScreenList(type);

    result.fold(
      (failure) {
        _errorMessage = failure.message;
        _isLoading = false;
        notifyListeners();
      },
      (data) {
        _data = data;
        _isRecord = data.isRecord;
        _isCatch = data.isCatch;
        _isLoading = false;
        notifyListeners();
      },
    );
  }

  Future<void> fetchDetail(String type, int id) async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    print('🔍 Fetching detail with type: $type, id: $id');
    final result = await getAccessScreenDetail(GetAccessScreenDetailParams(type: type, id: id));

    result.fold(
      (failure) {
        print('❌ Error fetching detail: ${failure.message}');
        _errorMessage = failure.message;
        _isLoading = false;
        notifyListeners();
      },
      (data) {
        print('✅ Detail data received: ${data.fullname}, ${data.jobTitle}');
        _detailData = data;
        _isDetailRecord = data.isRecord;
        _isDetailCatch = data.isCatch;
        _isLoading = false;
        notifyListeners();
      },
    );
  }

  Future<bool> updateGlobal() async {
    if (_data == null) return false;
    _isLoading = true;
    notifyListeners();

    final result = await updateGlobalAccessScreen(
      UpdateGlobalAccessScreenParams(id: _data!.id, isRecord: _isRecord, isCatch: _isCatch),
    );

    return result.fold(
      (failure) {
        _errorMessage = failure.message;
        _isLoading = false;
        notifyListeners();
        return false;
      },
      (_) {
        _isLoading = false;
        notifyListeners();
        return true;
      },
    );
  }

  Future<bool> updateDetail() async {
    if (_detailData == null) return false;
    _isLoading = true;
    notifyListeners();

    final result = await updateDetailAccessScreen(
      UpdateDetailAccessScreenParams(
        id: _detailData!.id,
        isRecord: _isDetailRecord,
        isCatch: _isDetailCatch,
      ),
    );

    return result.fold(
      (failure) {
        _errorMessage = failure.message;
        _isLoading = false;
        notifyListeners();
        return false;
      },
      (_) {
        _isLoading = false;
        notifyListeners();
        return true;
      },
    );
  }
}
