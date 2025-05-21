import 'dart:async';
import 'dart:math';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'WalletEvent.dart';
import 'WalletState.dart';


class WalletBloc extends Bloc<WalletEvent, WalletState> {
  WalletBloc() : super(WalletInitial()) {
    on<LoadWalletData>(_onLoadWalletData);
  }

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

    final transactions = List.generate(5, (index) {
      final name = names[rand.nextInt(names.length)];
      final isIncome = rand.nextBool();
      final amount = rand.nextDouble() * 200 + 20;
      DateTime date = DateTime.now().subtract(Duration(days: index));
      return {
        'title': name,
        'icon': icons[name],
        'amount': isIncome ? '+\$${amount.toStringAsFixed(2)}' : '-\$${amount.toStringAsFixed(2)}',
        'date': '${date.month}/${date.day}/${date.year}',
        'time': '${date.hour}:${date.minute.toString().padLeft(2, '0')}',
        'isIncome': isIncome
      };
    });

    emit(WalletLoaded(
      totalBalance: balance,
      income: income,
      expense: expense,
      transactions: transactions,
    ));
  }
}
