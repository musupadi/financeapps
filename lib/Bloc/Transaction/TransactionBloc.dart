import 'dart:async';
import 'dart:math';
import 'package:bloc/bloc.dart';
import 'TransactionEvent.dart';
import 'TransactionState.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  TransactionBloc() : super(TransactionInitial()) {
    on<LoadTransactionData>(_onLoadData);
    on<FilterTransaction>(_onFilter);
    on<SearchTransaction>(_onSearch);
  }

  List<Map<String, dynamic>> _originalData = [];
  String _currentFilter = 'All';
  String _currentQuery = '';

  Future<void> _onLoadData(LoadTransactionData event, Emitter<TransactionState> emit) async {
    final balance = 10000 + Random().nextInt(50000) + Random().nextDouble();

    final names = ['Netflix', 'Apple', 'Instagram', 'Spotify', 'Amazon'];
    final icons = {
      'Netflix': 'assets/img/netflix.png',
      'Apple': 'assets/img/apple.png',
      'Instagram': 'assets/img/instagram.png',
      'Spotify': 'assets/img/spotify.png',
      'Amazon': 'assets/img/amazon.png',
    };

    final shuffledNames = [...names]..shuffle();

    _originalData = List.generate(12, (index) {
      final name = shuffledNames[index % shuffledNames.length];
      final isIncome = Random().nextBool();
      final amount = Random().nextDouble() * 200 + 10;
      final date = DateTime.now().subtract(Duration(days: Random().nextInt(10)));

      return {
        'title': name,
        'icon': icons[name],
        'amount': (isIncome ? "+\$" : "-\$") + amount.toStringAsFixed(2),
        'value': isIncome ? amount : -amount,
        'type': isIncome ? 'Income' : 'Expense',
        'date': '${date.month}/${date.day}/${date.year}',
        'time': '${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}',
      };
    });

    _currentFilter = 'All';
    _currentQuery = '';

    emit(TransactionLoaded(
      balance: balance,
      transactions: _originalData,
      allTransactions: _originalData,
    ));
  }

  void _onFilter(FilterTransaction event, Emitter<TransactionState> emit) {
    if (state is TransactionLoaded) {
      final currentState = state as TransactionLoaded;

      _currentFilter = event.type;
      final filtered = _applyCombinedFilter();

      print("Filter: $_currentFilter, Query: $_currentQuery, Found: ${filtered.length}");
      emit(TransactionLoaded(
        balance: currentState.balance,
        transactions: filtered,
        allTransactions: _originalData,
      ));
    }
  }

  void _onSearch(SearchTransaction event, Emitter<TransactionState> emit) {
    if (state is TransactionLoaded) {
      final currentState = state as TransactionLoaded;

      _currentQuery = event.query;

      final filtered = _applyCombinedFilter();

      print("Search Triggered: $_currentQuery → Found: ${filtered.length}");

      emit(TransactionLoaded(
        balance: currentState.balance,
        transactions: filtered,
        allTransactions: _originalData,
      ));
    }
  }

  List<Map<String, dynamic>> _applyCombinedFilter() {
    return _originalData.where((tx) {
      final matchesType = _currentFilter == 'All' || tx['type'] == _currentFilter;
      final matchesQuery = tx['title'].contains(_currentQuery);
      return matchesType && matchesQuery;
    }).toList();
  }
}
