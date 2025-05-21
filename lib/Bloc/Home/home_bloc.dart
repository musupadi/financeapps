import 'dart:async';
import 'dart:math';
import 'package:bloc/bloc.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<LoadHomeData>(_onLoadHomeData);
  }

  Future<void> _onLoadHomeData(LoadHomeData event, Emitter<HomeState> emit) async {
    final monthlyBalance = 30000 + Random().nextDouble() * 20000;
    final goalPercent = 50 + Random().nextInt(50).toDouble();
    final billAmount = 50 + Random().nextDouble() * 100;

    emit(HomeLoaded(
      monthlyBalance: monthlyBalance,
      goalPercent: goalPercent,
      billAmount: billAmount,
    ));
  }
}
