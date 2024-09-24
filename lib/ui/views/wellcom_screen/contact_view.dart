import 'package:auto2/core/utils/extension/context_extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactScreen extends StatelessWidget {
  // دالة لفتح الروابط
  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

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
        title: Center(child: Text('تواصل معنا')),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20),
              Image.asset(
                "assets/images/logo.png",
                height: 200,
              ),

              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Center(child: Text("بالنقر على ايقونات التواصل يمكنك مباشرة الانتقال لصفحاتنا وقنواتنا: "),),
              ),
              ContactItem(
                iconPath: 'assets/images/facebook.png',
                text: 'تطبيق Auto _ أتمتة بكالوريا',
                url: 'https://www.facebook.com/profile.php?id=61559135669873&mibextid=ZbWKwL',
              ),
              ContactItem(
                iconPath: 'assets/images/whats.png',
                text: 'رقم الواتساب : 0939480039',
                url: 'https://wa.me/0939480039',
              ),
              ContactItem(
                iconPath: 'assets/images/youtube.png',
                text: 'تطبيق Auto _ أتمتة بكالوريا',
                url: 'https://youtube.com/@auto-cm5jd?si=XwR283k0VEVR_tG-',
              ),
              ContactItem(
                iconPath: 'assets/images/tel.png',
                text: 'تطبيق Auto أتمتة بكلوريا',
                url: 'https://t.me/autobacsyria',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ContactItem extends StatelessWidget {
  final String iconPath;
  final String text;
  final String url;

  const ContactItem({
    required this.iconPath,
    required this.text,
    required this.url,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(

      onTap: () {
        _launchURL(url);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
        child: Row(
          children: [
            Image.asset(

              iconPath,
              width: 40,
              height: 40,
            ),
            SizedBox(width: 20),
            Expanded(
              child: Text(
                text,
                style: context.exTextTheme.titleMedium!.copyWith(color: context.exOnBackground),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // دالة لفتح الروابط
  void _launchURL(String url) async {
    try {
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        _showErrorDialog(url);
      }
    } catch (e) {
      print('Error: $e');
      _showErrorDialog(url);
    }
  }

  void _showErrorDialog(String url) {

    print('Could not launch $url');
  }
}
