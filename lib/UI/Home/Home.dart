import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import '../../Bloc/Home/home_bloc.dart';
import '../../Bloc/Home/home_event.dart';
import '../../Bloc/Home/home_state.dart';
import '../Widget/HeaderCard.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeBloc()..add(LoadHomeData()),
      child: const HomeView(),
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FF),
      body: Padding(
        padding: const EdgeInsets.only(left: 24, right: 24, top: 40),
        child: Column(
          children: [
            HeaderCard(
              name: 'Supriyadi',
              onAction: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('This is not implemented yet')),
                );
              },
            ),
            Expanded(
              child: BlocBuilder<HomeBloc, HomeState>(
                builder: (context, state) {
                  if (state is HomeLoaded) {
                    return ListView(
                      children: [
                        const Text('This Month Summary',
                            style: TextStyle(color: Colors.grey, fontSize: 14)),
                        const SizedBox(height: 4),
                        Text(
                          '\$ ${state.monthlyBalance.toStringAsFixed(2)}',
                          style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Today ${DateTime.now().day} ${_monthName(DateTime.now().month)} ${DateTime.now().year}',
                          style: const TextStyle(color: Colors.grey, fontSize: 14),
                        ),
                        const SizedBox(height: 24),
                        SizedBox(
                          height: 160,
                          child: Lottie.asset('assets/lottie/finance3.json', fit: BoxFit.contain),
                        ),
                        const SizedBox(height: 24),
                        Row(
                          children: [
                            Expanded(
                              flex:1,
                              child: _HomeInfoCard(
                                title: 'Upcoming Bill',
                                subtitle: 'Electricity - \$${state.billAmount.toStringAsFixed(2)}',
                                color: Colors.orange,
                                icon: Icons.flash_on,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              flex:1,
                              child: _HomeInfoCard(
                                title: 'Goal Savings',
                                subtitle: 'Savings Goal\n${state.goalPercent.toInt()}% reached',
                                color: Colors.blue,
                                icon: Icons.savings,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 32),
                        const Text('Quick Info',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                        const SizedBox(height: 12),
                        const _QuickInfoItem(
                          icon: Icons.card_giftcard,
                          text: 'You have 3 active promos!',
                        ),
                        const _QuickInfoItem(
                          icon: Icons.tips_and_updates,
                          text: 'Tip: Set budgets for categories to avoid overspending.',
                        ),
                        const SizedBox(height: 24),
                      ],
                    );
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  static String _monthName(int month) {
    const monthNames = [
      '', 'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return monthNames[month];
  }
}

class _HomeInfoCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final Color color;
  final IconData icon;

  const _HomeInfoCard({
    required this.title,
    required this.subtitle,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: 165,
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.2)),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundColor: color.withOpacity(0.1),
            radius: 24,
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: const TextStyle(
              color: Colors.black87,
              fontSize: 12,
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}



class _QuickInfoItem extends StatelessWidget {
  final IconData icon;
  final String text;

  const _QuickInfoItem({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Icon(icon, color: Colors.deepPurple),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 13),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
