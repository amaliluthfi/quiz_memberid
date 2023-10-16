import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_memberid/common/widgets/space.dart';
import 'package:quiz_memberid/core/router/route_constant.dart';
import 'package:quiz_memberid/core/style/app_colors.dart';
import 'package:quiz_memberid/core/topics/data/model/topics._model.dart';
import 'package:quiz_memberid/core/topics/topics_controller.dart';
import 'package:share_plus/share_plus.dart';

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
        body: WillPopScope(
          onWillPop: () async {
            Get.offAndToNamed(RouteConstant.home);
            return false;
          },
          child: Center(
            child: Column(children: [
              Expanded(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    AspectRatio(
                      aspectRatio: 1 / 2,
                      child: PieChart(
                        PieChartData(
                          borderData: FlBorderData(
                            show: false,
                          ),
                          sectionsSpace: 0,
                          centerSpaceRadius: 50,
                          sections: showingSections(
                              questions.length, correctAnswer ?? 0),
                        ),
                      ),
                    ),
                    Text(
                      "$correctAnswer / ${questions.length}",
                      style: const TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    Share.share(
                        "I got $correctAnswer/${questions.length}!. How about you?");
                  },
                  child: const Text("Share your score")),
              const SpaceH16(),
              const Text(
                "Your Report",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w600),
              ),
              const SpaceH8(),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: List.generate(questions.length, (index) {
                    Question item = questions[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.question ?? "",
                            style: const TextStyle(color: Colors.white),
                          ),
                          questions[index].isCorrect
                              ? Row(
                                  children: [
                                    const Icon(
                                      Icons.check,
                                      color: Colors.green,
                                    ),
                                    Text(item.correctAnswer ?? "",
                                        style: const TextStyle(
                                            color: Colors.white))
                                  ],
                                )
                              : Row(
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.close,
                                          color: AppColors.error500,
                                        ),
                                        Text(item.selectedOption,
                                            style: const TextStyle(
                                                color: Colors.white))
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.check,
                                          color: Colors.green,
                                        ),
                                        Text(item.correctAnswer ?? "",
                                            style: const TextStyle(
                                                color: Colors.white))
                                      ],
                                    )
                                  ],
                                )
                        ],
                      ),
                    );
                  }),
                ),
              )
            ]),
          ),
        ),
      );
    });
  }
}

List<PieChartSectionData> showingSections(int totalQuestion, int totalCorrect) {
  return List.generate(2, (i) {
    // final isTouched = i == touchedIndex;
    // final fontSize = isTouched ? 25.0 : 16.0;
    // final radius = isTouched ? 60.0 : 50.0;
    const shadows = [Shadow(color: Colors.black, blurRadius: 2)];
    switch (i) {
      case 0:
        return PieChartSectionData(
          color: Colors.grey,
          value: (totalQuestion - totalCorrect) / totalQuestion,
          title: "",
          titleStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            shadows: shadows,
          ),
        );
      case 1:
        return PieChartSectionData(
          color: Colors.green,
          value: totalCorrect / totalQuestion,
          title: "",
          titleStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            shadows: shadows,
          ),
        );
      default:
        throw Error();
    }
  });
}
