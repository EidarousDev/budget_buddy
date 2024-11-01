class Transaction {
  final String id;
  final String title;
  final int amount;
  final DateTime date;
  final String category;

  const Transaction(
      {required this.id,
      required this.title,
      required this.amount,
      required this.date,
      required this.category});

  Map<String, dynamic> toMap(Transaction t) {
    return {
      'id': t.id,
      'title': t.title,
      'amount': t.amount,
      'date': t.date.toIso8601String(),
      'category': t.category,
    };
  }
}
