import 'package:flutter/foundation.dart';
import '../../../../core/usecases/usecase.dart';
import '../../domain/entities/biodata.dart';
import '../../domain/usecases/get_biodata.dart';

enum BiodataStatus { initial, loading, loaded, error }

class BiodataProvider extends ChangeNotifier {
  final GetBiodata getBiodata;

  BiodataProvider({
    required this.getBiodata,
  });

  BiodataStatus _status = BiodataStatus.initial;
  Biodata? _biodata;
  String? _errorMessage;

  BiodataStatus get status => _status;
  Biodata? get biodata => _biodata;
  String? get errorMessage => _errorMessage;

  Future<void> loadBiodata() async {
    _status = BiodataStatus.loading;
    notifyListeners();

    final result = await getBiodata(NoParams());

    result.fold(
      (failure) {
        _status = BiodataStatus.error;
        _errorMessage = failure.message;
        notifyListeners();
      },
      (biodata) {
        _status = BiodataStatus.loaded;
        _biodata = biodata;
        notifyListeners();
      },
    );
  }
}
