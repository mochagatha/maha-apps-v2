class Bank {
  final int id;
  final String name;
  final String? kode;
  final String? jenis;

  Bank({
    required this.id,
    required this.name,
    this.kode,
    this.jenis,
  });
}
