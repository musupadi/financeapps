import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../Route.dart';
import '../Widget/HeaderCard.dart';

class Setting extends StatelessWidget {
  const Setting({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FF),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
        child: Column(
          children: [
            HeaderCard(
              name: 'Supriyadi',
              onAction: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('this is not implemented yet')),
                );
              },
            ),

            // 📜 SCROLLABLE SETTINGS
            Expanded(
              child: ListView(
                children: [
                  // 🧩 Lottie Icon
                  Center(
                    child: SizedBox(
                      height: 160,
                      child: Lottie.asset(
                        'assets/lottie/setting.json',
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),

                  const SizedBox(height: 32),

                  // 🚪 Navigation Back
                  _SettingTile(
                    icon: Icons.logout,
                    label: 'Back to Splash',
                    onTap: () => toSplash(context, false),
                  ),

                  // ⚙️ Dummy Settings
                  const _SettingTile(icon: Icons.language, label: 'Language'),
                  const _SettingTile(icon: Icons.notifications, label: 'Notification Settings'),
                  const _SettingTile(icon: Icons.lock, label: 'Privacy & Security'),
                  const _SettingTile(icon: Icons.info, label: 'About This App'),
                  const _SettingTile(icon: Icons.help_outline, label: 'Help & Support'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SettingTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback? onTap;

  const _SettingTile({
    required this.icon,
    required this.label,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon, color: Colors.deepPurple),
      title: Text(label, style: const TextStyle(fontSize: 16)),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap ??
              () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('$label is not implemented yet')),
            );
          },
    );
  }
}
