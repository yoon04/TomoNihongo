import 'package:flutter/material.dart';
import '../models/lesson.dart';

class KanjiUnitScreen extends StatefulWidget {
  const KanjiUnitScreen({
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
  State<KanjiUnitScreen> createState() => _KanjiUnitScreenState();
}

class _KanjiUnitScreenState extends State<KanjiUnitScreen> {
  int index = 0;
  bool flipped = false;
  bool showDetails = false;

  void _move(int delta) {
    setState(() {
      index =
          (index + delta + widget.unit.cards.length) % widget.unit.cards.length;
      flipped = false;
      showDetails = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final card = widget.unit.cards[index];
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${widget.category.label} · Unit ${widget.unitNumber}',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final cardHeight = constraints.maxHeight < 600 ? 230.0 : 290.0;
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 680),
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
                          Text(
                            '${index + 1}/${widget.unit.cards.length}',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Semantics(
                        button: true,
                        label: 'Study card. Tap to flip.',
                        child: InkWell(
                          borderRadius: BorderRadius.circular(24),
                          onTap: () => setState(() => flipped = !flipped),
                          child: AnimatedSwitcher(
                            duration: const Duration(milliseconds: 250),
                            transitionBuilder: (child, animation) =>
                                FadeTransition(
                                  opacity: animation,
                                  child: ScaleTransition(
                                    scale: Tween(
                                      begin: .96,
                                      end: 1.0,
                                    ).animate(animation),
                                    child: child,
                                  ),
                                ),
                            child: Container(
                              key: ValueKey(flipped),
                              width: double.infinity,
                              height: cardHeight,
                              padding: const EdgeInsets.all(24),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(24),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Color(0x16000000),
                                    blurRadius: 18,
                                  ),
                                ],
                              ),
                              child: flipped
                                  ? Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          card.title,
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                            fontSize: 27,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 12),
                                        Text(
                                          card.subtitle,
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                            fontSize: 17,
                                            color: Colors.black54,
                                          ),
                                        ),
                                      ],
                                    )
                                  : Center(
                                      child: FittedBox(
                                        fit: BoxFit.scaleDown,
                                        child: Text(
                                          card.front,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize:
                                                widget.category ==
                                                    LessonCategory.kanji
                                                ? 118
                                                : 50,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Tap the card to reveal the answer',
                        style: TextStyle(color: Colors.black45),
                      ),
                      const SizedBox(height: 14),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton.filledTonal(
                            tooltip: 'Previous card',
                            onPressed: () => _move(-1),
                            icon: const Icon(Icons.arrow_back),
                          ),
                          TextButton.icon(
                            onPressed: () =>
                                setState(() => showDetails = !showDetails),
                            icon: Icon(
                              showDetails
                                  ? Icons.expand_less
                                  : Icons.menu_book_outlined,
                            ),
                            label: Text(
                              showDetails ? 'Hide notes' : 'Show notes',
                            ),
                          ),
                          IconButton.filled(
                            tooltip: 'Next card',
                            onPressed: () => _move(1),
                            icon: const Icon(Icons.arrow_forward),
                          ),
                        ],
                      ),
                      AnimatedSize(
                        duration: const Duration(milliseconds: 220),
                        child: showDetails
                            ? Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(20),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Notes',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        card.details,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          height: 1.5,
                                        ),
                                      ),
                                      const Divider(height: 28),
                                      Text(
                                        card.example,
                                        style: const TextStyle(
                                          fontSize: 19,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        card.translation,
                                        style: const TextStyle(
                                          color: Colors.black54,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            : const SizedBox.shrink(),
                      ),
                      if (index == widget.unit.cards.length - 1) ...[
                        const SizedBox(height: 14),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            icon: const Icon(Icons.check_circle_outline),
                            label: const Text('Finish lesson'),
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'Lesson complete — great work!',
                                  ),
                                ),
                              );
                              Navigator.pop(context);
                            },
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
