import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:hec_eservices/Models/UserModel.dart';

import '../utils/MyColors.dart';

class ImageGallery extends StatefulWidget {
  @override
  _ImageGalleryState createState() => _ImageGalleryState();
}

class _ImageGalleryState extends State<ImageGallery> {
  List<String> imageNames = []; // Store fetched image file names
  bool isLoading = true; // Loading indicator

  @override
  void initState() {
    super.initState();
    fetchImageNames();
  }

  Future<void> fetchImageNames() async {
    setState(() {
      isLoading = true;
    });

    firebase_storage.ListResult result = await firebase_storage
        .FirebaseStorage.instance
        .ref(
            '${UserModel.CurrentUserCnic}/documents') // Change this path to your Firebase Storage folder
        .listAll();

    List<String> names = [];
    for (firebase_storage.Reference ref in result.items) {
      String name = ref.name;
      names.add(name);
    }

    setState(() {
      imageNames = names;
      isLoading = false;
    });
  }

  void _openImage(String imageName) async {
    String imageUrl = await firebase_storage.FirebaseStorage.instance
        .ref('${UserModel.CurrentUserCnic}/documents/$imageName')
        .getDownloadURL();

    var imagePath = firebase_storage.FirebaseStorage.instance
        .ref('${UserModel.CurrentUserCnic}/documents/$imageName');

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            ImageDetailScreen(imageUrl: imageUrl, imagePath: imagePath),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.greenColor,
        title: const Text('User Images'),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : imageNames.isEmpty
              ? const Center(
                  child: Text('No Documents Yet'),
                )
              : ListView.builder(
                  itemCount: imageNames.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        ListTile(
                          leading: const Icon(Icons.image),
                          title: Text(imageNames[index]),
                          onTap: () => _openImage(imageNames[index]),
                        ),
                        const Divider(
                          thickness: 1,
                        ),
                      ],
                    );
                  },
                ),
    );
  }
}

class ImageDetailScreen extends StatelessWidget {
  final String imageUrl;
  final imagePath;

  ImageDetailScreen({required this.imageUrl, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.greenColor,
        title: const Text('Image Detail'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context, imagePath);
              Navigator.pop(context);
            },
            child: const Padding(
              padding: EdgeInsets.only(right: 8.0),
              child: Text(
                'Select',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ),
        ],
      ),
      body: Center(
        child: Image.network(
          imageUrl,
          loadingBuilder: (context, child, progress) {
            return progress == null
                ? child
                : const CircularProgressIndicator(
                    valueColor:
                        AlwaysStoppedAnimation<Color>(MyColors.greenColor),
                  ); // Show loading indicator
          },
        ),
      ),
    );
  }
}
