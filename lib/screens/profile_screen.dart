import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

import 'dashboard_screen.dart';
import 'profile_features_screen.dart';
import 'streak_screen.dart';
import 'subscription_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _picker = ImagePicker();
  Uint8List? _profileImage;
  bool _pickingImage = false;

  Future<void> _pickImage(ImageSource source) async {
    Navigator.pop(context);
    setState(() => _pickingImage = true);
    try {
      final image = await _picker.pickImage(
        source: source,
        imageQuality: 82,
        maxWidth: 1200,
      );
      if (image == null) return;
      final bytes = await image.readAsBytes();
      if (!mounted) return;
      setState(() => _profileImage = bytes);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Profile photo updated')));
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Could not open that image source. Please try another option.',
          ),
        ),
      );
    } finally {
      if (mounted) setState(() => _pickingImage = false);
    }
  }

  void _showImageSourceOptions() {
    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const ListTile(
              title: Text(
                'Update profile photo',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.photo_library_outlined),
              title: const Text('Choose from gallery'),
              onTap: () => _pickImage(ImageSource.gallery),
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt_outlined),
              title: const Text('Take a photo'),
              onTap: () => _pickImage(ImageSource.camera),
            ),
            if (_profileImage != null)
              ListTile(
                leading: const Icon(
                  Icons.delete_outline,
                  color: Colors.redAccent,
                ),
                title: const Text('Remove photo'),
                onTap: () {
                  Navigator.pop(context);
                  setState(() => _profileImage = null);
                },
              ),
          ],
        ),
      ),
    );
  }

  void _open(Widget page) =>
      Navigator.push(context, MaterialPageRoute(builder: (_) => page));

  @override
  Widget build(BuildContext context) {
    final menuItems =
        <({IconData icon, String title, String subtitle, VoidCallback action})>[
          (
            icon: Icons.emoji_events_outlined,
            title: 'Achievements',
            subtitle: 'Badges and milestones',
            action: () => _open(const AchievementsScreen()),
          ),
          (
            icon: Icons.history_rounded,
            title: 'Learning history',
            subtitle: 'Your recent study activity',
            action: () => _open(const LearningHistoryScreen()),
          ),
          (
            icon: Icons.bookmark_border_rounded,
            title: 'Bookmarks',
            subtitle: 'Saved words and grammar',
            action: () => _open(const BookmarksScreen()),
          ),
          (
            icon: Icons.settings_outlined,
            title: 'Settings',
            subtitle: 'Goals, reminders, and display',
            action: () => _open(const SettingsScreen()),
          ),
          (
            icon: Icons.help_outline_rounded,
            title: 'Help & support',
            subtitle: 'Answers and contact information',
            action: _showHelp,
          ),
          (
            icon: Icons.share_outlined,
            title: 'Share app',
            subtitle: 'Invite a Japanese study friend',
            action: _shareApp,
          ),
        ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Profile',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 820),
              child: Column(
                children: [
                  const SizedBox(height: 8),
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: 63,
                        backgroundColor: const Color(0xFFE96F72),
                        backgroundImage: _profileImage == null
                            ? null
                            : MemoryImage(_profileImage!),
                        child: _profileImage == null
                            ? const Icon(
                                Icons.person,
                                size: 74,
                                color: Colors.white,
                              )
                            : null,
                      ),
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: IconButton.filled(
                          tooltip: 'Update profile photo',
                          onPressed: _pickingImage
                              ? null
                              : _showImageSourceOptions,
                          icon: _pickingImage
                              ? const SizedBox.square(
                                  dimension: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: Colors.white,
                                  ),
                                )
                              : const Icon(Icons.camera_alt_outlined),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  const Text(
                    'Alex Chen',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    'alexchen@gmail.com',
                    style: TextStyle(color: Colors.black54),
                  ),
                  const SizedBox(height: 28),
                  LayoutBuilder(
                    builder: (context, constraints) {
                      final columns = constraints.maxWidth >= 650 ? 4 : 2;
                      const stats = [
                        ('N5', 'Current level'),
                        ('12', 'Day streak'),
                        ('47', 'Lessons done'),
                        ('89', 'Kanji mastered'),
                      ];
                      return GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: stats.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: columns,
                          mainAxisExtent: 118,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                        ),
                        itemBuilder: (context, index) => Card(
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  stats[index].$1,
                                  style: const TextStyle(
                                    fontSize: 26,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFFE96F72),
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  stats[index].$2,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(color: Colors.black54),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 24),
                  Card(
                    child: Column(
                      children: [
                        for (
                          var index = 0;
                          index < menuItems.length;
                          index++
                        ) ...[
                          ListTile(
                            leading: Icon(menuItems[index].icon),
                            title: Text(
                              menuItems[index].title,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            subtitle: Text(menuItems[index].subtitle),
                            trailing: const Icon(Icons.chevron_right),
                            onTap: menuItems[index].action,
                          ),
                          if (index != menuItems.length - 1)
                            const Divider(height: 1, indent: 56),
                        ],
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      icon: const Icon(Icons.logout),
                      label: const Text('Log out'),
                      onPressed: () => Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const DashboardScreen(),
                        ),
                        (_) => false,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: 3,
        onDestinationSelected: (index) {
          if (index == 0) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => const DashboardScreen()),
              (_) => false,
            );
          } else if (index == 1) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const SubscriptionScreen()),
            );
          } else if (index == 2) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const StreakScreen()),
            );
          }
        },
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), label: 'Home'),
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
            selectedIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  void _showHelp() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Help & support'),
        content: const Text(
          'Choose a JLPT level from Home, open a unit, and use Learn or Review.\n\nFor support, email support@tomonihongo.app.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  Future<void> _shareApp() async {
    await Clipboard.setData(
      const ClipboardData(text: 'Study Japanese with Tomo Nihongo!'),
    );
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Invitation copied to clipboard')),
    );
  }
}
