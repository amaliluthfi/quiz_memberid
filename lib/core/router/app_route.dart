import 'package:get/route_manager.dart';
import 'package:quiz_memberid/core/router/route_constant.dart';
import 'package:quiz_memberid/module/home/screens/home_screen.dart';
import 'package:quiz_memberid/module/quiz/screens/quiz_screens.dart';
import 'package:quiz_memberid/module/result/resullt_screen.dart';
import 'package:quiz_memberid/module/topics/screens/topics_screen.dart';

class AppRoute {
  static final all = [
    GetPage(name: RouteConstant.home, page: () => const MyHomePage()),
    GetPage(name: RouteConstant.topics, page: () => const TopicsScreen()),
    GetPage(name: RouteConstant.quiz, page: () => const QuizScreen()),
    GetPage(name: RouteConstant.result, page: () => const ResultScreen())
  ];
}
