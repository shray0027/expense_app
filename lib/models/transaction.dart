class Transaction {
  late String id;
  late String title;
  late double amount;
  late DateTime date;

  Transaction({
    required this.id,
    required this.amount,
    required this.date,
    required this.title,
  }) {}
}
