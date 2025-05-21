import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

import '../../Bloc/Wallet/WalletBloc.dart';
import '../../Bloc/Wallet/WalletEvent.dart';
import '../../Bloc/Wallet/WalletState.dart';
import '../../Constant.dart';
import '../Widget/HeaderCard.dart';

class Wallet extends StatelessWidget {
  const Wallet({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => WalletBloc()..add(LoadWalletData()),
      child: const WalletView(),
    );
  }
}

class WalletView extends StatelessWidget {
  const WalletView({super.key});

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
              child: BlocBuilder<WalletBloc, WalletState>(
                builder: (context, state) {
                  if (state is WalletLoaded) {
                    return ListView(
                      children: [
                        const Text('Total Balance', style: TextStyle(color: Colors.grey, fontSize: 14)),
                        const SizedBox(height: 4),
                        Text('\$ ${state.totalBalance.toStringAsFixed(2)}',
                            style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
                        Text(
                          'Today ${DateTime.now().day} ${monthName(DateTime.now().month)} ${DateTime.now().year}',
                          style: const TextStyle(color: Colors.grey, fontSize: 14),
                        ),
                        const SizedBox(height: 24),
                        Center(
                          child: SizedBox(
                            height: 140,
                            child: Lottie.asset('assets/lottie/wallet.json'),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            _AmountCard(title: 'Income', amount: '+\$${state.income.toStringAsFixed(2)}', color: Colors.green),
                            const SizedBox(width: 12),
                            _AmountCard(title: 'Expense', amount: '-\$${state.expense.toStringAsFixed(2)}', color: Colors.red),
                          ],
                        ),
                        const SizedBox(height: 24),

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
                                  context.read<WalletBloc>().add(SearchWalletTransaction(value));
                                },
                              ),
                            ),
                            const SizedBox(width: 12),
                            PopupMenuButton<String>(
                              icon: const Icon(Icons.filter_list),
                              onSelected: (value) {
                                context.read<WalletBloc>().add(FilterWalletTransaction(value));
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


                        if (state.transactions.isEmpty)
                          const Text("No transactions found."),
                        ...state.transactions.map((tx) => _TransactionTile(tx)).toList(),
                      ],
                    );
                  }
                  return const Center(child: CircularProgressIndicator());
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

}

class _AmountCard extends StatelessWidget {
  final String title;
  final String amount;
  final Color color;

  const _AmountCard({required this.title, required this.amount, required this.color});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color.withOpacity(0.05),
          border: Border.all(color: color.withOpacity(0.2)),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            Text(title, style: TextStyle(color: color, fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text(amount, style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 18)),
          ],
        ),
      ),
    );
  }
}

class _TransactionTile extends StatelessWidget {
  final Map<String, dynamic> tx;

  const _TransactionTile(this.tx);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: AssetImage(tx['icon']),
            radius: 22,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(tx['title'], style: const TextStyle(fontWeight: FontWeight.w600)),
                Text(tx['date'], style: const TextStyle(color: Colors.grey)),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(tx['amount'], style: const TextStyle(fontWeight: FontWeight.bold)),
              Text(tx['time'], style: const TextStyle(color: Colors.grey)),
            ],
          ),
        ],
      ),
    );
  }
}
