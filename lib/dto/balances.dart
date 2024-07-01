class Balances {
  final int idBalance;
  final String nim;
  final int balance;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Balances({
    required this.idBalance,
    required this.nim,
    required this.balance,
    this.createdAt,
    this.updatedAt,
  });

  factory Balances.fromJson(Map<String, dynamic> json) {
    return Balances(
      idBalance: json['id_balance'] as int,
      nim: json['nim'] as String,
      balance: json['balance'] as int,
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}