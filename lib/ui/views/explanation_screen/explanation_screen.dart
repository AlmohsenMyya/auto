import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:flutter/services.dart';

class ExplanationPage extends StatefulWidget {
  @override
  _ExplanationPageState createState() => _ExplanationPageState();
}

class _ExplanationPageState extends State<ExplanationPage> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();

    // فرض الوضع الطولي عند دخول الصفحة
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    // Replace with your own YouTube video link
    const videoUrl = "https://www.youtube.com/watch?v=WPFFa3f0V5w&t=134s";
    _controller = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(videoUrl) ?? '',
      flags: YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      ),
    );
  }

  @override
  void dispose() {
    // إعادة ضبط الوضعيات المسموحة عند مغادرة الصفحة
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);

    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('شرح كيفية استخدام التطبيق'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("يمكنك متابعة الفديو لاستعراض شرح التطبيق وفهم آلية عمله"),
              SizedBox(height: 80),
              YoutubePlayer(
                controller: _controller,
                showVideoProgressIndicator: true,
                progressIndicatorColor: Colors.red,

                onReady: () {
                  // منع التدوير التلقائي عندما يكون الفيديو جاهزًا
                  _controller.addListener(() {
                    if (_controller.value.isFullScreen) {
                      SystemChrome.setPreferredOrientations([
                        DeviceOrientation.landscapeLeft,
                        DeviceOrientation.landscapeRight,
                      ]);
                    } else {
                      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
                    }
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
