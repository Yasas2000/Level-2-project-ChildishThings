// ignore_for_file: prefer_const_constructors, unnecessary_null_comparison, sort_child_properties_last, avoid_print, slash_for_doc_comments, use_build_context_synchronously, prefer_const_literals_to_create_immutables, sized_box_for_whitespace

import 'dart:async';
import 'dart:convert';
import 'dart:io' as io;
import 'package:flutter/material.dart';
import 'package:frontend/CommentPage.dart';
import 'package:frontend/FullScreenImagePage.dart';
import 'package:frontend/bottom_navbar.dart';
import 'package:frontend/configs.dart';
import 'package:http/http.dart' as http;
import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import 'homepage.dart';
import 'login_state.dart';
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
  String comment = '';
  int imageCount = 0;
  final TextEditingController _comment = TextEditingController();

  Future<void> _fetchImageUrls() async {
    final response = await http.get(Uri.parse(gallery_localhost+'/images'));
    final jsonData = json.decode(response.body);
    final List<dynamic> imageUrlData = jsonData['images'];
    if (mounted) {
      setState(() {
        imageUrls = imageUrlData.cast<String>();
        imageCount = imageUrls.length;
      });
    }
  }

  Future<void> _uploadImage(List<int> bytes) async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(gallery_localhost+'/v3/post/single'),
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
        Uri.parse(gallery_localhost+'/v3/post/multiple'),
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

  void showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }
  Future<void> saveImageToGallery(String imageUrl) async {
    var response = await http.get(Uri.parse(imageUrl));
    final result = await ImageGallerySaver.saveImage(
      response.bodyBytes,
      quality: 100,
    );
    print(result); // Prints the path of the saved image
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
    final loginState=Provider.of<LoginState>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.home,size: 40,),color: Colors.deepOrange,
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>
                HomePage()
            ));
          },
        ),
        centerTitle: true,
        title: Text(
          'Gallery',
          style: TextStyle(
            color: Colors.deepOrange,fontSize: 24
          ),
        ),
        actions: [
          IconButton(
            padding: EdgeInsetsDirectional.only(end: 10),
            icon: Icon(Icons.comment,color: Colors.deepOrange,size: 40,),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Commentpage(),
                ),
              );
            },
          ),
        ],
      ),
      bottomNavigationBar: BottomNavbar(initialIndex: 3,),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: 150,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('Asset/bg.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'Image Count: ',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '$imageCount',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepOrangeAccent,
                  ),
                ),
                Spacer(),
                Visibility(
                  visible: loginState.role=='Admin',
                  child: PopupMenuButton(
                    icon: Icon(Icons.add, color: Colors.black),
                    itemBuilder: (BuildContext context) {
                      return [
                        PopupMenuItem(
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Colors.deepOrange,
                              child: Icon(
                                Icons.image,
                                color: Colors.white,
                              ),
                            ),
                            title: Text(
                              'Upload Single Image',
                              style: TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          value: 'single',
                        ),
                        PopupMenuItem(
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Colors.deepOrange,
                              child: Icon(
                                Icons.collections,
                                color: Colors.white,
                              ),
                            ),
                            title: Text(
                              'Upload Multiple Images',
                              style: TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
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
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height - 400,
                child: GridView.builder(
                  padding: EdgeInsets.all(10),
                  itemCount: imageUrls.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    // callback function called for each image
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
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () =>
                                          saveImageToGallery(imageUrls[index]),
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
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                FullScreenImagePage(
                                              imageUrl: imageUrls[index],
                                            ),
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
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                Stack(
                  alignment: Alignment.centerRight,
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: TextField(
                        controller: _comment,
                        decoration: InputDecoration(
                          labelText: 'Leave a comment',
                          border: OutlineInputBorder(),
                          hintText:'Comment'
                        ),
                        onChanged: (value) {
                          setState(() {
                            comment = value;
                          });
                        },
                      ),
                    ),
                    InkWell(
                      onTap: () async {
                        final response = await http.post(
                          Uri.parse(gallery_localhost+'/comments'),
                          body: json.encode({'content': comment}),
                          headers: {'Content-Type': 'application/json'},
                        );

                        if (response.statusCode == 201) {
                          setState(() {
                            _comment.clear();
                          });
                          showSnackBar('Comment saved successfully');
                        } else {
                          showSnackBar('An error occurred');
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.all(8),
                        child: Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                        ),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.deepOrange,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
