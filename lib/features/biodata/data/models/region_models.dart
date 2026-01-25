class ProvinceModel {
  final int id;
  final String name;

  ProvinceModel({required this.id, required this.name});

  factory ProvinceModel.fromJson(Map<String, dynamic> json) {
    return ProvinceModel(
      id: json['id'],
      name: json['name'],
    );
  }
}

class RegencyModel {
  final int id;
  final String name;

  RegencyModel({required this.id, required this.name});

  factory RegencyModel.fromJson(Map<String, dynamic> json) {
    return RegencyModel(
      id: json['id'],
      name: json['name'],
    );
  }
}

class DistrictModel {
  final int id;
  final String name;

  DistrictModel({required this.id, required this.name});

  factory DistrictModel.fromJson(Map<String, dynamic> json) {
    return DistrictModel(
      id: json['id'],
      name: json['name'],
    );
  }
}

class VillageModel {
  final int id;
  final String name;

  VillageModel({required this.id, required this.name});

  factory VillageModel.fromJson(Map<String, dynamic> json) {
    return VillageModel(
      id: json['id'],
      name: json['name'],
    );
  }
}
