import 'dart:io';
import 'package:auto/core/ui/toaster.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_file_dialog/flutter_file_dialog.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class MediaHelper
{
  static downloadImage(String url, {String? outputMimeType}) async {

    String? message;

    try {
      // Download image
      final http.Response response = await http .get(Uri.parse(url),);
      // Get temporary directory
      final dir = await getTemporaryDirectory();

      // Get the image name
      final imageName = url.split('/').last;

      // Create an image name
      var filename = '${dir.path}/$imageName';

      // Save to filesystem
      final file = File(filename);
      await file.writeAsBytes(response.bodyBytes);
if(file!=null)
  {
    print("ljasdas");
  }
      // Ask the user to save it
      final params = SaveFileDialogParams(sourceFilePath: file.path);
      final finalPath = await FlutterFileDialog.saveFile(params: params);

      if (finalPath != null) {
        message = 'downloaded successfully';
      }
    } catch (e) {
      print(e.toString());
      print("ljnlnasdasd");
      message = 'An error occurred while saving the image';
    }

    if (message != null) {
      Toaster.showToast(message);
    }
  }


}