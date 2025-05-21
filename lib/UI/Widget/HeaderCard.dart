import 'package:flutter/material.dart';

class HeaderCard extends StatelessWidget {
  final String name;
  final VoidCallback? onAction;

  const HeaderCard({
    super.key,
    required this.name,
    this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90, // tinggi tetap agar stabil
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF151E57), Color(0xFFF199FF)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const CircleAvatar(
            backgroundImage: AssetImage('assets/img/profile.jpg'),
            radius: 24,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Welcome Back,',
                  style: TextStyle(fontSize: 13, color: Colors.white70),
                ),
                Text(
                  name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: name.length > 16 ? 14 : 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.grid_view_rounded, color: Colors.white),
            onPressed: onAction ?? () {},
          ),
        ],
      ),
    );
  }
}
