// screens/profile_screen.dart
import 'package:flutter/material.dart';
import 'dashboard_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String userName = "Alex Chen";
  String userEmail = "alexchen@gmail.com";
  String? profileImagePath; // For future real image upload

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F5EE),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF8F5EE),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Profile",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black87),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(height: 20),

              // Profile Picture with Upload
              Center(
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 65,
                      backgroundColor: const Color(0xFFEE7A7A),
                      backgroundImage: profileImagePath != null 
                          ? AssetImage(profileImagePath!) 
                          : null,
                      child: profileImagePath == null 
                          ? const Icon(Icons.person, size: 80, color: Colors.white)
                          : null,
                    ),
                    Positioned(
                      bottom: 8,
                      right: 8,
                      child: GestureDetector(
                        onTap: _showImageSourceOptions,
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: const BoxDecoration(
                            color: Color(0xFFEE7A7A),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.camera_alt, color: Colors.white, size: 22),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),
              Text(userName, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              Text(userEmail, style: const TextStyle(fontSize: 16, color: Colors.black54)),

              const SizedBox(height: 40),

              // Stats
              Row(
                children: [
                  _buildStatCard("Current Level", "N5", "Intermediate"),
                  const SizedBox(width: 12),
                  _buildStatCard("Streak", "12", "Days"),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  _buildStatCard("Lessons Done", "47", ""),
                  const SizedBox(width: 12),
                  _buildStatCard("Kanji Mastered", "89", ""),
                ],
              ),

              const SizedBox(height: 40),

              // Menu Sections
              _buildMenuTile(Icons.emoji_events_outlined, "Achievements", "View your badges & milestones"),
              _buildMenuTile(Icons.history, "Learning History"),
              _buildMenuTile(Icons.bookmark_border, "Bookmarks"),
              _buildMenuTile(Icons.settings, "Settings"),
              _buildMenuTile(Icons.help_outline, "Help & Support"),
              _buildMenuTile(Icons.share, "Share App"),

              const SizedBox(height: 40),

              // Logout
              SizedBox(
                width: double.infinity,
                height: 56,
                child: OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Color(0xFFEE7A7A)),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                  child: const Text(
                    "Logout",
                    style: TextStyle(fontSize: 17, color: Color(0xFFEE7A7A), fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 3,
        onTap: (index) {
          if (index == 0) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => const DashboardScreen()),
              (route) => false,
            );
          }
        },
        selectedItemColor: const Color(0xFFEE7A7A),
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_rounded), label: "Dashboard"),
          BottomNavigationBarItem(icon: Icon(Icons.school_rounded), label: "Learn"),
          BottomNavigationBarItem(icon: Icon(Icons.quiz_rounded), label: "Quiz"),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline_rounded), label: "Profile"),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value, String subtitle) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 10)],
        ),
        child: Column(
          children: [
            Text(title, style: const TextStyle(fontSize: 13, color: Colors.black54)),
            const SizedBox(height: 8),
            Text(value, style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Color(0xFFEE7A7A))),
            if (subtitle.isNotEmpty)
              Text(subtitle, style: const TextStyle(fontSize: 13)),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuTile(IconData icon, String title, [String? subtitle]) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      leading: Icon(icon, color: Colors.black87, size: 28),
      title: Text(title, style: const TextStyle(fontSize: 17)),
      subtitle: subtitle != null ? Text(subtitle, style: const TextStyle(color: Colors.black54)) : null,
      trailing: const Icon(Icons.arrow_forward_ios, size: 18, color: Colors.grey),
      onTap: () {
        // TODO: Add navigation for each section
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("$title tapped")),
        );
      },
    );
  }

  void _showImageSourceOptions() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text("Choose from Gallery"),
                onTap: () {
                  Navigator.pop(context);
                  // TODO: Add image_picker later
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Gallery feature coming soon")),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text("Take a Photo"),
                onTap: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Camera feature coming soon")),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}