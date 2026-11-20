// screens/review_kanji_unit_screen.dart
import 'package:flutter/material.dart';
// import 'dashboard_screen.dart';

class ReviewKanjiUnitScreen extends StatefulWidget {
  final String level;
  final int unitNumber;

  const ReviewKanjiUnitScreen({
    super.key,
    required this.level,
    required this.unitNumber,
  });

  @override
  State<ReviewKanjiUnitScreen> createState() => _ReviewKanjiUnitScreenState();
}

class _ReviewKanjiUnitScreenState extends State<ReviewKanjiUnitScreen> {
  bool _isFlipped = false;
  String? selectedFeedback;

  final Map<String, String> kanjiData = {
    "kanji": "日",
    "onyomi": "ニチ / ジツ",
    "kunyomi": "ひ / -び / -か",
    "meaning": "Day, Sun",
    "compounds": "日本 (にほん) - Japan",
    "example": "今日はいい天気です。",
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F5EE),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF8F5EE),
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Review - Unit ${widget.unitNumber}",
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const Text(
                "Review Mode",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                "JLPT ${widget.level}",
                style: const TextStyle(fontSize: 16, color: Colors.black54),
              ),
              const SizedBox(height: 30),

              // Flip Card
              GestureDetector(
                onTap: () => setState(() => _isFlipped = !_isFlipped),
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 500),
                  child: Container(
                    key: ValueKey<bool>(_isFlipped),
                    height: 280,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 20, spreadRadius: 5),
                      ],
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(24),
                        child: _isFlipped
                            ? Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(kanjiData["meaning"]!, style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                                  const SizedBox(height: 16),
                                  Text("音読み: ${kanjiData["onyomi"]!}", style: const TextStyle(fontSize: 18)),
                                  Text("訓読み: ${kanjiData["kunyomi"]!}", style: const TextStyle(fontSize: 18)),
                                ],
                              )
                            : Text(
                                kanjiData["kanji"]!,
                                style: const TextStyle(fontSize: 130, fontWeight: FontWeight.bold),
                              ),
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 12),
              const Text("Tap card to flip", style: TextStyle(color: Colors.grey)),

              const SizedBox(height: 40),

              // Feedback Section
              const Text("How well did you remember?", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
              const SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildFeedbackButton("😉", "Remembered"),
                  _buildFeedbackButton("😊", "Easy"),
                  _buildFeedbackButton("😕", "Hard"),
                  _buildFeedbackButton("😢", "Forgot"),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeedbackButton(String emoji, String label) {
    return GestureDetector(
      onTap: () {
        setState(() => selectedFeedback = emoji);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Feedback saved: $label"), duration: const Duration(seconds: 1)),
        );
      },
      child: Column(
        children: [
          Text(emoji, style: const TextStyle(fontSize: 42)),
          const SizedBox(height: 6),
          Text(label, style: const TextStyle(fontSize: 13)),
        ],
      ),
    );
  }
}