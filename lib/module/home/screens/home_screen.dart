import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_memberid/common/widgets/custom_button.dart';
import 'package:quiz_memberid/common/widgets/space.dart';
import 'package:quiz_memberid/core/assets/app_assets.dart';
import 'package:quiz_memberid/core/router/route_constant.dart';
import 'package:quiz_memberid/core/style/app_colors.dart';
import 'package:quiz_memberid/core/topics/topics_controller.dart';
import 'package:share_plus/share_plus.dart';
// import 'package:share_plus/share_plus.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<TopicsController>(
      init: TopicsController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: AppColors.backgroundColor,
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  AppAssets.lightBulb,
                  width: 60,
                ),
                const SpaceH8(),
                const SpaceH16(),
                const Text(
                  'Flutter Quiz App',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w500),
                ),
                const SpaceH8(),
                const Text(
                  'Learn • Take Quiz • Repeat',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 42),
                CustomButton(
                    func: () {
                      Get.toNamed(RouteConstant.quiz, arguments: {
                        "topic": controller
                            .topics[Random().nextInt(controller.topics.length)],
                        "indexQuestion": 0
                      });
                    },
                    text: "Play"),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      foregroundColor: AppColors.secondaryColor,
                      side: BorderSide(color: AppColors.primaryColor, width: 1),
                      elevation: 0,
                      fixedSize: const Size(280, 32),
                      backgroundColor: AppColors.backgroundColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20))),
                  onPressed: () {
                    Get.toNamed(RouteConstant.topics);
                  },
                  child: const Text(
                    "Topics",
                  ),
                ),
                const SpaceH16(),
                const SpaceH16(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton.icon(
                        onPressed: () {
                          Share.share(
                              "Try trivia quiz, there are many interestinf topics!");
                        },
                        icon: const Icon(Icons.share),
                        label: const Text(
                          "Share",
                          style: TextStyle(color: Colors.white),
                        )),
                    const SizedBox(
                      width: 40,
                    ),
                    TextButton.icon(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.star,
                          color: Colors.yellow,
                        ),
                        label: const Text(
                          "Share",
                          style: TextStyle(color: Colors.white),
                        )),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
