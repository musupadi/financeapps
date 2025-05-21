abstract class TransactionState {}

class TransactionInitial extends TransactionState {}

class TransactionLoaded extends TransactionState {
  final double balance;
  final List<Map<String, dynamic>> transactions;
  final List<Map<String, dynamic>> allTransactions;

  TransactionLoaded({
    required this.balance,
    required this.transactions,
    required this.allTransactions,
  });
}
