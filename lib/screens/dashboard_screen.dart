// screens/dashboard_screen.dart
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'lessons_screen.dart';
import 'subscription_screen.dart';   // ← Make sure this import exists
import 'streak_screen.dart';
import 'profile_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _currentIndex = 0;
  String selectedLevel = "N5";

  final List<FeaturePost> featurePosts = [
    FeaturePost(
      title: "Master Hiragana in 7 Days",
      description: "Complete guide with audio, quizzes & mnemonics",
      imagePath: "assets/images/banner1.jpg",
      tag: "Beginner",
    ),
    FeaturePost(
      title: "JLPT N5 Full Preparation",
      description: "Vocabulary • Grammar • Kanji • Listening",
      imagePath: "assets/images/banner2.jpg",
      tag: "N5",
    ),
    FeaturePost(
      title: "Daily Conversation Practice",
      description: "Speak like a native with real dialogues",
      imagePath: "assets/images/banner3.jpg",
      tag: "Speaking",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F5EE),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF8F5EE),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Tomo Nihongo",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black87),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined, color: Colors.black87, size: 28),
            onPressed: () {},
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Welcome Row
              Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ProfileScreen())),
                    child: const CircleAvatar(
                      radius: 28,
                      backgroundColor: Color(0xFFEE7A7A),
                      child: Icon(Icons.person, color: Colors.white, size: 32),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text("Welcome, Alex! 👋", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                        Text("Let's continue your Japanese journey", style: TextStyle(fontSize: 14, color: Colors.black54)),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 30),

              // Rotating Banner
              CarouselSlider.builder(
                itemCount: featurePosts.length,
                options: CarouselOptions(
                  height: 200,
                  autoPlay: true,
                  enlargeCenterPage: true,
                  viewportFraction: 0.92,
                ),
                itemBuilder: (context, index, realIdx) {
                  final post = featurePosts[index];
                  return Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                            image: AssetImage(post.imagePath),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [Colors.transparent, Colors.black.withOpacity(0.75)],
                          ),
                        ),
                      ),
                      Positioned(
                        top: 16,
                        right: 16,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: const Color(0xFFEE7A7A),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(post.tag, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                        ),
                      ),
                      Positioned(
                        bottom: 20,
                        left: 20,
                        right: 20,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(post.title, style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                            Text(post.description, style: const TextStyle(color: Colors.white70, fontSize: 14)),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),

              const SizedBox(height: 32),

              const Text("Choose your Japanese Level", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 24),

              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildLevelBox("N5"),
                      const SizedBox(width: 16),
                      _buildLevelBox("N4"),
                      const SizedBox(width: 16),
                      _buildLevelBox("N3"),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(width: 84),
                      _buildLevelBox("N2"),
                      const SizedBox(width: 22),
                      _buildLevelBox("N1"),
                      const SizedBox(width: 60),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),

      // Bottom Navigation with your requested onTap logic
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() => _currentIndex = index);

          if (index == 1) {
            // Subscription
            Navigator.push(context, MaterialPageRoute(builder: (_) => const SubscriptionScreen()));
          } else if (index == 2) {
            // Streak
            Navigator.push(context, MaterialPageRoute(builder: (_) => const StreakScreen()));
          } else if (index == 3) {
            // Profile
            Navigator.push(context, MaterialPageRoute(builder: (_) => const ProfileScreen()));
          }
        },
        selectedItemColor: const Color(0xFFEE7A7A),
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_rounded), label: "Dashboard"),
          BottomNavigationBarItem(icon: Icon(Icons.workspace_premium), label: "Subscription"),
          BottomNavigationBarItem(icon: Icon(Icons.local_fire_department_rounded), label: "Streak"),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline_rounded), label: "Profile"),
        ],
      ),
    );
  }

  Widget _buildLevelBox(String level) {
    final isSelected = selectedLevel == level;
    return GestureDetector(
      onTap: () {
        setState(() => selectedLevel = level);
        Navigator.push(context, MaterialPageRoute(builder: (_) => LessonsScreen(level: level)));
      },
      child: Container(
        width: 92,
        height: 92,
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFEE7A7A) : Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 12, spreadRadius: 2)],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              level,
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: isSelected ? Colors.white : const Color(0xFFEE7A7A),
              ),
            ),
            Text(
              "JLPT",
              style: TextStyle(
                fontSize: 13,
                color: isSelected ? Colors.white70 : Colors.black54,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FeaturePost {
  final String title;
  final String description;
  final String imagePath;
  final String tag;

  FeaturePost({
    required this.title,
    required this.description,
    required this.imagePath,
    required this.tag,
  });
}