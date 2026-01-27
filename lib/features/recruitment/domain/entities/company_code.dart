import 'package:equatable/equatable.dart';

class CompanyCode extends Equatable {
  final int id;
  final String code;

  const CompanyCode({required this.id, required this.code});

  @override
  List<Object?> get props => [id, code];
}
