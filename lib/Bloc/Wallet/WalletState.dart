abstract class WalletState {}

class WalletInitial extends WalletState {}

class WalletLoaded extends WalletState {
  final double totalBalance;
  final double income;
  final double expense;
  final List<Map<String, dynamic>> transactions;
  final List<Map<String, dynamic>> allTransactions;

  WalletLoaded({
    required this.totalBalance,
    required this.income,
    required this.expense,
    required this.transactions,
    required this.allTransactions,
  });
}
