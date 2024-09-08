import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import '../../../core/data/models/local_json/all_models.dart';
import '../../../core/data/repositories/read_all_models.dart';

class SliderWidget extends StatefulWidget {
  const SliderWidget({Key? key}) : super(key: key);

  @override
  _SliderWidgetState createState() => _SliderWidgetState();
}

class _SliderWidgetState extends State<SliderWidget> {
  List<SliderModel> sliders = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    loadSliderData();
  }

  // Load slider data from JSON
  Future<void> loadSliderData() async {
    setState(() {
      isLoading = true;
    });
    try {
      final jsonData = await JsonReader.loadJsonData();
      setState(() {
        isLoading = false;
        sliders = JsonReader.extractSliders(jsonData);
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print("Error loading sliders: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Center(
      child: CircularProgressIndicator(),
    )
        : sliders.isEmpty
        ? SizedBox()
        : CarouselSlider(
      options: CarouselOptions(
        height: MediaQuery.of(context).size.width * 0.3, // Make it a square
        enlargeCenterPage: false, // No need to enlarge center
        autoPlay: true,
        autoPlayInterval: Duration(seconds: 3),
        autoPlayAnimationDuration: Duration(milliseconds: 800),
        viewportFraction: 0.4, // Show two images per screen
        aspectRatio: 1.0, // Make it a square aspect ratio
        initialPage: 0,
      ),
      items: sliders.map((slider) {
        return Builder(
          builder: (BuildContext context) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => FullScreenImageViewer(
                      sliders: sliders,
                      initialIndex: sliders.indexOf(slider),
                    ),
                  ),
                );
              },
              child: Container(
                width: MediaQuery.of(context).size.width * 0.5,
                margin: EdgeInsets.symmetric(horizontal: 5.0),
                decoration: BoxDecoration(
                  color: Colors.black12,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network(
                    slider.imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            );
          },
        );
      }).toList(),
    );
  }
}

class FullScreenImageViewer extends StatelessWidget {
  final List<SliderModel> sliders;
  final int initialIndex;

  const FullScreenImageViewer({
    Key? key,
    required this.sliders,
    required this.initialIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PhotoViewGallery.builder(
        itemCount: sliders.length,
        builder: (context, index) {
          final slider = sliders[index];
          return PhotoViewGalleryPageOptions(
            imageProvider: NetworkImage(slider.imageUrl),
            minScale: PhotoViewComputedScale.contained,
            maxScale: PhotoViewComputedScale.covered * 2.0,
            heroAttributes: PhotoViewHeroAttributes(tag: slider.imageUrl),
          );
        },
        scrollPhysics: BouncingScrollPhysics(),
        backgroundDecoration: BoxDecoration(color: Colors.black),
        pageController: PageController(initialPage: initialIndex),
      ),
    );
  }
}
