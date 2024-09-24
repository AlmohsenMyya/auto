import 'dart:io';
import 'package:auto2/core/translation/app_translation.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:photo_view/photo_view.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:path/path.dart' as path;
import 'package:crypto/crypto.dart';
import 'dart:convert'; // لتوليد اسم فريد من الرابط

class ImageDisplayWidget extends StatefulWidget {
  final String? imageUrl;

  const ImageDisplayWidget({
    Key? key,
    required this.imageUrl,
  }) : super(key: key);

  @override
  _ImageDisplayWidgetState createState() => _ImageDisplayWidgetState();
}

class _ImageDisplayWidgetState extends State<ImageDisplayWidget> {
  bool isSaving = false;
  File? localImageFile;
  bool isZoomed = false; // حالة التحكم بالتكبير

  PhotoViewController photoViewController = PhotoViewController();
  PhotoViewScaleStateController scaleStateController =
      PhotoViewScaleStateController();

  @override
  void initState() {
    super.initState();
    _checkIfImageIsSaved();
    scaleStateController.addIgnorableListener(() {
      // التحقق من حالة التكبير والتصغير
      if (scaleStateController.scaleState == PhotoViewScaleState.zoomedIn ||
          scaleStateController.scaleState == PhotoViewScaleState.zoomedIn) {
        setState(() {
          isZoomed = true; // العودة للحجم الطبيعي
        });
      } else {
        setState(() {
          isZoomed = false; // الصورة مكبرة
        });
      }
    });
  }

  // توليد اسم الصورة من الرابط
  String _generateImageNameFromUrl(String url) {
    Uri uri = Uri.parse(url);
    String? fileName = path.basename(uri.path);

    if (fileName.isEmpty || fileName.contains("?")) {
      var bytes = utf8.encode(url);
      fileName = md5.convert(bytes).toString() + '.jpg';
    }

    return fileName;
  }

  // التحقق مما إذا كانت الصورة محفوظة
  Future<void> _checkIfImageIsSaved() async {
    if (widget.imageUrl == null) return;

    String fileName = _generateImageNameFromUrl(widget.imageUrl!);
    Directory directory = await getApplicationDocumentsDirectory();
    String filePath = path.join(directory.path, fileName);
    File file = File(filePath);

    if (await file.exists()) {
      setState(() {
        localImageFile = file;
      });
    }
  }

  // حفظ الصورة في الذاكرة
  Future<void> saveImage() async {
    if (widget.imageUrl == null) return;

    setState(() {
      isSaving = true;
    });

    try {
      Directory directory = await getApplicationDocumentsDirectory();
      String fileName = _generateImageNameFromUrl(widget.imageUrl!);
      String filePath = path.join(directory.path, fileName);

      Response response = await Dio().download(widget.imageUrl!, filePath);
      if (response.statusCode == 200) {
        setState(() {
          localImageFile = File(filePath);
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('تم حفظ الصورة بنجاح')),
        );
      }
    } catch (e) {
      print("Error saving image: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('فشل في حفظ الصورة')),
      );
    } finally {
      setState(() {
        isSaving = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.all(0),
      content: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        height: MediaQuery.of(context).size.height * 0.7,
        child: localImageFile != null
            ? PhotoView(
                controller: photoViewController,
                scaleStateController: scaleStateController,
                imageProvider: FileImage(localImageFile!),
                backgroundDecoration: BoxDecoration(
                  color: Colors.white,
                ),
                minScale: PhotoViewComputedScale.contained,
                maxScale: PhotoViewComputedScale.covered * 2.0,
                heroAttributes: PhotoViewHeroAttributes(tag: "questionImage"),
              )
            : PhotoView(
                controller: photoViewController,
                scaleStateController: scaleStateController,
                imageProvider: CachedNetworkImageProvider(widget.imageUrl!),
                backgroundDecoration: BoxDecoration(
                  color: Colors.white,
                ),
                minScale: PhotoViewComputedScale.contained,
                maxScale: PhotoViewComputedScale.covered * 2.0,
                heroAttributes: PhotoViewHeroAttributes(tag: "questionImage"),
              ),
      ),
      actions: isZoomed
          ? [] // إخفاء الأزرار عند التكبير
          : <Widget>[
              isSaving
                  ? Center(child: Container(height :20 , width: 20, child: CircularProgressIndicator()))
                  : localImageFile == null
                      ? TextButton(
                          child: Text('حفظ الصورة'),
                          onPressed: saveImage,
                        )
                      : SizedBox.shrink(),
              TextButton(
                child: Text('إغلاق'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
    );
  }
}
