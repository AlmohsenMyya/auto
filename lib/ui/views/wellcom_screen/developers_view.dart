import 'package:auto/core/utils/extension/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DevelopersPage extends StatelessWidget {
  final List<Developer> developers = [
    Developer(
      name: 'Abdulrahman Al-Helou',
      image: 'assets/images/abd.jpeg',
      description:
          'Software Engineer | Full-stack Web developer | back end Laravel developer | helping clients building scalable and reliable solutions',
      facebook:
          'https://www.facebook.com/abdulrahmanalholo.alholo?mibextid=ZbWKwL',
      linkedin:
          'https://www.linkedin.com/in/abdulrahman-alhelou?utm_source=share&utm_campaign=share_via&utm_content=profile&utm_medium=android_app',
      whatsapp: '+963935664932',
    ),
    Developer(
      name: 'Almohsen Myya',
      image: 'assets/images/almohsen.jpg',
      description:
          ' Software Engineer | Mobile Application Developer | Laravel Developer | Passionate about Project Management and Team Leadership | Transforming Ideas into Reality',
      facebook:
          'https://www.facebook.com/profile.php?id=61551818735379&mibextid=ZbWKwL',
      linkedin:
          'https://www.linkedin.com/in/almohsen-myya-79230022b?utm_source=share&utm_campaign=share_via&utm_content=profile&utm_medium=android_app',
      whatsapp: '+963996367749',
    ),
    Developer(
      name: 'Almhyar Zahra',
      image: 'assets/images/almheyar.jpeg',
      description: 'Flutter Developer | Mobile Application',
      facebook: 'https://www.facebook.com/almhyrzahra.zahra?mibextid=ZbWKwL',
      linkedin:
          'https://www.linkedin.com/in/almhyar-zahra-998010268?utm_source=share&utm_campaign=share_via&utm_content=profile&utm_medium=android_app',
      whatsapp: '+963962245305',
    ),
    Developer(
      name: 'Nisreen Mahmoud',
      image: 'assets/images/nsreen.jpeg',
      description: 'Graphic Designer',
      facebook: 'https://www.facebook.com/nisreen.mahmoud.3597?mibextid=ZbWKwL',
      linkedin:
          'https://www.linkedin.com/in/nisreen-mahmoud-47306727b?utm_source=share&utm_campaign=share_via&utm_content=profile&utm_medium=android_app',
      whatsapp: '+963995537356',
    ),
    Developer(
      name: 'Nour Alfarwie',
      image: 'assets/images/nour.jpeg',
      description: 'Software Engineer | Flutter Developer ',
      facebook:
          'https://www.facebook.com/profile.php?id=100087565640917&mibextid=ZbWKwL',
      linkedin:
          ' https://www.linkedin.com/in/noura-alfarwie-528b632b2?utm_source=share&utm_campaign=share_via&utm_content=profile&utm_medium=android_app ',
      whatsapp: '+963936134933',
    ),
    Developer(
      name: ' Mohammed Alsaleh',
      image: 'assets/images/mhd_saleh.jpeg',
      description: 'Fullstack Developer',
      facebook:
          'https://www.facebook.com/profile.php?id=100021914075162&mibextid=ZbWKwL',
      linkedin:
          'https://www.linkedin.com/in/mohamad-alsaleh-490035225?utm_source=share&utm_campaign=share_via&utm_content=profile&utm_medium=android_app',
      whatsapp: '+963937954785',
    )
    // Developer(
    //   name: 'Optimized Engineer ',
    //   image: 'assets/images/mia_photo.jpg',
    //   description:
    //       'Software Engineer passionate about creating innovative solutions.',
    //   facebook: 'https://www.facebook.com/mia',
    //   linkedin: 'https://www.linkedin.com/in/mia',
    //   whatsapp: '123456789',
    // ),

    // Add more developers here if needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.exOnPrimaryContainer,
      body: SafeArea(
        child: ListView(
          children: [
            SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                  "من قام بتطوير هذا التطبيق هم مجموعة من المهندسين السوريين , سعيا منهم لتقديم تجربة مستخدم مميزة ومفيدة من خلال هذا التطبيق "
                  "مع التمنيات بالتوفيق الدائم لجميع الطلاب ",
                  style: context.exTextTheme.titleMedium!
                      .copyWith(color: context.exOnBackground)),
            ),
            SizedBox(
              height: 20,
            ),
            DeveloperListItem(developer: developers[0]),
            SizedBox(
              height: 20,
            ),
            DeveloperListItem(developer: developers[1]),
            SizedBox(
              height: 20,
            ),
            DeveloperListItem(developer: developers[2]),
            SizedBox(
              height: 20,
            ),
            DeveloperListItem(developer: developers[3]),
            SizedBox(
              height: 20,
            ),
            DeveloperListItem(developer: developers[4]),
            SizedBox(
              height: 20,
            ),
            DeveloperListItem(developer: developers[5]),
            // DeveloperListItem(developer: developers[2]),
            // Image.asset(
            //   "assets/images/code_icon.png",
            //   height: 200,
            // ),
            Image.asset(
              "assets/images/logo.png",
              height: 300,
            ),
          ],
        ),
      ),
    );
  }
}

class Developer {
  final String name;
  final String image;
  final String description;
  final String facebook;
  final String linkedin;
  final String whatsapp;

  Developer({
    required this.name,
    required this.image,
    required this.description,
    required this.facebook,
    required this.linkedin,
    required this.whatsapp,
  });
}

class DeveloperListItem extends StatelessWidget {
  final Developer developer;

  DeveloperListItem({required this.developer});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      trailing: CircleAvatar(
        backgroundImage: AssetImage(developer.image),
      ),
      title: Row(
        children: [
          Spacer(),
          Text(developer.name),
        ],
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DeveloperDetails(developer: developer),
          ),
        );
      },
    );
  }
}

class DeveloperDetails extends StatelessWidget {
  final Developer developer;

  DeveloperDetails({required this.developer});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Spacer(),
            CircleAvatar(
              radius: 80,
              backgroundImage: AssetImage(developer.image),
            ),
            SizedBox(height: 20),
            Text(
              developer.name,
              style: TextStyle(color: Colors.black, fontSize: 20),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Image.asset("assets/images/facebook.gif"),
                  onPressed: () {
                    openFacebook(developer.facebook);
                    // Open Facebook profile
                  },
                ),
                IconButton(
                  icon: Container(
                      color: Colors.red,
                      child: Image.asset(
                        "assets/images/linkedin.gif",
                      )),
                  onPressed: () {
                    openLinkedIn(developer.linkedin);
                    // Open LinkedIn profile
                  },
                ),
                IconButton(
                  icon: Image.asset("assets/images/whatsapp.gif"),
                  onPressed: () {
                    openWhatsApp(developer.whatsapp);
                    // Open WhatsApp profile
                  },
                ),
              ],
            ),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                developer.description,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16 , color: context.primaryColor),
              ),
            ),

            if(developer.name =="Almohsen Myya")...[
              Image.asset(
                "assets/images/d_logo.png",
                height: 200,
              ),],
            Spacer(),
          ],
        ),
      ),
    );
  }

// Function to open WhatsApp
  void openWhatsApp(String phoneNumber) async {
    String whatsappUrl = "whatsapp://send?phone=$phoneNumber";
    await canLaunch(whatsappUrl)
        ? launch(whatsappUrl)
        : print('Error launching WhatsApp');
  }

// Function to open Facebook
  void openFacebook(String profileUrl) async {
    String facebookUrl = profileUrl;
    await canLaunch(facebookUrl)
        ? launch(facebookUrl)
        : print('Error launching Facebook');
  }

// Function to open LinkedIn
  void openLinkedIn(String profileUrl) async {
    String linkedInUrl = profileUrl;
    await canLaunch(linkedInUrl)
        ? launch(linkedInUrl)
        : print('Error launching LinkedIn');
  }
}
