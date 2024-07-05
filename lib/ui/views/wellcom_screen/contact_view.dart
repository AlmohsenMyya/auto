import 'package:auto/core/utils/extension/context_extensions.dart';
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
              SizedBox(height: 20),
              ContactItem(
                iconPath: 'assets/images/facebook.png',
                text: 'بكلوريا سوريا ',
                url: 'https://www.facebook.com/profile.php?id=61554686086475',
              ),
              ContactItem(
                iconPath: 'assets/images/whats.png',
                text: '0939480033',
                url: 'https://wa.me/0939480033',
              ),
              ContactItem(
                iconPath: 'assets/images/youtube.png',
                text: 'autosyr@gmail.com',
                url: 'mailto:autosyr@gmail.com',
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
