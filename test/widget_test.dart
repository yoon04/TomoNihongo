import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:tomo_nihongo/data/sample_lessons.dart';
import 'package:tomo_nihongo/main.dart';
import 'package:tomo_nihongo/models/lesson.dart';
import 'package:tomo_nihongo/screens/profile_screen.dart';
import 'package:tomo_nihongo/screens/streak_screen.dart';

void main() {
  testWidgets('dashboard opens lessons and switches categories', (
    tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Tomo Nihongo'), findsOneWidget);
    expect(find.text('Choose your Japanese level'), findsOneWidget);

    final n5Level = find.text('N5').last;
    await tester.ensureVisible(n5Level);
    await tester.pump(const Duration(milliseconds: 300));
    await tester.tap(n5Level);
    await tester.pumpAndSettle();

    expect(find.text('JLPT N5'), findsOneWidget);
    expect(find.text('Kanji'), findsOneWidget);

    await tester.tap(find.text('Vocabulary'));
    await tester.pumpAndSettle();
    expect(find.text('Everyday words and example sentences'), findsOneWidget);
    expect(find.textContaining('Hello'), findsOneWidget);
  });

  test('lesson samples differ by level and unit', () {
    final n5 = sampleUnits('N5', LessonCategory.kanji);
    final n4 = sampleUnits('N4', LessonCategory.kanji);

    expect(n5, hasLength(3));
    expect(n5.first.cards, hasLength(2));
    expect(n5.first.cards.first.front, isNot(n5[1].cards.first.front));
    expect(n5.first.cards.first.front, isNot(n4.first.cards.first.front));
  });

  testWidgets('profile features and photo choices are available', (
    tester,
  ) async {
    await tester.pumpWidget(const MaterialApp(home: ProfileScreen()));

    expect(find.text('Achievements'), findsOneWidget);
    expect(find.text('Learning history'), findsOneWidget);
    expect(find.text('Bookmarks'), findsOneWidget);
    expect(find.text('Settings'), findsOneWidget);

    await tester.tap(find.byTooltip('Update profile photo'));
    await tester.pumpAndSettle();
    expect(find.text('Choose from gallery'), findsOneWidget);
    expect(find.text('Take a photo'), findsOneWidget);

    await tester.tapAt(const Offset(10, 10));
    await tester.pumpAndSettle();
    final achievements = find.text('Achievements');
    await tester.ensureVisible(achievements);
    await tester.tap(achievements);
    await tester.pumpAndSettle();
    expect(find.text('First Step'), findsOneWidget);
  });

  testWidgets('streak page fits a wide web window', (tester) async {
    await tester.binding.setSurfaceSize(const Size(1440, 900));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(const MaterialApp(home: StreakScreen()));
    await tester.pumpAndSettle();

    expect(find.text('Current Streak'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
