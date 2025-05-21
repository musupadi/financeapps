abstract class TransactionEvent {}

class LoadTransactionData extends TransactionEvent {}

class FilterTransaction extends TransactionEvent {
  final String type; // "All", "Income", "Expense"
  FilterTransaction(this.type);
}

class SearchTransaction extends TransactionEvent {
  final String query;
  SearchTransaction(this.query);
}
