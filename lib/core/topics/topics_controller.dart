import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/route_manager.dart';
import 'package:quiz_memberid/core/style/app_colors.dart';
import 'package:quiz_memberid/core/topics/data/model/topics._model.dart';
import 'package:quiz_memberid/core/topics/data/network/topics_network.dart';

class TopicsController extends GetxController {
  List<Topics> topics = [];
  bool isLoading = false;
  final TopicsNetwork _network = TopicsNetwork();

  @override
  void onInit() {
    getTopics();
    super.onInit();
  }

  getTopics() async {
    isLoading = true;
    update();
    try {
      var res = await _network.getTopicsNetwork();
      topics.addAll(res);
    } catch (e) {
      rethrow;
    }
    isLoading = false;
    update();
  }

  selectOption(
      {required Topics topic,
      required int indexQuestion,
      required String answer}) {
    Question? question;

    question = topic.questions?[indexQuestion];

    if (question != null) {
      question.selectedOption = answer;
      question.isCorrect = answer == question.correctAnswer;
      if (question.isCorrect) {
        Get.showSnackbar(GetSnackBar(
          duration: const Duration(milliseconds: 1500),
          backgroundColor: AppColors.primaryColor,
          messageText: const Text(""),
          titleText: const Text("You are correct!",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w700)),
        ));
      } else {
        Get.showSnackbar(GetSnackBar(
          duration: const Duration(milliseconds: 1500),
          backgroundColor: AppColors.error500,
          titleText: const Text("Sorry, you are wrong",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w700)),
          messageText: const Text(""),
        ));
      }
    }
  }

  Stream<int> secondsPeriodic = (() async* {
    for (int i = 0; i <= 30; i++) {
      await Future<void>.delayed(const Duration(seconds: 1));

      yield i;
    }
  })();
}
