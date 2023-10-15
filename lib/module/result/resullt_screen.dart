import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_memberid/core/style/app_colors.dart';
import 'package:quiz_memberid/core/topics/data/model/topics._model.dart';
import 'package:quiz_memberid/core/topics/topics_controller.dart';

class ResultScreen extends StatefulWidget {
  const ResultScreen({super.key});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  final List<Question> questions = Get.arguments.questions;
  int? correctAnswer;

  @override
  void initState() {
    correctAnswer =
        questions.where((element) => element.isCorrect).toList().length;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TopicsController>(builder: (controller) {
      return Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: AppBar(
            elevation: 0,
            backgroundColor: AppColors.backgroundColor,
            centerTitle: true,
            title: const Text("Your Score")),
        body: Center(
          child: Column(children: [
            Text(
              "$correctAnswer / ${questions.length}",
              style: TextStyle(color: Colors.white, fontSize: 18),
            )
          ]),
        ),
      );
    });
  }
}
