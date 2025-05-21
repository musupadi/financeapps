abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoaded extends HomeState {
  final double monthlyBalance;
  final double goalPercent;
  final double billAmount;

  HomeLoaded({
    required this.monthlyBalance,
    required this.goalPercent,
    required this.billAmount,
  });
}
