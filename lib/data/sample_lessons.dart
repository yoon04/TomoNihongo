import '../models/lesson.dart';

class _Seed {
  const _Seed(
    this.front,
    this.answer,
    this.note,
    this.example,
    this.translation,
  );
  final String front;
  final String answer;
  final String note;
  final String example;
  final String translation;
}

const _lessons = <String, List<_Seed>>{
  'N5-kanji': [
    _Seed(
      '日',
      'Day · Sun',
      'On: ニチ / ジツ · Kun: ひ',
      '今日は日曜日です。',
      'Today is Sunday.',
    ),
    _Seed(
      '人',
      'Person',
      'On: ジン / ニン · Kun: ひと',
      'あの人は先生です。',
      'That person is a teacher.',
    ),
    _Seed(
      '学',
      'Study · Learning',
      'On: ガク · Kun: まなぶ',
      '日本語を学びます。',
      'I study Japanese.',
    ),
  ],
  'N5-vocabulary': [
    _Seed(
      'こんにちは',
      'Hello',
      'A daytime greeting',
      'こんにちは、お元気ですか。',
      'Hello, how are you?',
    ),
    _Seed('みず', 'Water', 'Kanji: 水', '水を飲んでください。', 'Please drink some water.'),
    _Seed(
      'がっこう',
      'School',
      'Kanji: 学校',
      '毎日、学校へ行きます。',
      'I go to school every day.',
    ),
  ],
  'N5-grammar': [
    _Seed(
      'A は B です',
      'A is B',
      'は marks the topic',
      'わたしは学生です。',
      'I am a student.',
    ),
    _Seed(
      'N を V',
      'Do V to N',
      'を marks a direct object',
      'パンを食べます。',
      'I eat bread.',
    ),
    _Seed(
      'V ませんか',
      'Would you like to V?',
      'A polite invitation',
      'いっしょに行きませんか。',
      'Would you like to go together?',
    ),
  ],
  'N4-kanji': [
    _Seed(
      '会',
      'Meet · Association',
      'On: カイ · Kun: あう',
      '駅で友だちに会います。',
      'I will meet my friend at the station.',
    ),
    _Seed(
      '社',
      'Company · Shrine',
      'On: シャ · Kun: やしろ',
      '父は会社員です。',
      'My father is a company employee.',
    ),
    _Seed(
      '旅',
      'Travel',
      'On: リョ · Kun: たび',
      '京都へ旅行しました。',
      'I travelled to Kyoto.',
    ),
  ],
  'N4-vocabulary': [
    _Seed(
      '予約',
      'Reservation',
      'Reading: よやく',
      'ホテルを予約しました。',
      'I reserved a hotel.',
    ),
    _Seed(
      '必要',
      'Necessary',
      'Reading: ひつよう',
      'パスポートが必要です。',
      'A passport is necessary.',
    ),
    _Seed(
      '経験',
      'Experience',
      'Reading: けいけん',
      '日本で働いた経験があります。',
      'I have experience working in Japan.',
    ),
  ],
  'N4-grammar': [
    _Seed(
      '〜と思います',
      'I think that…',
      'Express an opinion',
      '明日は雨だと思います。',
      'I think it will rain tomorrow.',
    ),
    _Seed(
      'Vながら',
      'While doing V',
      'Two simultaneous actions',
      '音楽を聞きながら勉強します。',
      'I study while listening to music.',
    ),
    _Seed(
      'Vなければなりません',
      'Must do V',
      'Express an obligation',
      '宿題をしなければなりません。',
      'I must do my homework.',
    ),
  ],
  'N3-kanji': [
    _Seed(
      '政',
      'Politics · Government',
      'On: セイ / ショウ',
      '政府が計画を発表しました。',
      'The government announced a plan.',
    ),
    _Seed(
      '経',
      'Pass through · Manage',
      'On: ケイ / キョウ',
      '経済について勉強しています。',
      'I am studying economics.',
    ),
    _Seed(
      '議',
      'Deliberation · Debate',
      'On: ギ',
      '会議は三時に始まります。',
      'The meeting starts at three.',
    ),
  ],
  'N3-vocabulary': [
    _Seed(
      '影響',
      'Influence · Effect',
      'Reading: えいきょう',
      '天気は試合に影響しました。',
      'The weather affected the match.',
    ),
    _Seed(
      '解決',
      'Solution · Resolution',
      'Reading: かいけつ',
      'みんなで問題を解決しました。',
      'We solved the problem together.',
    ),
    _Seed(
      '確認',
      'Confirmation',
      'Reading: かくにん',
      '時間をもう一度確認してください。',
      'Please confirm the time again.',
    ),
  ],
  'N3-grammar': [
    _Seed(
      'Vように',
      'So that V',
      'Express a goal or desired result',
      '忘れないようにメモします。',
      'I take notes so that I do not forget.',
    ),
    _Seed(
      '〜わけではない',
      'It does not mean that…',
      'Give a partial denial',
      '嫌いなわけではありません。',
      'It does not mean I dislike it.',
    ),
    _Seed(
      'Nのたびに',
      'Whenever N occurs',
      'Something happens every time',
      '旅行のたびに写真を撮ります。',
      'I take photos whenever I travel.',
    ),
  ],
  'N2-kanji': [
    _Seed(
      '境',
      'Boundary · Situation',
      'On: キョウ / ケイ · Kun: さかい',
      '環境を守る必要があります。',
      'We need to protect the environment.',
    ),
    _Seed(
      '識',
      'Knowledge · Discernment',
      'On: シキ',
      '安全への意識が高まりました。',
      'Awareness of safety has increased.',
    ),
    _Seed(
      '率',
      'Rate · Lead',
      'On: リツ / ソツ',
      '成功率は八十パーセントです。',
      'The success rate is eighty percent.',
    ),
  ],
  'N2-vocabulary': [
    _Seed(
      '改善',
      'Improvement',
      'Reading: かいぜん',
      'サービスを改善するべきです。',
      'We should improve the service.',
    ),
    _Seed(
      '傾向',
      'Tendency · Trend',
      'Reading: けいこう',
      '物価は上がる傾向にあります。',
      'Prices tend to rise.',
    ),
    _Seed(
      '維持',
      'Maintenance · Preservation',
      'Reading: いじ',
      '健康を維持するために運動します。',
      'I exercise to maintain my health.',
    ),
  ],
  'N2-grammar': [
    _Seed(
      '〜にもかかわらず',
      'Despite…',
      'Contrast an outcome with a fact',
      '雨にもかかわらず出かけました。',
      'I went out despite the rain.',
    ),
    _Seed(
      '〜ざるを得ない',
      'Have no choice but to…',
      'An unavoidable action',
      '計画を変更せざるを得ません。',
      'We have no choice but to change the plan.',
    ),
    _Seed(
      '〜に伴って',
      'Along with…',
      'One change accompanies another',
      '人口の増加に伴って町が広がりました。',
      'The town expanded as the population grew.',
    ),
  ],
  'N1-kanji': [
    _Seed(
      '鑑',
      'Model · Discern',
      'On: カン · compound: 鑑賞',
      '週末に美術を鑑賞しました。',
      'I appreciated art over the weekend.',
    ),
    _Seed(
      '遂',
      'Accomplish',
      'On: スイ · Kun: とげる',
      'ついに目標を成し遂げました。',
      'I finally accomplished my goal.',
    ),
    _Seed(
      '懸',
      'Suspend · Concern',
      'On: ケン / ケ · Kun: かける',
      '安全性への懸念が残ります。',
      'Concerns about safety remain.',
    ),
  ],
  'N1-vocabulary': [
    _Seed(
      '示唆',
      'Suggestion · Implication',
      'Reading: しさ',
      '結果は重要な可能性を示唆しています。',
      'The results suggest an important possibility.',
    ),
    _Seed(
      '踏まえる',
      'Take into account',
      'Reading: ふまえる',
      '経験を踏まえて判断します。',
      'I will decide based on experience.',
    ),
    _Seed(
      '余儀ない',
      'Unavoidable · Compelled',
      'Reading: よぎない',
      '計画は変更を余儀なくされました。',
      'The plan was forced to change.',
    ),
  ],
  'N1-grammar': [
    _Seed(
      '〜を皮切りに',
      'Starting with…',
      'The first of a continuing series',
      '東京を皮切りに全国で公演します。',
      'Starting in Tokyo, performances will be held nationwide.',
    ),
    _Seed(
      '〜までもなく',
      'It goes without saying…',
      'Something is obvious',
      '説明するまでもなく明らかです。',
      'It is obvious without explanation.',
    ),
    _Seed(
      '〜いかんによって',
      'Depending on…',
      'An outcome depends on a condition',
      '結果いかんによって方針を変えます。',
      'We will change policy depending on the result.',
    ),
  ],
};

List<LessonUnitData> sampleUnits(String level, LessonCategory category) {
  final seeds =
      _lessons['$level-${category.name}'] ?? _lessons['N5-${category.name}']!;
  return List.generate(seeds.length, (index) {
    final seed = seeds[index];
    return LessonUnitData(
      title: 'Unit ${index + 1}',
      summary: '$level · ${seed.answer}',
      cards: [
        LessonCardData(
          front: seed.front,
          title: seed.answer,
          subtitle: seed.note,
          details: 'Study the key form, then read the example aloud.',
          example: seed.example,
          translation: seed.translation,
        ),
        LessonCardData(
          front: 'Translate:\n${seed.example}',
          title: seed.translation,
          subtitle: 'Sentence exercise',
          details: 'Focus: ${seed.front} — ${seed.answer}',
          example: seed.example,
          translation: seed.translation,
        ),
      ],
    );
  });
}
