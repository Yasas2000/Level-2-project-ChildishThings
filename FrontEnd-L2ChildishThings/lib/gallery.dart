// ignore_for_file: prefer_const_constructors, unnecessary_null_comparison, sort_child_properties_last, avoid_print

import 'dart:async';
import 'dart:convert';
import 'dart:io' as io;
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:file_picker/file_picker.dart';

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

  Future<void> uploadImage(Uint8List? imageBytes) async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('https://localhost:3000/v3/post/single'),
      );
      request.files.add(http.MultipartFile.fromBytes(
        'file',
        imageBytes!.toList(), // convert Uint8List to List<int>
        filename: 'image.jpg',
      ));
      var response = await request.send();
      if (response.statusCode == 200) {
        print('Upload successful');
      } else {
        print('Upload failed with status: ${response.statusCode}');
      }
    } catch (e) {
      print('Error uploading image: $e');
    }
  }

  Future<void> uploadImages(List<io.File> files) async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('https://localhost:3000/v3/post/multiple'),
      );
      for (var file in files) {
        request.files
            .add(await http.MultipartFile.fromPath('files', file.path));
      }
      var response = await request.send();
      if (response.statusCode == 200) {
        print('Upload successful');
      } else {
        print('Upload failed with status: ${response.statusCode}');
      }
    } catch (e) {
      print('Error uploading images: $e');
    }
  }

  Future<void> _pickImage() async {
    final result = await FilePicker.platform.pickFiles();

    if (result != null) {
      final file = io.File(result.paths.first!);
      final bytes = await file.readAsBytes();
      uploadImage(bytes);
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
        uploadImages([file]); // wrap the file object in a list
      }
    } else {
      // User canceled the picker
    }
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
          Container(
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
                      return GestureDetector(
                        onTap: () {
                          // handle image tap event
                        },
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
                                        onPressed: () {
                                          // handle download icon tap event
                                        },
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
                                          // handle fullscreen icon tap event
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
