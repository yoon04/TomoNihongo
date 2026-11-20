import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import 'lessons_screen.dart';
import 'profile_screen.dart';
import 'streak_screen.dart';
import 'subscription_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});
  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  String selectedLevel = 'N5';
  static const posts = [
    (
      'Master Hiragana in 7 Days',
      'Start with clear, bite-sized practice',
      'assets/images/banner1.jpg',
      'Beginner',
    ),
    (
      'JLPT N5 Starter Pack',
      'Kanji · Vocabulary · Grammar',
      'assets/images/banner2.jpg',
      'N5',
    ),
    (
      'Daily Conversation',
      'Useful Japanese for real situations',
      'assets/images/banner3.jpg',
      'Speaking',
    ),
  ];

  void _openNavigation(int index) {
    if (index == 0) return;
    final page = switch (index) {
      1 => const SubscriptionScreen(),
      2 => const StreakScreen(),
      _ => const ProfileScreen(),
    };
    Navigator.push(context, MaterialPageRoute(builder: (_) => page));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Tomo Nihongo',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            tooltip: 'Notifications',
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('You are all caught up!')),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final compact = constraints.maxWidth < 600;
            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: compact ? 16 : 32,
                vertical: 16,
              ),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 900),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          InkWell(
                            borderRadius: BorderRadius.circular(30),
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const ProfileScreen(),
                              ),
                            ),
                            child: const CircleAvatar(
                              radius: 27,
                              backgroundColor: AppTheme.coral,
                              child: Icon(
                                Icons.person,
                                color: Colors.white,
                                size: 30,
                              ),
                            ),
                          ),
                          const SizedBox(width: 14),
                          const Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Welcome back! 👋',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  'Let’s continue your Japanese journey',
                                  maxLines: 2,
                                  style: TextStyle(color: Colors.black54),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      CarouselSlider.builder(
                        itemCount: posts.length,
                        options: CarouselOptions(
                          height: compact ? 190 : 270,
                          autoPlay: true,
                          enlargeCenterPage: true,
                          viewportFraction: compact ? .94 : .82,
                        ),
                        itemBuilder: (context, index, _) {
                          final post = posts[index];
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(22),
                            child: Stack(
                              fit: StackFit.expand,
                              children: [
                                Image.asset(post.$3, fit: BoxFit.cover),
                                const DecoratedBox(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        Colors.transparent,
                                        Color(0xD9000000),
                                      ],
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 14,
                                  right: 14,
                                  child: Chip(
                                    label: Text(post.$4),
                                    backgroundColor: AppTheme.coral,
                                    labelStyle: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 18,
                                  right: 18,
                                  bottom: 18,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        post.$1,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: compact ? 19 : 24,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        post.$2,
                                        style: const TextStyle(
                                          color: Colors.white70,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 28),
                      const Text(
                        'Choose your Japanese level',
                        style: TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 6),
                      const Text(
                        'Sample lessons are available for every level.',
                        style: TextStyle(color: Colors.black54),
                      ),
                      const SizedBox(height: 18),
                      Center(
                        child: Wrap(
                          alignment: WrapAlignment.center,
                          spacing: 12,
                          runSpacing: 12,
                          children: ['N5', 'N4', 'N3', 'N2', 'N1']
                              .map(
                                (level) => _LevelCard(
                                  level: level,
                                  selected: selectedLevel == level,
                                  onTap: () {
                                    setState(() => selectedLevel = level);
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) =>
                                            LessonsScreen(level: level),
                                      ),
                                    );
                                  },
                                ),
                              )
                              .toList(),
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: 0,
        onDestinationSelected: _openNavigation,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.workspace_premium_outlined),
            label: 'Premium',
          ),
          NavigationDestination(
            icon: Icon(Icons.local_fire_department_outlined),
            label: 'Streak',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

class _LevelCard extends StatelessWidget {
  const _LevelCard({
    required this.level,
    required this.selected,
    required this.onTap,
  });
  final String level;
  final bool selected;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) => SizedBox(
    width: 108,
    height: 96,
    child: Material(
      color: selected ? AppTheme.coral : Colors.white,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              level,
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: selected ? Colors.white : AppTheme.coral,
              ),
            ),
            Text(
              'JLPT',
              style: TextStyle(
                color: selected ? Colors.white70 : Colors.black54,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
