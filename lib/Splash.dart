import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'Route.dart';

class Splash extends StatelessWidget {
  const Splash({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FF),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Icon(Icons.star_border, size: 28, color: Colors.purple),
                Icon(Icons.toggle_on, size: 32, color: Colors.deepPurple),
              ],
            ),
            Column(
              children: [
                Lottie.asset(
                  'assets/lottie/finance1.json',
                  height: 250,
                  width: double.maxFinite,
                  repeat: true,
                ),
                const SizedBox(height: 30),
                const Text.rich(
                  TextSpan(
                    text: 'Find way to\n',
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.black87),
                    children: [
                      TextSpan(text: 'manage ', style: TextStyle(color: Colors.pinkAccent)),
                      TextSpan(text: 'your ', style: TextStyle(color: Colors.purple)),
                      TextSpan(text: 'finance', style: TextStyle(color: Colors.deepPurple)),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                const Text(
                  'The most Transparent &\nSecurity Bank ever',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey, fontSize: 14),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  flex: 4,
                  child: ElevatedButton(
                    onPressed: () => toDashboard(context, false, ''),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFAF66F2),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: const Text(
                      'Get Started',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                    flex: 1,
                    child: Icon(Icons.qr_code_scanner, size: 28, color: Colors.black38))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
