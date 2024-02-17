
import 'package:auto/ui/shared/colors.dart';
import 'package:auto/ui/shared/main_app_bar.dart';
import 'package:flutter/material.dart';
class SubjectCardDetails extends StatelessWidget {


  String name;
  SubjectCardDetails({
    required this.name,
    super.key});

  @override
  Widget build(BuildContext context) {


    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: AppColors.blueB4.withOpacity(0.5),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
              color: Theme.of(context).colorScheme.primary, width: 2))
      ,
      width: 175,
      height: 100,
      child: Align(alignment: Alignment.center,child: Padding(padding: EdgeInsets.all(8),child: Text(
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          name),)),

    );
  }
}

