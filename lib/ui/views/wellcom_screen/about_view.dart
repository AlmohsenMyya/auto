import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Image.asset(
          "assets/images/icon_app.png",
          height: 50,
        ),
        actions: [
          Image.asset(
            "assets/images/icon_app.png",
            height: 50,
          ),
        ],
        title: Center(child: Text('حول التطبيق')),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/icon_app.png",
                height: 200,
              ),

              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  '''يُعتبر التطبيق الحالي وجهتك الموثقة والموثوقة بشكل لا يُضاهى لاستعراض وتصفح أهم الأسئلة التي تواجه طلاب البكالوريا في سوريا. بفضل مجموعته الفريدة والمتنوعة من الأسئلة، يقدم التطبيق أدوات ضرورية وأساسية للطلاب لتحقيق النجاح في امتحاناتهم النهائية.

هنا، في هذا المساحة الرقمية، يمكن للطلاب الاستفادة من موارد التعلم المتاحة بسهولة وفعالية، مما يساعدهم في فهم المواد وتحضيرها بشكل شامل ومتقدم. سواء كنت تبحث عن أسئلة ممارسة أو مراجعات شاملة، فإن التطبيق يلبي جميع احتياجاتك التعليمية بكفاءة واحترافية.

لا تضيع وقتك في البحث عن المصادر الموثوقة، بل اجعل التطبيق وجهتك الأولى والوحيدة لتحضير امتحانات البكالوريا بثقة وسهولة.''',
                  style: TextStyle(fontSize: 18),
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
