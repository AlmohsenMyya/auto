import 'package:auto2/core/utils/extension/context_extensions.dart';
import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.exOnPrimaryContainer,
      appBar: AppBar(
        backgroundColor: context.exOnPrimaryContainer,
        leading: Image.asset(
          "assets/images/logo.png",
          height: 100,
        ),
        actions: [
          Image.asset(
            "assets/images/logo.png",
            height: 100,
          ),
        ],
        title: Center(
            child: Text(
          'حول التطبيق',
          style: context.exTextTheme.titleMedium!
              .copyWith(color: context.exOnBackground),
        )),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/logo.png",
                height: 200,
              ),

              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  '''يعتبر تطبيق Auto وجهتك الأساسية للتدرب على أسئلة البكالوريا بأسرع و أسهل طريقة ، حيث تستطيع حل آلاف الأسئلة الموثوقة التي وضعها نخبة من الأساتذة على مستوى سوريا و جميع أسئلة الدورات السابقة لاختيار الإجابة السابقة و البنوك الوزارية....

لا تردد بالاشترك فالتطبيق يوفر الوقت و يتيح لك معرفة عدد الإجابات الصحيحة و الخاطئة مباشرة  و عندما تريد الاحتفاظ بالسؤال وضعه ضمن الأسئلة المفضلة...

لا تضيع وقتك في البحث عن المصادر الموثوقة، بل اجعل التطبيق وجهتك الأولى والوحيدة لتحضير امتحانات البكالوريا بثقة وسهولة.''',
                  style: context.exTextTheme.titleMedium!
                      .copyWith(color: context.exOnBackground),
                ),
              ),

              SizedBox(height: 20),
              // TextButton(
              //   onPressed: () {
              //     _showDialog(context);
              //   },
              //   child: Text(
              //     'Developed by Optimized Engineer Mia',
              //     style: TextStyle(fontSize: 10),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  void _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Optimized Engineer Mia'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                radius: 60,
                backgroundImage: AssetImage('assets/images/mia_photo.jpg'),
              ),
              SizedBox(height: 10),
              Text(
                'Software Engineer passionate about creating innovative solutions.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    icon: Image.asset('assets/icons/facebook_icon.png'),
                    onPressed: () {
                      // Navigate to Facebook profile
                    },
                  ),
                  IconButton(
                    icon: Image.asset('assets/icons/linkedin_icon.png'),
                    onPressed: () {
                      // Navigate to LinkedIn profile
                    },
                  ),
                  IconButton(
                    icon: Image.asset('assets/icons/whatsapp_icon.png'),
                    onPressed: () {
                      // Navigate to WhatsApp profile
                    },
                  ),
                ],
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }
}
