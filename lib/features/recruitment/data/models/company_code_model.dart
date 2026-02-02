import '../../domain/entities/company_code.dart';

class CompanyCodeModel extends CompanyCode {
  const CompanyCodeModel({required super.id, required super.code});

  factory CompanyCodeModel.fromJson(Map<String, dynamic> json) {
    return CompanyCodeModel(id: json['id'] as int, code: json['code'] as String);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'code': code};
  }
}
