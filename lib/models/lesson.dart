enum LessonCategory { kanji, vocabulary, grammar }

extension LessonCategoryInfo on LessonCategory {
  String get label => switch (this) {
    LessonCategory.kanji => 'Kanji',
    LessonCategory.vocabulary => 'Vocabulary',
    LessonCategory.grammar => 'Grammar',
  };
  String get description => switch (this) {
    LessonCategory.kanji => 'Characters, readings, and useful compounds',
    LessonCategory.vocabulary => 'Everyday words and example sentences',
    LessonCategory.grammar => 'Essential patterns used in conversation',
  };
}

class LessonCardData {
  const LessonCardData({
    required this.front,
    required this.title,
    required this.subtitle,
    required this.details,
    required this.example,
    required this.translation,
  });
  final String front;
  final String title;
  final String subtitle;
  final String details;
  final String example;
  final String translation;
}

class LessonUnitData {
  const LessonUnitData({
    required this.title,
    required this.summary,
    required this.cards,
  });
  final String title;
  final String summary;
  final List<LessonCardData> cards;
}
