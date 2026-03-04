import '../../domain/entities/bank.dart';

class BankModel extends Bank {
  BankModel({
    required super.id,
    required super.name,
    super.kode,
    super.jenis,
  });

  factory BankModel.fromJson(Map<String, dynamic> json) {
    return BankModel(
      id: json['id'] as int,
      name: json['nama'] as String,
      kode: json['kode'] as String?,
      jenis: json['jenis'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nama': name,
      'kode': kode,
      'jenis': jenis,
    };
  }
}
