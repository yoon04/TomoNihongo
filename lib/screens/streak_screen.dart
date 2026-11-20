// screens/streak_screen.dart
import 'package:flutter/material.dart';
import 'dashboard_screen.dart';
import 'profile_screen.dart';
import 'subscription_screen.dart';

class StreakScreen extends StatefulWidget {
  const StreakScreen({super.key});

  @override
  State<StreakScreen> createState() => _StreakScreenState();
}

class _StreakScreenState extends State<StreakScreen> {
  final int currentStreak = 12;
  final int longestStreak = 47;
  final int streakGoal = 30;

  // Sample streak days (for demonstration)
  final Set<int> streakDays = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12};

  DateTime _currentDate = DateTime(DateTime.now().year, DateTime.now().month);

  void _goToPreviousMonth() {
    setState(() {
      _currentDate = DateTime(_currentDate.year, _currentDate.month - 1);
    });
  }

  void _goToNextMonth() {
    setState(() {
      _currentDate = DateTime(_currentDate.year, _currentDate.month + 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F5EE),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF8F5EE),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Streak",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 720),
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  // Current Streak
                  Container(
                    padding: const EdgeInsets.all(32),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Column(
                      children: [
                        const Text(
                          "Current Streak",
                          style: TextStyle(fontSize: 18, color: Colors.black54),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "$currentStreak",
                              style: const TextStyle(
                                fontSize: 80,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFEE7A7A),
                              ),
                            ),
                            const Text(
                              "days",
                              style: TextStyle(
                                fontSize: 24,
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),
                        const Text(
                          " Amazing!",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Stats
                  Row(
                    children: [
                      _buildStatBox(
                        "Longest Streak",
                        "$longestStreak days",
                        Icons.emoji_events,
                      ),
                      const SizedBox(width: 12),
                      _buildStatBox("Goal", "$streakGoal days", Icons.flag),
                    ],
                  ),

                  const SizedBox(height: 40),

                  // Calendar Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: _goToPreviousMonth,
                        icon: const Icon(Icons.chevron_left),
                      ),
                      Text(
                        "${_getMonthName(_currentDate.month)} ${_currentDate.year}",
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        onPressed: _goToNextMonth,
                        icon: const Icon(Icons.chevron_right),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // Weekday Headers
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: const ["S", "M", "T", "W", "T", "F", "S"]
                        .map(
                          (e) => Text(
                            e,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.black54,
                            ),
                          ),
                        )
                        .toList(),
                  ),

                  const SizedBox(height: 12),

                  // Calendar Grid (Circle Style)
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 7,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 8,
                        ),
                    itemCount: 42, // 6 weeks
                    itemBuilder: (context, index) {
                      final firstDayOfMonth =
                          DateTime(
                            _currentDate.year,
                            _currentDate.month,
                            1,
                          ).weekday %
                          7;
                      final day = index - firstDayOfMonth + 1;

                      final daysInMonth = DateTime(
                        _currentDate.year,
                        _currentDate.month + 1,
                        0,
                      ).day;
                      final isCurrentMonth = day > 0 && day <= daysInMonth;
                      final hasStreak =
                          isCurrentMonth && streakDays.contains(day);

                      return Center(
                        child: Container(
                          width: 36,
                          height: 36,
                          decoration: BoxDecoration(
                            color: hasStreak
                                ? const Color(0xFFEE7A7A)
                                : Colors.transparent,
                            shape: BoxShape.circle,
                            border: hasStreak
                                ? null
                                : Border.all(color: Colors.grey.shade300),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            isCurrentMonth ? "$day" : "",
                            style: TextStyle(
                              color: hasStreak ? Colors.white : Colors.black87,
                              fontWeight: hasStreak
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                            ),
                          ),
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 40),

                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEE7A7A).withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      "Consistency beats perfection.\nYou're building a strong habit!",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16, height: 1.5),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 2,
        onTap: (index) {
          if (index == 0) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => const DashboardScreen()),
              (route) => false,
            );
          } else if (index == 1) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const SubscriptionScreen()),
            );
          } else if (index == 3) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const ProfileScreen()),
            );
          }
        },
        selectedItemColor: const Color(0xFFEE7A7A),
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded),
            label: "Dashboard",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.workspace_premium_outlined),
            label: "Premium",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_fire_department_rounded),
            label: "Streak",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline_rounded),
            label: "Profile",
          ),
        ],
      ),
    );
  }

  String _getMonthName(int month) {
    const months = [
      "January",
      "February",
      "March",
      "April",
      "May",
      "June",
      "July",
      "August",
      "September",
      "October",
      "November",
      "December",
    ];
    return months[month - 1];
  }

  Widget _buildStatBox(String title, String value, IconData icon) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            Icon(icon, color: const Color(0xFFEE7A7A), size: 32),
            const SizedBox(height: 12),
            Text(
              value,
              style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
            Text(
              title,
              style: const TextStyle(fontSize: 13, color: Colors.black54),
            ),
          ],
        ),
      ),
    );
  }
}
