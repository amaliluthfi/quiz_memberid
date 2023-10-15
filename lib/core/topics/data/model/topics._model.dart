// To parse this JSON data, do
//
//     final topics = topicsFromJson(jsonString);

import 'dart:convert';

List<Topics> topicsFromJson(String str) =>
    List<Topics>.from(json.decode(str).map((x) => Topics.fromJson(x)));

String topicsToJson(List<Topics> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Topics {
  String? name;
  List<Question>? questions;

  Topics({
    required this.name,
    required this.questions,
  });

  factory Topics.fromJson(Map<String, dynamic> json) => Topics(
        name: json["name"],
        questions: List<Question>.from(
            json["questions"].map((x) => Question.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "questions": questions != null
            ? List<dynamic>.from(questions!.map((x) => x.toJson()))
            : null,
      };
}

class Question {
  String? question;
  List<String>? options;
  String? correctAnswer;
  bool isCorrect;
  String selectedOption;

  Question(
      {required this.question,
      required this.options,
      required this.correctAnswer,
      this.isCorrect = false,
      this.selectedOption = "not answered"});

  factory Question.fromJson(Map<String, dynamic> json) => Question(
        question: json["question"],
        options: List<String>.from(json["options"].map((x) => x)),
        correctAnswer: json["correctAnswer"],
      );

  Map<String, dynamic> toJson() => {
        "question": question,
        "options":
            options != null ? List<dynamic>.from(options!.map((x) => x)) : null,
        "correctAnswer": correctAnswer,
      };
}
