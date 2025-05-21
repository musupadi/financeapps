import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import '../../Bloc/Transaction/TransactionBloc.dart';
import '../../Bloc/Transaction/TransactionEvent.dart';
import '../../Bloc/Transaction/TransactionState.dart';
import '../Widget/HeaderCard.dart';
class Transaction extends StatelessWidget {
  const Transaction({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TransactionBloc()..add(LoadTransactionData()),
      child: const TransactionView(),
    );
  }
}

class TransactionView extends StatelessWidget {
  const TransactionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FF),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
        child: Column(
          children: [
            HeaderCard(name: 'Supriyadi'),
            Expanded(
              child: BlocBuilder<TransactionBloc, TransactionState>(
                builder: (context, state) {
                  if (state is TransactionLoaded) {
                    return ListView(
                      children: [
                        const Text('Your Balance Is', style: TextStyle(color: Colors.grey, fontSize: 14)),
                        const SizedBox(height: 4),
                        Text('\$ ${state.balance.toStringAsFixed(2)}', style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
                        Text('Today ${DateTime.now().day} ${_monthName(DateTime.now().month)} ${DateTime.now().year}',
                            style: const TextStyle(color: Colors.grey, fontSize: 14)),
                        const SizedBox(height: 24),
                        SizedBox(
                          height: 160,
                          child: Lottie.asset('assets/lottie/transaction.json', fit: BoxFit.contain),
                        ),
                        const SizedBox(height: 24),
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            gradient: const LinearGradient(
                              colors: [Color(0xFF151E57), Color(0xFFF199FF)],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text('Life Style', style: TextStyle(color: Colors.white, fontSize: 16)),
                              Row(children: [Text('EURO', style: TextStyle(color: Colors.white)), SizedBox(width: 8), Text('USD', style: TextStyle(color: Colors.white))])
                            ],
                          ),
                        ),
                        const SizedBox(height: 24),
                        const Text('Transactions', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                        const SizedBox(height: 16),
                        ...state.transactions.map((tx) => TransactionTile(
                          icon: tx['icon'],
                          title: tx['title'],
                          amount: tx['amount'],
                          date: tx['date'],
                          time: tx['time'],
                        )),
                      ],
                    );
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  static String _monthName(int month) {
    const monthNames = [ '', 'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec' ];
    return monthNames[month];
  }
}

class TransactionTile extends StatelessWidget {
  final String icon;
  final String title;
  final String amount;
  final String date;
  final String time;

  const TransactionTile({super.key, required this.icon, required this.title, required this.amount, required this.date, required this.time});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          CircleAvatar(backgroundImage: AssetImage(icon), radius: 22),
          const SizedBox(width: 12),
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
              Text(date, style: const TextStyle(color: Colors.grey)),
            ]),
          ),
          Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
            Text(amount, style: const TextStyle(fontWeight: FontWeight.bold)),
            Text(time, style: const TextStyle(color: Colors.grey)),
          ]),
        ],
      ),
    );
  }
}
