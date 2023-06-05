// ignore_for_file: prefer_const_constructors, unnecessary_null_comparison, sort_child_properties_last, avoid_print, slash_for_doc_comments, use_build_context_synchronously

import 'dart:async';
import 'dart:convert';
import 'dart:io' as io;
import 'package:flutter/material.dart';
import 'package:frontend/FullScreenImagePage.dart';
import 'package:http/http.dart' as http;
import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
/**
 * This is the Gallery Screen
 */

class ImageGallery extends StatefulWidget {
  const ImageGallery({super.key});

  @override
  State<ImageGallery> createState() => _ImageGalleryState();
}

class _ImageGalleryState extends State<ImageGallery>
    with TickerProviderStateMixin {
  late List<String> imageUrls = [];

  Future<void> _fetchImageUrls() async {
    final response = await http.get(Uri.parse('http://localhost:3000/images'));
    final jsonData = json.decode(response.body);
    final List<dynamic> imageUrlData = jsonData['images'];
    setState(() {
      imageUrls = imageUrlData.cast<String>();
    });
  }

  Future<void> _uploadImage(List<int> bytes) async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('http://localhost:3000/v3/post/single'),
      );
      request.files.add(
        http.MultipartFile.fromBytes(
          'file',
          bytes,
          filename: 'image.jpg',
        ),
      );
      var response = await request.send();
      if (response.statusCode == 200) {
        print('Image uploaded successfully!');
      }
    } catch (error) {
      print('Error uploading image: $error');
    }
  }

  Future<void> _uploadImages(List<io.File> files) async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('http://localhost:3000/v3/post/multiple'),
      );
      for (var i = 0; i < files.length; i++) {
        request.files.add(
          await http.MultipartFile.fromPath(
            'files',
            files[i].path,
          ),
        );
      }
      var response = await request.send();
      if (response.statusCode == 200) {
        print('Images uploaded successfully!');
      }
    } catch (error) {
      print('Error uploading images: $error');
    }
  }

  Future<void> _pickImage() async {
    final result = await FilePicker.platform.pickFiles();

    if (result != null) {
      final file = io.File(result.paths.first!);
      final bytes =
          await file.readAsBytes(); //reads the contents of file a sbytes
      await _uploadImage(bytes);
    } else {
      // User canceled the picker
    }
  }

  Future<void> _pickImages() async {
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.image,
    );

    if (result != null) {
      List<io.File> files = result.paths.map((path) => io.File(path!)).toList();
      for (io.File file in files) {
        await _uploadImages([file]); // wrap the file object in a list
      }
    } else {
      // User canceled the picker
    }
  }

 void downloadImage(String imageUrl) async {
  // Request permission to access the image gallery
  PermissionStatus status = await Permission.storage.request();

  if (status.isGranted) {
    // Permission is granted, proceed with image download and saving
    http.Response response = await http.get(Uri.parse(imageUrl));

    if (response.statusCode == 200) {
      // Save the image file to the app's temporary directory
      io.Directory tempDir = await getTemporaryDirectory();
      String tempPath = tempDir.path;
      String fileName = imageUrl.split('/').last.replaceAll(RegExp(r'[^\w\s\-.]'), '');
      String filePath = '$tempPath/$fileName';
      await io.File(filePath).writeAsBytes(response.bodyBytes);

      // Save the image to the gallery
      final result = await ImageGallerySaver.saveFile(filePath);

      if (result['isSuccess']) {
        showToast('Image downloaded and saved to gallery successfully');
      } else {
        showToast('Failed to save image to gallery');
      }

      // Delete the temporary image file
      await io.File(filePath).delete();
    } else {
      showToast('Failed to download image');
    }
  } else {
    // Permission is denied, show a toast or any other feedback to indicate that the save operation is not possible
    showToast('Permission denied. Cannot save image to gallery');
  }
}


// Function to show a toast with a message
void showToast(String message) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
  );
}



  @override
  void initState() {
    super.initState();
    _fetchImageUrls();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[200], // Optional: Set background color
        leading: IconButton(
          icon: Icon(
            Icons.home,
            color: Colors.black,
          ),
          onPressed: () {
            //Navigate to Home page
          },
        ),
        actions: [
          PopupMenuButton(
            icon: Icon(Icons.add, color: Colors.black),
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(
                  child: Text('Upload Single Image'),
                  value: 'single',
                ),
                PopupMenuItem(
                  child: Text('Upload Multiple Images'),
                  value: 'multiple',
                ),
              ];
            },
            onSelected: (value) {
              if (value == 'single') {
                _pickImage();
              } else if (value == 'multiple') {
                _pickImages();
              }
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Opacity(
            opacity: 0.8,
            child: Container(
              height: 150,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/bg.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Center(
                child: Text(
                  'GALLERY',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: imageUrls.isEmpty
                ? Center(
                    child: Text('No images'),
                  )
                : GridView.builder(
                    padding: EdgeInsets.all(10),
                    itemCount: imageUrls.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      //callback fyunction called for each image
                      return GestureDetector(
                        child: Stack(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                  image: NetworkImage(imageUrls[index]),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.topRight,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Stack(
                                    children: [
                                      Container(
                                        width: 40,
                                        height: 40,
                                        decoration: BoxDecoration(
                                          color: Colors.transparent,
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                      ),
                                      IconButton(
                                         onPressed: () => downloadImage(imageUrls[index]),
                                        icon: Icon(Icons.download),
                                        color: Colors.black,
                                      ),
                                    ],
                                  ),
                                  Stack(
                                    children: [
                                      Container(
                                        width: 40,
                                        height: 40,
                                        decoration: BoxDecoration(
                                          color: Colors.transparent,
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  FullScreenImagePage(
                                                      imageUrl:
                                                          imageUrls[index]),
                                            ),
                                          );
                                        },
                                        icon: Icon(Icons.fullscreen),
                                        color: Colors.black,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
