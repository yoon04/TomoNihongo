import 'package:flutter/material.dart';
import '../data/sample_lessons.dart';
import '../models/lesson.dart';
import '../theme/app_theme.dart';
import 'kanji_unit_screen.dart';
import 'review_kanji_unit_screen.dart';

class LessonsScreen extends StatefulWidget {
  const LessonsScreen({super.key, required this.level});
  final String level;
  @override
  State<LessonsScreen> createState() => _LessonsScreenState();
}

class _LessonsScreenState extends State<LessonsScreen> {
  LessonCategory category = LessonCategory.kanji;
  @override
  Widget build(BuildContext context) {
    final units = sampleUnits(widget.level, category);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'JLPT ${widget.level}',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
                  child: SegmentedButton<LessonCategory>(
                    segments: LessonCategory.values
                        .map(
                          (value) => ButtonSegment(
                            value: value,
                            label: Text(value.label),
                          ),
                        )
                        .toList(),
                    selected: {category},
                    onSelectionChanged: (value) =>
                        setState(() => category = value.first),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 14, 20, 4),
                  child: Text(
                    category.description,
                    style: const TextStyle(color: Colors.black54),
                  ),
                ),
                Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.all(16),
                    itemCount: units.length,
                    separatorBuilder: (_, _) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final unit = units[index];
                      return Card(
                        child: Padding(
                          padding: const EdgeInsets.all(18),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: AppTheme.coral.withValues(
                                      alpha: .14,
                                    ),
                                    foregroundColor: AppTheme.coral,
                                    child: Text('${index + 1}'),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          unit.title,
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          unit.summary,
                                          style: const TextStyle(
                                            color: Colors.black54,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Text(
                                    '${unit.cards.length} cards',
                                    style: const TextStyle(
                                      color: Colors.black45,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              Wrap(
                                spacing: 10,
                                runSpacing: 10,
                                children: [
                                  ElevatedButton.icon(
                                    icon: const Icon(Icons.play_arrow_rounded),
                                    label: const Text('Learn'),
                                    onPressed: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => KanjiUnitScreen(
                                          level: widget.level,
                                          unitNumber: index + 1,
                                          category: category,
                                          unit: unit,
                                        ),
                                      ),
                                    ),
                                  ),
                                  OutlinedButton.icon(
                                    icon: const Icon(Icons.refresh_rounded),
                                    label: const Text('Review'),
                                    onPressed: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => ReviewKanjiUnitScreen(
                                          level: widget.level,
                                          unitNumber: index + 1,
                                          category: category,
                                          unit: unit,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
