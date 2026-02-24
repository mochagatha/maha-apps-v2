import 'package:flutter/foundation.dart';
import 'package:maha_apps_v2/features/recruitment/features/e_matrai/domain/entities/e_matrai_item.dart';
import 'package:maha_apps_v2/features/recruitment/features/e_matrai/domain/entities/e_matrai_list.dart';
import 'package:maha_apps_v2/features/recruitment/features/e_matrai/domain/usecases/get_e_matrai_list.dart';

enum EMatraiStatus { initial, loading, loaded, error }

class EMatraiTabState {
  final EMatraiStatus status;
  final List<EMatraiItem> items;
  final String? errorMessage;

  const EMatraiTabState({
    this.status = EMatraiStatus.initial,
    this.items = const [],
    this.errorMessage,
  });

  EMatraiTabState copyWith({
    EMatraiStatus? status,
    List<EMatraiItem>? items,
    String? errorMessage,
  }) {
    return EMatraiTabState(
      status: status ?? this.status,
      items: items ?? this.items,
      errorMessage: errorMessage,
    );
  }
}

class EMatraiProvider extends ChangeNotifier {
  final GetEMatraiList getEMatraiList;

  EMatraiProvider({required this.getEMatraiList});

  // Keyed by matraiStatus (0, 1, 2)
  final Map<int, EMatraiTabState> _tabStates = {
    0: const EMatraiTabState(),
    1: const EMatraiTabState(),
    2: const EMatraiTabState(),
  };

  EMatraiCount? _count;

  EMatraiTabState stateForTab(int matraiStatus) =>
      _tabStates[matraiStatus] ?? const EMatraiTabState();

  EMatraiCount? get count => _count;

  List<EMatraiItem> itemsForTab(int matraiStatus) => _tabStates[matraiStatus]?.items ?? [];

  Future<void> fetchTab(int matraiStatus, {String typeUser = 'employee'}) async {
    final current = _tabStates[matraiStatus]!;
    if (current.status == EMatraiStatus.loading) return;

    _tabStates[matraiStatus] = current.copyWith(status: EMatraiStatus.loading);
    notifyListeners();

    final result = await getEMatraiList(
      GetEMatraiListParams(
        matraiStatus: matraiStatus,
        typeUser: typeUser,
      ),
    );

    result.fold(
      (failure) {
        _tabStates[matraiStatus] = EMatraiTabState(
          status: EMatraiStatus.error,
          errorMessage: failure.message,
        );
      },
      (data) {
        _count = data.count;
        _tabStates[matraiStatus] = EMatraiTabState(
          status: EMatraiStatus.loaded,
          items: data.items,
        );
      },
    );

    notifyListeners();
  }

  void reset() {
    for (final key in _tabStates.keys) {
      _tabStates[key] = const EMatraiTabState();
    }
    _count = null;
    notifyListeners();
  }
}
