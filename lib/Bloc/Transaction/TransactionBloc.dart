import 'dart:math';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'TransactionEvent.dart';
import 'TransactionState.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  TransactionBloc() : super(TransactionInitial()) {
    on<LoadTransactionData>(_onLoadData);
  }

  void _onLoadData(LoadTransactionData event, Emitter<TransactionState> emit) {
    final double balance = 10000 + Random().nextInt(90000) + Random().nextDouble();
    final names = ['Netflix', 'Apple', 'Instagram', 'Spotify', 'Amazon'];
    final icons = {
      'Netflix': 'assets/img/netflix.png',
      'Apple': 'assets/img/apple.png',
      'Instagram': 'assets/img/instagram.png',
      'Spotify': 'assets/img/spotify.png',
      'Amazon': 'assets/img/amazon.png',
    };

    final shuffledNames = [...names]..shuffle();
    final transactions = List.generate(6, (index) {
      final name = shuffledNames[index % shuffledNames.length];
      double amount = Random().nextDouble() * 200 + 10;
      DateTime date = DateTime.now().subtract(Duration(days: Random().nextInt(15)));

      return {
        'title': name,
        'icon': icons[name],
        'amount': '-\$${amount.toStringAsFixed(2)}',
        'date': '${date.month}/${date.day}/${date.year}',
        'time': '${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}',
      };
    });

    emit(TransactionLoaded(balance: balance, transactions: transactions));
  }
}