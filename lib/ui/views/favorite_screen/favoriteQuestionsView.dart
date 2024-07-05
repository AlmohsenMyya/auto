import 'package:auto/core/utils/extension/context_extensions.dart';
import 'package:auto/ui/views/favorite_screen/widgets/quesion_tile_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'favorite_controller.dart';

class FavoriteQuestionsView extends StatefulWidget {

  @override
  State<FavoriteQuestionsView> createState() => _FavoriteQuestionsViewState();
}

class _FavoriteQuestionsViewState extends State<FavoriteQuestionsView> {

  final controller = Get.put(FavoriteController());
  @override
  Widget build(BuildContext context) {


    return Scaffold(
      backgroundColor: context.exOnPrimaryContainer,
      appBar: AppBar(
        backgroundColor: context.exOnPrimaryContainer,
        title: Text('الأسئلة المفضلة',
            style: context.exTextTheme.titleMedium!.copyWith(color: context.exOnBackground)),
      ),
      body: Obx(
            () {
          if (controller.favoriteQuestions.isEmpty) {
            return Center(
              child: Text('لا توجد أسئلة مفضلة حتى الآن',
                  style: context.exTextTheme.titleMedium!.copyWith(color: context.exOnBackground)),
            );
          }
          return ListView.builder(
            itemCount: controller.favoriteQuestions.length,
            itemBuilder: (context, index) {

              return QuestionTileWidget(
                questionIndex: index,
                showResults: controller.showResults.value,


                // Adjust based on your requirements
              );
            },
          );
        },
      ),
    );
  }
}
