import 'package:flutter/foundation.dart';
import '../../../../core/usecases/usecase.dart';
import '../../domain/entities/recruitment_menu_item.dart';
import '../../domain/usecases/get_recruitment_menus.dart';

enum RecruitmentStatus { initial, loading, loaded, error }

class RecruitmentProvider extends ChangeNotifier {
  final GetRecruitmentMenus getRecruitmentMenus;

  RecruitmentProvider({required this.getRecruitmentMenus});

  RecruitmentStatus _status = RecruitmentStatus.initial;
  List<RecruitmentMenuItem> _menuItems = [];
  String? _errorMessage;

  // Getters
  RecruitmentStatus get status => _status;
  List<RecruitmentMenuItem> get menuItems => _menuItems;
  String? get errorMessage => _errorMessage;
  bool get isLoading => _status == RecruitmentStatus.loading;
  bool get hasError => _status == RecruitmentStatus.error;

  /// Load recruitment menus
  Future<void> loadRecruitmentMenus() async {
    _status = RecruitmentStatus.loading;
    _errorMessage = null;
    notifyListeners();

    final result = await getRecruitmentMenus(NoParams());

    result.fold(
      (failure) {
        _status = RecruitmentStatus.error;
        _errorMessage = failure.message;
        notifyListeners();
      },
      (menus) {
        _menuItems = menus;
        _status = RecruitmentStatus.loaded;
        notifyListeners();
      },
    );
  }

  /// Refresh recruitment menus
  Future<void> refresh() async {
    await loadRecruitmentMenus();
  }

  /// Clear error message
  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}
