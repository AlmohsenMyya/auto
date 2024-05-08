import 'package:auto/core/services/base_controller.dart';
import 'package:flutter/material.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

class LoginController extends BaseController {
  TextEditingController codeController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey code_1_showCase = GlobalKey();

  void initStateController(BuildContext context) {
    _createTutorial(context);
  }

  Future<void> _createTutorial(BuildContext context) async {
    final targets = [
      TargetFocus(
        color: Colors.blue,
        identify: 'floatingButton',
        keyTarget: code_1_showCase,
        alignSkip: Alignment.topCenter,
        contents: [
          TargetContent(
            align: ContentAlign.top,
            builder: (context, controller) => Padding(
              padding: const EdgeInsets.only(bottom: 200.0),
              child: Text(
                'Use this button to add new elements to th0000e list',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
      // TargetFocus(
      //   identify: 'editButton',
      //   keyTarget: _editButtonKey,
      //   alignSkip: Alignment.bottomCenter,
      //   contents: [
      //     TargetContent(
      //       align: ContentAlign.bottom,
      //       builder: (context, controller) => Padding(
      //         padding: const EdgeInsets.only(top: 100.0),
      //         child: Text(
      //           'You can edit----- the entries by pressing on the edit button',
      //           style: Theme.of(context)
      //               .textTheme
      //               .titleLarge
      //               ?.copyWith(color: Colors.white),
      //         ),
      //       ),
      //     ),
      //   ],
      // ),
      // TargetFocus(
      //   identify: 'settingsButton',
      //   keyTarget: _settingsButtonKey,
      //   alignSkip: Alignment.bottomCenter,
      //   contents: [
      //     TargetContent(
      //       align: ContentAlign.bottom,
      //       builder: (context, controller) => Text(
      //         'Configure the app in the settings screen',
      //         style: Theme.of(context)
      //             .textTheme
      //             .titleLarge
      //             ?.copyWith(color: Colors.white),
      //       ),
      //     ),
      //   ],
      // ),
    ];

    final tutorial = TutorialCoachMark(
      targets: targets,
    );

    Future.delayed(const Duration(milliseconds: 500), () {
      tutorial.show(context: context);
    });
  }
}
