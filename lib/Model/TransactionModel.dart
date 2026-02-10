class TransactionModel {
  final String title;
  final String transactionId;
  final String amount;
  final String status;
  final String date;

  TransactionModel({
    required this.title,
    required this.transactionId,
    required this.amount,
    required this.status,
    required this.date,
  });
}