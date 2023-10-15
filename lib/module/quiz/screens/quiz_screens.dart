import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_memberid/common/widgets/custom_button.dart';
import 'package:quiz_memberid/common/widgets/space.dart';
import 'package:quiz_memberid/core/router/route_constant.dart';
import 'package:quiz_memberid/core/style/app_colors.dart';
import 'package:quiz_memberid/core/topics/data/model/topics._model.dart';
import 'package:quiz_memberid/core/topics/topics_controller.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  List<Question>? questions;
  int indexQuestion = 0;

  Stream<int> generateNumbers = (() async* {
    for (int i = 0; i <= 30; i++) {
      await Future<void>.delayed(const Duration(seconds: 1));

      yield i;
    }
  })();

  @override
  void initState() {
    questions = Get.arguments["topic"].questions;
    indexQuestion = Get.arguments["indexQuestion"];

    Timer(const Duration(seconds: 30), () {
      if (Get.rawRoute?.settings.name == "/quiz") {
        if (indexQuestion < 4) {
          setState(() {
            Get.offAndToNamed(
              RouteConstant.quiz,
              arguments: {
                "topic": Get.arguments["topic"],
                "indexQuestion": indexQuestion
              },
            );
          });
        } else {
          Get.toNamed(RouteConstant.result, arguments: Get.arguments["topic"]);
        }
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TopicsController>(builder: (controller) {
      return Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: AppBar(
            actions: [
              TextButton(
                  onPressed: () => Get.offAndToNamed(RouteConstant.home),
                  child: const Text(
                    "Exit",
                    style: TextStyle(color: Colors.white),
                  ))
            ],
            elevation: 0,
            backgroundColor: AppColors.backgroundColor,
            centerTitle: true,
            title: const Text("Quiz Page")),
        body: Column(
          children: [
            StreamBuilder(
                stream: generateNumbers,
                builder: (context, snapshot) {
                  return Stack(
                    children: [
                      Container(
                        height: 5,
                        width: double.maxFinite,
                        color: const Color.fromARGB(255, 31, 30, 30),
                      ),
                      snapshot.hasData
                          ? AnimatedContainer(
                              duration: const Duration(milliseconds: 1000),
                              height: 5,
                              width: (snapshot.data! / 30).toDouble() *
                                  MediaQuery.sizeOf(context).width,
                              color: Colors.yellow,
                            )
                          : const SizedBox(),
                    ],
                  );
                }),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white,
                  ),
                  child: Text(
                    questions?[indexQuestion].question ?? "",
                    style: const TextStyle(
                      fontSize: 24,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SpaceH16(),
                Column(
                  children: List.generate(
                      questions?[indexQuestion].options?.length ?? 0,
                      (index) => CustomButton(
                          width: double.maxFinite,
                          color: Colors.white,
                          foregroundColor: Colors.black,
                          func: () {
                            controller.selectOption(
                                topic: Get.arguments["topic"],
                                answer:
                                    questions?[indexQuestion].options?[index] ??
                                        "",
                                indexQuestion: indexQuestion);

                            Timer(const Duration(milliseconds: 1000), () {
                              if (indexQuestion < 4) {
                                setState(() {
                                  indexQuestion++;
                                  Get.offAndToNamed(RouteConstant.quiz,
                                      arguments: {
                                        "topic": Get.arguments["topic"],
                                        "indexQuestion": indexQuestion++
                                      });
                                });
                              } else {
                                Get.offAndToNamed(RouteConstant.result,
                                    arguments: Get.arguments["topic"]);
                              }
                            });
                          },
                          text:
                              questions?[indexQuestion].options?[index] ?? "")),
                ),
              ]),
            ),
          ],
        ),
      );
    });
  }
}
