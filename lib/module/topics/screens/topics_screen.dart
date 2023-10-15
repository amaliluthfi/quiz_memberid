import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_memberid/core/router/route_constant.dart';
import 'package:quiz_memberid/core/style/app_colors.dart';
import 'package:quiz_memberid/core/topics/data/model/topics._model.dart';
import 'package:quiz_memberid/core/topics/topics_controller.dart';

class TopicsScreen extends StatelessWidget {
  const TopicsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TopicsController>(builder: (controller) {
      return Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: AppBar(
            elevation: 0,
            backgroundColor: AppColors.backgroundColor,
            centerTitle: true,
            title: const Text("Topics")),
        body: controller.isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                itemCount: controller.topics.length,
                itemBuilder: (context, index) {
                  Topics item = controller.topics[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      onTap: () => Get.toNamed(RouteConstant.quiz,
                          arguments: {"topic": item, "indexQuestion": 0}),
                      textColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4)),
                      tileColor: AppColors.tersierColor,
                      title: Text(item.name ?? ""),
                      trailing: const Icon(
                        Icons.arrow_right,
                        color: Colors.white,
                      ),
                    ),
                  );
                }),
      );
    });
  }
}
