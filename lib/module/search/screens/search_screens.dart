import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_memberid/core/router/route_constant.dart';
import 'package:quiz_memberid/core/style/app_colors.dart';
import 'package:quiz_memberid/core/topics/data/model/topics._model.dart';
import 'package:quiz_memberid/core/topics/topics_controller.dart';

class SearchScreens extends StatelessWidget {
  const SearchScreens({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TopicsController>(builder: (controller) {
      return Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: AppColors.backgroundColor,
          centerTitle: true,
          title: const Text("Search Topics"),
          actions: [
            DropdownButton(
              padding: const EdgeInsets.all(8),
              dropdownColor: AppColors.secondaryColor,
              style: const TextStyle(color: Colors.white),
              value: controller.filterDifficulty,
              underline: const SizedBox(),
              onChanged: (val) {
                controller.filterDifficulty = val!;
                controller.update();
                controller.searchTopic();
              },
              items: controller.difficultyList
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              icon: Icon(Icons.filter_alt, color: AppColors.primaryColor),
            )
          ],
          bottom: PreferredSize(
              preferredSize: const Size(double.maxFinite, 40),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: TextFormField(
                  controller: controller.searcTxt,
                  onEditingComplete: () => controller.searchTopic(),
                  enableSuggestions: false,
                  decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 0, horizontal: 8),
                      border: OutlineInputBorder(
                        gapPadding: 0,
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      suffixIcon: Icon(
                        Icons.search_rounded,
                        color: AppColors.primaryColor,
                      ),
                      filled: true,
                      fillColor: Colors.white),
                ),
              )),
        ),
        body: controller.isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                itemCount: controller.resultTopics.length,
                itemBuilder: (context, index) {
                  Topics item = controller.resultTopics[index];
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
