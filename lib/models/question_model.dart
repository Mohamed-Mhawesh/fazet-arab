import 'dart:convert';

Question questionFromJson(String str) => Question.fromJson(json.decode(str));

String questionToJson(Question data) => json.encode(data.toJson());

class Question {
  int id;
  String title;
  List<Answer> answers;

  Question({
    required this.id,
    required this.title,
    required this.answers,
  });

  factory Question.fromJson(Map<String, dynamic> json) => Question(
    id: json["id"],
    title: json["title"],
    answers: List<Answer>.from(json["answers"].map((x) => Answer.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "answers": List<dynamic>.from(answers.map((x) => x.toJson())),
  };
}

class Answer {
  int id;
  int questionId;
  String title;
  int isCorrect;
  DateTime createdAt;
  DateTime updatedAt;

  Answer({
    required this.id,
    required this.questionId,
    required this.title,
    required this.isCorrect,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Answer.fromJson(Map<String, dynamic> json) => Answer(
    id: json["id"],
    questionId: json["question_id"],
    title: json["title"],
    isCorrect: json["is_correct"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "question_id": questionId,
    "title": title,
    "is_correct": isCorrect,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}