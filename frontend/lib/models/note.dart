import 'dart:math';

class Note {
  final String title;
  final String content;
  final DateTime createdAt;

  Note({
    required this.title,
    required this.content,
    required this.createdAt,
  });

  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(
      title: json['title'],
      content: json['content'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  factory Note.random() {
    final Random random = Random();
    final int contentLength = random.nextInt(100) + 50;
    return Note(
      title: "Note ${random.nextInt(1000)}",
      content: String.fromCharCodes(
        List.generate(
          contentLength,
          (index) => random.nextInt(26) + 97,
        ),
      ),
      createdAt: DateTime.now().subtract(
        Duration(
          days: random.nextInt(365),
          hours: random.nextInt(24),
          minutes: random.nextInt(60),
        ),
      ),
    );
  }
}