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
      child: Scaffold(
        backgroundColor: const Color(0xFFF8F9FF),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                          const Text(
                            'This Month Summary',
                            style: TextStyle(color: Colors.grey, fontSize: 14),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '\$ ${state.monthlyBalance.toStringAsFixed(2)}',
                            style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 32),
                          SizedBox(
                            height: 160,
                            child: Lottie.asset('assets/lottie/finance3.json', fit: BoxFit.contain),
                          ),
                          const SizedBox(height: 32),

                          // Card Section
                          Row(
                            children: [
                              Expanded(
                                child: _HomeInfoCard(
                                  title: 'Upcoming Bill',
                                  subtitle: 'Electricity - \$${state.billAmount.toStringAsFixed(2)}',
                                  color: Colors.orange,
                                  icon: Icons.flash_on,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: _HomeInfoCard(
                                  title: 'Goal Savings',
                                  subtitle: '${state.goalPercent.toInt()}% reached',
                                  color: Colors.blue,
                                  icon: Icons.savings,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 32),

                          // Quick Info
                          const Text(
                            'Quick Info',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(height: 12),
                          const _QuickInfoItem(
                            icon: Icons.card_giftcard,
                            text: 'You have 3 active promos!',
                          ),
                          const _QuickInfoItem(
                            icon: Icons.tips_and_updates,
                            text: 'Tip: Set budgets for categories to avoid overspending.',
                          ),
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
      ),
    );
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
    return IntrinsicHeight( // 🔑 auto tinggi sesuai isi
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
        decoration: BoxDecoration(
          color: color.withOpacity(0.08),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: color.withOpacity(0.2)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: color),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center, // 🔄 rata tengah vertikal
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: color,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      color: Colors.black54,
                      fontSize: 13,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
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
