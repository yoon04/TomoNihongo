import 'package:flutter/material.dart';

class AchievementsScreen extends StatelessWidget {
  const AchievementsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const achievements = [
      ('First Step', 'Completed your first lesson', Icons.flag_rounded, true),
      (
        'On Fire',
        'Studied for 7 days in a row',
        Icons.local_fire_department,
        true,
      ),
      ('Kanji Rookie', 'Mastered 25 kanji', Icons.translate_rounded, true),
      ('Perfect Review', 'Scored 100% in a review', Icons.stars_rounded, false),
      ('Early Bird', 'Study before 8:00 AM', Icons.wb_sunny_rounded, false),
      ('N5 Explorer', 'Complete every N5 unit', Icons.map_rounded, false),
    ];
    return _FeatureScaffold(
      title: 'Achievements',
      child: LayoutBuilder(
        builder: (context, constraints) {
          final columns = constraints.maxWidth >= 700
              ? 3
              : constraints.maxWidth >= 430
              ? 2
              : 1;
          return GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: columns,
              mainAxisExtent: 250,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
            ),
            itemCount: achievements.length,
            itemBuilder: (context, index) {
              final item = achievements[index];
              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(18),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: item.$4
                            ? const Color(0xFFFFE1E0)
                            : Colors.black12,
                        child: Icon(
                          item.$3,
                          color: item.$4
                              ? const Color(0xFFE96F72)
                              : Colors.black38,
                          size: 32,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        item.$1,
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        item.$2,
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: Colors.black54),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        item.$4 ? 'Unlocked' : 'Locked',
                        style: TextStyle(
                          color: item.$4
                              ? const Color(0xFFE96F72)
                              : Colors.black38,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class LearningHistoryScreen extends StatelessWidget {
  const LearningHistoryScreen({super.key});
  @override
  Widget build(BuildContext context) {
    const history = [
      ('Today', 'N5 · Vocabulary · Unit 1', '4 cards reviewed', 1.0),
      ('Yesterday', 'N5 · Kanji · Unit 2', 'Lesson completed', .8),
      ('Monday', 'N4 · Grammar · Unit 1', '2 cards reviewed', .5),
      ('Last Friday', 'N5 · Kanji · Unit 1', 'Lesson completed', 1.0),
    ];
    return _FeatureScaffold(
      title: 'Learning history',
      child: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: history.length,
        separatorBuilder: (_, _) => const SizedBox(height: 10),
        itemBuilder: (context, index) {
          final item = history[index];
          return Card(
            child: ListTile(
              contentPadding: const EdgeInsets.all(16),
              leading: const CircleAvatar(child: Icon(Icons.school_outlined)),
              title: Text(
                item.$2,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 5),
                  Text('${item.$1} · ${item.$3}'),
                  const SizedBox(height: 10),
                  LinearProgressIndicator(
                    value: item.$4,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class BookmarksScreen extends StatefulWidget {
  const BookmarksScreen({super.key});
  @override
  State<BookmarksScreen> createState() => _BookmarksScreenState();
}

class _BookmarksScreenState extends State<BookmarksScreen> {
  final items = <(String, String)>[
    ('日 · Day / Sun', 'N5 Kanji'),
    ('V ませんか', 'N5 Grammar'),
    ('にもかかわらず', 'N2 Grammar'),
  ];
  @override
  Widget build(BuildContext context) => _FeatureScaffold(
    title: 'Bookmarks',
    child: items.isEmpty
        ? const Center(child: Text('No bookmarks yet.'))
        : ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: items.length,
            separatorBuilder: (_, _) => const SizedBox(height: 8),
            itemBuilder: (context, index) => Card(
              child: ListTile(
                leading: const Icon(Icons.bookmark, color: Color(0xFFE96F72)),
                title: Text(
                  items[index].$1,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(items[index].$2),
                trailing: IconButton(
                  tooltip: 'Remove bookmark',
                  icon: const Icon(Icons.delete_outline),
                  onPressed: () {
                    final removed = items.removeAt(index);
                    setState(() {});
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('${removed.$1} removed')),
                    );
                  },
                ),
              ),
            ),
          ),
  );
}

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});
  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool reminders = true;
  bool sound = true;
  bool romaji = false;
  double dailyGoal = 15;

  @override
  Widget build(BuildContext context) => _FeatureScaffold(
    title: 'Settings',
    child: ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const _SectionTitle('Learning'),
        Card(
          child: Column(
            children: [
              SwitchListTile(
                value: romaji,
                onChanged: (value) => setState(() => romaji = value),
                title: const Text('Show romaji'),
                subtitle: const Text(
                  'Display Latin readings under Japanese text',
                ),
              ),
              SwitchListTile(
                value: sound,
                onChanged: (value) => setState(() => sound = value),
                title: const Text('Sound effects'),
                subtitle: const Text('Play feedback sounds during reviews'),
              ),
              ListTile(
                title: const Text('Daily goal'),
                subtitle: Slider(
                  value: dailyGoal,
                  min: 5,
                  max: 60,
                  divisions: 11,
                  label: '${dailyGoal.round()} min',
                  onChanged: (value) => setState(() => dailyGoal = value),
                ),
                trailing: Text('${dailyGoal.round()} min'),
              ),
            ],
          ),
        ),
        const SizedBox(height: 18),
        const _SectionTitle('Notifications'),
        Card(
          child: SwitchListTile(
            value: reminders,
            onChanged: (value) => setState(() => reminders = value),
            title: const Text('Study reminders'),
            subtitle: const Text('Remind me to maintain my streak'),
          ),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () => ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('Settings saved'))),
          child: const Text('Save settings'),
        ),
      ],
    ),
  );
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle(this.text);
  final String text;
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(left: 4, bottom: 8),
    child: Text(
      text,
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    ),
  );
}

class _FeatureScaffold extends StatelessWidget {
  const _FeatureScaffold({required this.title, required this.child});
  final String title;
  final Widget child;
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
    ),
    body: SafeArea(
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 900),
          child: child,
        ),
      ),
    ),
  );
}
