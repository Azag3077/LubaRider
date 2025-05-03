class Earning {
  const Earning({
    required this.id,
    required this.name,
    required this.price,
    required this.datetime,
    required this.type,
  });

  final String id;
  final String name;
  final num price;
  final DateTime datetime;
  final EarningType type;
}

enum EarningType {
  debit,
  credit;

  bool get isDebit => this == debit;

  bool get isCredit => this == credit;
}
