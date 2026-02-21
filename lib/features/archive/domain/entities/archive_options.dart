class ArchiveOptions {
  final String title;
  final String pagePath;
  int? year;
  int? month;
  String? typeRole;
  String? tipeDokumen;

  ArchiveOptions({
    required this.title,
    required this.pagePath,
    this.year,
    this.month,
    this.typeRole,
    this.tipeDokumen,
  });
}

class TypeRole {
  static const String none = "";
  static const String employee = "employee";
  static const String worker = "worker";
  static const String project = "project";
}
