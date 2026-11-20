import 'package:flutter/material.dart';
import '../models/lesson.dart';
import '../theme/app_theme.dart';

class ReviewKanjiUnitScreen extends StatefulWidget {
  const ReviewKanjiUnitScreen({
    super.key,
    required this.level,
    required this.unitNumber,
    required this.category,
    required this.unit,
  });
  final String level;
  final int unitNumber;
  final LessonCategory category;
  final LessonUnitData unit;
  @override
  State<ReviewKanjiUnitScreen> createState() => _ReviewKanjiUnitScreenState();
}

class _ReviewKanjiUnitScreenState extends State<ReviewKanjiUnitScreen> {
  int index = 0;
  int remembered = 0;
  bool revealed = false;
  bool complete = false;

  void _answer(bool knewIt) {
    if (knewIt) remembered++;
    if (index == widget.unit.cards.length - 1) {
      setState(() => complete = true);
    } else {
      setState(() {
        index++;
        revealed = false;
      });
    }
  }

  void _restart() => setState(() {
    index = 0;
    remembered = 0;
    revealed = false;
    complete = false;
  });

  @override
  Widget build(BuildContext context) {
    if (complete) {
      final score = (remembered / widget.unit.cards.length * 100).round();
      return Scaffold(
        appBar: AppBar(title: const Text('Review complete')),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 460),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(28),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.celebration_rounded,
                        size: 72,
                        color: AppTheme.coral,
                      ),
                      const SizedBox(height: 14),
                      Text(
                        '$score%',
                        style: const TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'You remembered $remembered of ${widget.unit.cards.length} cards.',
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 22),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _restart,
                          child: const Text('Review again'),
                        ),
                      ),
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Back to lessons'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    }

    final card = widget.unit.cards[index];
    return Scaffold(
      appBar: AppBar(title: Text('${widget.category.label} review')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 650),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: LinearProgressIndicator(
                          value: (index + 1) / widget.unit.cards.length,
                          minHeight: 8,
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text('${index + 1}/${widget.unit.cards.length}'),
                    ],
                  ),
                  const SizedBox(height: 22),
                  InkWell(
                    onTap: () => setState(() => revealed = true),
                    borderRadius: BorderRadius.circular(24),
                    child: Container(
                      width: double.infinity,
                      constraints: const BoxConstraints(minHeight: 285),
                      padding: const EdgeInsets.all(28),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: const [
                          BoxShadow(color: Color(0x16000000), blurRadius: 18),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              card.front,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize:
                                    widget.category == LessonCategory.kanji
                                    ? 110
                                    : 46,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          if (revealed) ...[
                            const Divider(height: 32),
                            Text(
                              card.title,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              card.subtitle,
                              textAlign: TextAlign.center,
                              style: const TextStyle(color: Colors.black54),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 18),
                  if (!revealed)
                    ElevatedButton.icon(
                      onPressed: () => setState(() => revealed = true),
                      icon: const Icon(Icons.visibility_outlined),
                      label: const Text('Show answer'),
                    )
                  else ...[
                    const Text(
                      'Did you remember it?',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () => _answer(false),
                            icon: const Icon(Icons.close),
                            label: const Text('Not yet'),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () => _answer(true),
                            icon: const Icon(Icons.check),
                            label: const Text('Got it'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
