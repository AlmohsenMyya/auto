import 'package:auto2/core/utils/extension/widget_extension.dart';
import 'package:auto2/ui/shared/colors.dart';
import 'package:auto2/ui/shared/main_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SubjectCardDetails extends StatelessWidget {
  Map<String, dynamic> name;

  SubjectCardDetails({required this.name, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
          color: AppColors.blueB4.withOpacity(0.5),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
              color: Theme.of(context).colorScheme.onBackground, width: 2)),
      width: 150,
      height: 150,
      child: Align(
          alignment: Alignment.center,
          child: Padding(
            padding: EdgeInsets.all(8),
            child: Text(
                style: TextStyle(
                  fontSize: 30,
                    color: Theme.of(context).colorScheme.onBackground),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                name.keys.first),
          )),
    ).onTap(
      () => Get.to(name.values.first),
    );
  }
}
