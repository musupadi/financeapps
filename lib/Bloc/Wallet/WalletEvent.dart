abstract class WalletEvent {}

class LoadWalletData extends WalletEvent {}

class FilterWalletTransaction extends WalletEvent {
  final String type; // "All", "Income", "Expense"
  FilterWalletTransaction(this.type);
}

class SearchWalletTransaction extends WalletEvent {
  final String query;
  SearchWalletTransaction(this.query);
}
