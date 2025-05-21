abstract class TransactionState {}

class TransactionInitial extends TransactionState {}

class TransactionLoaded extends TransactionState {
  final double balance;
  final List<Map<String, dynamic>> transactions;

  TransactionLoaded({required this.balance, required this.transactions});
}