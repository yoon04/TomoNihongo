// screens/kanji_unit_screen.dart
import 'package:flutter/material.dart';
import 'dashboard_screen.dart';
import 'streak_screen.dart';
import 'profile_screen.dart';

class KanjiUnitScreen extends StatefulWidget {
  final String level;
  final int unitNumber;

  const KanjiUnitScreen({
    super.key,
    required this.level,
    required this.unitNumber,
  });

  @override
  State<KanjiUnitScreen> createState() => _KanjiUnitScreenState();
}

class _KanjiUnitScreenState extends State<KanjiUnitScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _flipController;
  late Animation<double> _flipAnimation;
  bool _isFlipped = false;
  bool _showDetails = false;

  int _currentKanjiIndex = 0;

  final List<Map<String, String>> kanjiList = [
    {
      "kanji": "日",
      "onyomi": "ニチ / ジツ",
      "kunyomi": "ひ / -び / -か",
      "meaning": "Day, Sun",
      "compounds": "日本 (にほん) - Japan\n毎日 (まいにち) - Every day\n日曜日 (にちようび) - Sunday",
      "example": "今日はいい天気です。\nToday is a nice day."
    },
    {
      "kanji": "山",
      "onyomi": "サン",
      "kunyomi": "やま",
      "meaning": "Mountain",
      "compounds": "富士山 (ふじさん) - Mt. Fuji\n山道 (やまみち) - Mountain path",
      "example": "山に登りました。\nI climbed the mountain."
    },
    {
      "kanji": "人",
      "onyomi": "ジン / ニン",
      "kunyomi": "ひと",
      "meaning": "Person, Human",
      "compounds": "日本人 (にほんじん) - Japanese person\n人間 (にんげん) - Human being",
      "example": "あの人は親切です。\nThat person is kind."
    },
    {
      "kanji": "水",
      "onyomi": "スイ",
      "kunyomi": "みず",
      "meaning": "Water",
      "compounds": "水曜日 (すいようび) - Wednesday\n清水 (しみず) - Clear water",
      "example": "水を飲んでください。\nPlease drink water."
    },
  ];

  @override
  void initState() {
    super.initState();
    _flipController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _flipAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _flipController, curve: Curves.easeInOut),
    );
  }

  void _flipCard() {
    if (_isFlipped) {
      _flipController.reverse();
    } else {
      _flipController.forward();
    }
    _isFlipped = !_isFlipped;
  }

  void _nextKanji() {
    setState(() {
      _currentKanjiIndex = (_currentKanjiIndex + 1) % kanjiList.length;
      _isFlipped = false;      // Reset to front (kanji character)
      _showDetails = false;    // Hide details
    });
  }

  void _previousKanji() {
    setState(() {
      _currentKanjiIndex = (_currentKanjiIndex - 1 + kanjiList.length) % kanjiList.length;
      _isFlipped = false;      // Reset to front
      _showDetails = false;
    });
  }

  @override
  void dispose() {
    _flipController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentKanji = kanjiList[_currentKanjiIndex];
    final progress = (_currentKanjiIndex + 1) / kanjiList.length;

    return Scaffold(
      backgroundColor: const Color(0xFFF8F5EE),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF8F5EE),
        elevation: 0,
        centerTitle: true,
        title: Text(
          "JLPT ${widget.level} - Unit ${widget.unitNumber}",
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              // Progress Bar
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    Text(
                      "Kanji ${_currentKanjiIndex + 1} of ${kanjiList.length}",
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 12),
                    LinearProgressIndicator(
                      value: progress,
                      color: const Color(0xFFEE7A7A),
                      backgroundColor: Colors.grey[200],
                      minHeight: 8,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),
              const Text("Kanji Flashcard", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
              const SizedBox(height: 16),

              // Flip Card
              GestureDetector(
                onTap: _flipCard,
                child: AnimatedBuilder(
                  animation: _flipAnimation,
                  builder: (context, child) {
                    final angle = _flipAnimation.value * 3.14159;
                    return Transform(
                      transform: Matrix4.rotationY(angle),
                      alignment: Alignment.center,
                      child: Container(
                        width: double.infinity,
                        height: 280,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(24),
                          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.12), blurRadius: 20)],
                        ),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(24.0),
                            child: angle > 1.57
                                ? Transform(
                                    transform: Matrix4.rotationY(3.14159),
                                    alignment: Alignment.center,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(currentKanji["meaning"]!, style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
                                        const SizedBox(height: 16),
                                        Text("音読み: ${currentKanji["onyomi"]!}", style: const TextStyle(fontSize: 18)),
                                        Text("訓読み: ${currentKanji["kunyomi"]!}", style: const TextStyle(fontSize: 18)),
                                      ],
                                    ),
                                  )
                                : Text(
                                    currentKanji["kanji"]!,
                                    style: const TextStyle(fontSize: 130, fontWeight: FontWeight.bold),
                                  ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 12),
              const Text("Tap card to flip", style: TextStyle(color: Colors.grey, fontSize: 13)),

              const SizedBox(height: 30),

              // Previous & Next Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: _previousKanji,
                    icon: const Icon(Icons.arrow_back_ios, size: 28),
                  ),
                  const SizedBox(width: 40),
                  IconButton(
                    onPressed: _nextKanji,
                    icon: const Icon(Icons.arrow_forward_ios, size: 28),
                  ),
                ],
              ),

              const SizedBox(height: 30),

              // Learn More Button
              SizedBox(
                width: 200,
                height: 50,
                child: ElevatedButton(
                  onPressed: () => setState(() => _showDetails = !_showDetails),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFEE7A7A),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                  child: Text(
                    _showDetails ? "Hide Details" : "Learn more",
                    style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w600, color: Colors.white),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              if (_showDetails)
                Container(
                  padding: const EdgeInsets.all(30),
                  width: 300,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Meaning: ${currentKanji["meaning"]!}", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 12),
                      Text("音読み: ${currentKanji["onyomi"]!}", style: const TextStyle(fontSize: 18)),
                      Text("訓読み: ${currentKanji["kunyomi"]!}", style: const TextStyle(fontSize: 18)),
                      const SizedBox(height: 16),
                      const Text("Common Compounds:", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      Text(currentKanji["compounds"]!, style: const TextStyle(fontSize: 18)),
                      const SizedBox(height: 16),
                      const Text("Example Sentence:", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      Text(currentKanji["example"]!, style: const TextStyle(fontSize: 18)),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),

      // Bottom Navigation Bar (Same as Lessons Screen)
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
        onTap: (index) {
          if (index == 0) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => const DashboardScreen()),
              (route) => false,
            );
          } else if (index == 2) {
            Navigator.push(context, MaterialPageRoute(builder: (_) => const StreakScreen()));
          } else if (index == 3) {
            Navigator.push(context, MaterialPageRoute(builder: (_) => const ProfileScreen()));
          }
        },
        selectedItemColor: const Color(0xFFEE7A7A),
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_rounded), label: "Dashboard"),
          BottomNavigationBarItem(icon: Icon(Icons.school_rounded), label: "Learn"),
          BottomNavigationBarItem(icon: Icon(Icons.local_fire_department_rounded), label: "Streak"),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline_rounded), label: "Profile"),
        ],
      ),
    );
  }
}