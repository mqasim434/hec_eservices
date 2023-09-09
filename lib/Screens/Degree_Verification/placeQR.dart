import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hec_eservices/Models/ApplicationModel.dart';
import 'package:hec_eservices/Models/TemplateModel.dart';
import 'package:hec_eservices/utils/MyColors.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screenshot/screenshot.dart';

class PlaceQR extends StatefulWidget {
  PlaceQR({
    super.key,
    required this.imageFile,
    required this.upload,
    required this.index,
    required this.templateType,
  });

  File imageFile;
  var upload;
  int index;
  String templateType;

  @override
  State<PlaceQR> createState() => _PlaceQRState();
}

class _PlaceQRState extends State<PlaceQR> {
  final ScreenshotController _screenshotController = ScreenshotController();
  Uint8List? _imageBytes;
  final GlobalKey _widgetKey = GlobalKey();

  Future<void> captureAndSaveImage() async {
    try {
       _imageBytes = await _screenshotController.capture(
        pixelRatio: 3.0, // Adjust pixelRatio as needed
        delay: Duration(milliseconds: 10), // Delay before capturing
      );

    }catch (e) {
      Fluttertoast.showToast(
          msg: 'Widget capture failed', toastLength: Toast.LENGTH_SHORT);
      print('Error capturing the widget as an image: $e');
    }
    var status = await Permission.storage.request();

    if (status.isGranted) {
      final directory = await getExternalStorageDirectory();

      if (directory != null) {
        final result = await ImageGallerySaver.saveImage(_imageBytes!);
        if (result != null && result['isSuccess'] == true) {
          // Image was successfully saved to the gallery.
          print('Image saved to gallery');
        } else {
          // There was an error saving the image.
          print('Failed to save image to gallery');
        }
      } else {
        print('Permission denied to access storage.');
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    UniversityTemplates.fetchTemplates();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    // UniversityTemplates.universityTemplatesList.clear();
  }

  @override
  Widget build(BuildContext context) {
    String institute = Application.degreeInstitutes[widget.index];
    UniversityTemplates universityTemplate = UniversityTemplates
        .universityTemplatesList
        .firstWhere((element) => element.University_Name.toString() == institute);

    var jsonData = universityTemplate.toJson();
    print("###############${widget.templateType}");
    print("###############${jsonData}");
    return SafeArea(
      child: Scaffold(
        body: Scaffold(
          appBar: AppBar(
            elevation: 0,
            iconTheme: const IconThemeData(
              color: Colors.black, //change your color here
            ),
            backgroundColor: Colors.blueGrey[50],
            title: const Text(
              'Place QR',
              style: TextStyle(color: Colors.black),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Screenshot(
              controller: _screenshotController,
              child: Stack(
                key: _widgetKey,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Center(
                        child: Container(
                          height: 600,
                          child: Image.file(
                            widget.imageFile,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          captureAndSaveImage();
                        },
                        child: Container(
                          width: double.maxFinite,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              gradient: MyColors.gradient3),
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          child: const Center(
                            child: Text(
                              "Save Image",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Center(
                    child: QrImageView(
                      data: jsonData[widget.templateType],
                      version: 1,
                      size: 120,
                      backgroundColor: Colors.white,
                      embeddedImage: const AssetImage('assets/logo.png'),
                      errorStateBuilder: (cxt, err) {
                        return const Center(
                          child: Text(
                            'Uh oh! Something went wrong...',
                            style: TextStyle(color: Colors.black),
                            textAlign: TextAlign.center,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
