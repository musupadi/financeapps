import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import '../../Bloc/Transaction/TransactionBloc.dart';
import '../../Bloc/Transaction/TransactionEvent.dart';
import '../../Bloc/Transaction/TransactionState.dart';
import '../../Constant.dart';
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
        padding: const EdgeInsets.only(left: 24,right: 24,top: 40),
        child: Column(
          children: [
            const HeaderCard(name: 'Supriyadi'),
            Expanded(
              child: BlocBuilder<TransactionBloc, TransactionState>(
                builder: (context, state) {
                  if (state is TransactionLoaded) {
                    return ListView(
                      children: [
                        const Text('Your Balance Is', style: TextStyle(color: Colors.grey, fontSize: 14)),
                        const SizedBox(height: 4),
                        Text(
                          '\$ ${state.balance.toStringAsFixed(2)}',
                          style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Today ${DateTime.now().day} ${monthName(DateTime.now().month)} ${DateTime.now().year}',
                          style: const TextStyle(color: Colors.grey, fontSize: 14),
                        ),
                        const SizedBox(height: 24),
                        SizedBox(
                          height: 160,
                          child: Lottie.asset('assets/lottie/transaction.json', fit: BoxFit.contain),
                        ),
                        const SizedBox(height: 24),

                        // Sepertinya menarik digunakan tapi tidak jadi digunakan sayang saja jika dibuang
                        // Container(
                        //   padding: const EdgeInsets.all(16),
                        //   decoration: BoxDecoration(
                        //     borderRadius: BorderRadius.circular(20),
                        //     gradient: const LinearGradient(
                        //       colors: [Color(0xFF151E57), Color(0xFFF199FF)],
                        //       begin: Alignment.topLeft,
                        //       end: Alignment.bottomRight,
                        //     ),
                        //   ),
                        //   child: Row(
                        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //     children: const [
                        //       Text('Life Style', style: TextStyle(color: Colors.white, fontSize: 16)),
                        //       Row(
                        //         children: [
                        //           Text('EURO', style: TextStyle(color: Colors.white)),
                        //           SizedBox(width: 8),
                        //           Text('USD', style: TextStyle(color: Colors.white)),
                        //         ],
                        //       )
                        //     ],
                        //   ),
                        // ),
                        // const SizedBox(height: 24),
                        const Text('Transactions', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: TextField(
                                decoration: InputDecoration(
                                  hintText: 'Search transactions...',
                                  prefixIcon: const Icon(Icons.search),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  isDense: true,
                                  contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                                ),
                                onChanged: (value) {
                                  context.read<TransactionBloc>().add(SearchTransaction(value));
                                },
                              ),
                            ),
                            const SizedBox(width: 12),
                            PopupMenuButton<String>(
                              icon: const Icon(Icons.filter_list),
                              onSelected: (value) {
                                context.read<TransactionBloc>().add(FilterTransaction(value));
                              },
                              itemBuilder: (context) => const [
                                PopupMenuItem(value: 'All', child: Text('All')),
                                PopupMenuItem(value: 'Income', child: Text('Income')),
                                PopupMenuItem(value: 'Expense', child: Text('Expense')),
                              ],
                            ),

                          ],
                        ),
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
}

class TransactionTile extends StatelessWidget {
  final String icon;
  final String title;
  final String amount;
  final String date;
  final String time;

  const TransactionTile({
    super.key,
    required this.icon,
    required this.title,
    required this.amount,
    required this.date,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: AssetImage(icon),
            radius: 22,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
                Text(date, style: const TextStyle(color: Colors.grey)),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(amount, style: const TextStyle(fontWeight: FontWeight.bold)),
              Text(time, style: const TextStyle(color: Colors.grey)),
            ],
          ),
        ],
      ),
    );
  }
}
