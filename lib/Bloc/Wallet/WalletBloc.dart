import 'dart:async';
import 'dart:math';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'WalletEvent.dart';
import 'WalletState.dart';

class WalletBloc extends Bloc<WalletEvent, WalletState> {
  WalletBloc() : super(WalletInitial()) {
    on<LoadWalletData>(_onLoadWalletData);
    on<FilterWalletTransaction>(_onFilter);
    on<SearchWalletTransaction>(_onSearch);
  }

  List<Map<String, dynamic>> _originalTransactions = [];
  String _currentFilter = 'All';
  String _currentQuery = '';

  void _onLoadWalletData(LoadWalletData event, Emitter<WalletState> emit) {
    final rand = Random();
    double income = 10000 + rand.nextDouble() * 5000;
    double expense = 3000 + rand.nextDouble() * 2000;
    double balance = income - expense;

    final names = ['Netflix', 'Apple', 'Instagram', 'Spotify', 'Amazon'];
    final icons = {
      'Netflix': 'assets/img/netflix.png',
      'Apple': 'assets/img/apple.png',
      'Instagram': 'assets/img/instagram.png',
      'Spotify': 'assets/img/spotify.png',
      'Amazon': 'assets/img/amazon.png',
    };

    _originalTransactions = List.generate(12, (index) {
      final name = names[rand.nextInt(names.length)];
      final isIncome = rand.nextBool();
      final amount = rand.nextDouble() * 200 + 20;
      DateTime date = DateTime.now().subtract(Duration(days: rand.nextInt(10)));

      return {
        'title': name,
        'icon': icons[name],
        'amount': isIncome ? '+\$${amount.toStringAsFixed(2)}' : '-\$${amount.toStringAsFixed(2)}',
        'value': isIncome ? amount : -amount,
        'type': isIncome ? 'Income' : 'Expense',
        'date': '${date.month}/${date.day}/${date.year}',
        'time': '${date.hour}:${date.minute.toString().padLeft(2, '0')}',
      };
    });

    _currentFilter = 'All';
    _currentQuery = '';

    emit(WalletLoaded(
      totalBalance: balance,
      income: income,
      expense: expense,
      transactions: _originalTransactions,
      allTransactions: _originalTransactions,
    ));
  }

  void _onFilter(FilterWalletTransaction event, Emitter<WalletState> emit) {
    if (state is WalletLoaded) {
      final current = state as WalletLoaded;
      _currentFilter = event.type;
      final filtered = _applyCombinedFilter();

      emit(WalletLoaded(
        totalBalance: current.totalBalance,
        income: current.income,
        expense: current.expense,
        transactions: filtered,
        allTransactions: _originalTransactions,
      ));
    }
  }

  void _onSearch(SearchWalletTransaction event, Emitter<WalletState> emit) {
    if (state is WalletLoaded) {
      final current = state as WalletLoaded;
      _currentQuery = event.query;

      final filtered = _applyCombinedFilter();

      emit(WalletLoaded(
        totalBalance: current.totalBalance,
        income: current.income,
        expense: current.expense,
        transactions: filtered,
        allTransactions: _originalTransactions,
      ));
    }
  }

  List<Map<String, dynamic>> _applyCombinedFilter() {
    return _originalTransactions.where((tx) {
      final matchesType = _currentFilter == 'All' || tx['type'] == _currentFilter;
      final matchesQuery = tx['title'].toLowerCase().contains(_currentQuery.toLowerCase());
      return matchesType && matchesQuery;
    }).toList();
  }

  String getCurrentFilter() => _currentFilter;
}
