import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hec_eservices/Models/ApplicationModel.dart';
import 'package:hec_eservices/Models/TemplateModel.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../utils/MyColors.dart';
import 'package:screenshot/screenshot.dart';
import 'package:path/path.dart' as path;

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
      Uint8List? imageBytes = await _screenshotController.capture(
        pixelRatio: 3.0, // Adjust pixelRatio as needed
        delay: Duration(milliseconds: 10), // Delay before capturing
      );

      // Request permission to access external storage
      var status = await Permission.storage.request();

      if (status.isGranted) {
        // Get the external storage directory (usually the device's Pictures folder)
        final directory = await getExternalStorageDirectory();

        if (directory != null) {
          // Specify the file path to save the image in the Pictures directory
          final filePath = path.join(directory.path, 'captured_image.png');

          // Save the image bytes to the specified file path
          File(filePath).writeAsBytesSync(imageBytes!);

          setState(() {
            _imageBytes = imageBytes;
          });

          Fluttertoast.showToast(
              msg: 'Widget captured and saved as an image to: $filePath',
              toastLength: Toast.LENGTH_SHORT);
          print('Widget captured and saved as an image to: $filePath');
        } else {
          print('Error: External storage directory is null.');
        }
      } else {
        print('Permission denied to access storage.');
      }
    } catch (e) {
      Fluttertoast.showToast(
          msg: 'Widget capture failed', toastLength: Toast.LENGTH_SHORT);
      print('Error capturing and saving the widget as an image: $e');
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
