import 'dart:convert';
import 'package:myproject/configs.dart';
import 'package:myproject/custom.dart';
import 'package:myproject/type.dart';
import 'package:flutter/material.dart';
import './stripesTile.dart';
import 'addStripestile.dart';
import 'addStripestile.dart';
import 'package:http/http.dart' as http;
import 'package:myproject/appbar.dart';

//All the stripe tiles will be displayed here

Future<List<Map<String, dynamic>>> fetchData() async {
  var url = Uri.parse(localhost + '/getAllStripes');
  final response = await http.get(url);
  if (response.statusCode == 200) {
    List<dynamic> data = json.decode(response.body);
    return data.map((e) => Map<String, dynamic>.from(e)).toList();
  } else {
    throw Exception('Failed to load data');
  }
}

class Stripes extends StatefulWidget {
  bool isAdmin;

  Stripes({required this.isAdmin});
  @override
  _typeState createState() => _typeState();
}

class _typeState extends State<Stripes> {
  double amount = 0.0;
  List<Map<String, dynamic>> tileList = [];

  @override
  void initState() {
    super.initState();
    fetchData().then((value) {
      setState(() {
        tileList = value;
      });
    });
  }

  void _addTile(String imageAsset, String text, String amount, String hour) {
    setState(() {
      tileList.add({
        'imageAsset': imageAsset,
        'text': text,
        'amount': amount,
        'hour': hour,
      });
    });
  }

  void _deleteTile(Map<String, dynamic> tile) {
    setState(() {
      tileList.remove(tile);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: CustomAppBar(
        title: 'Stripes',
        leadingIcon: IconButton(
          icon: Icon(
            Icons.home,
            color: Colors.deepOrange,
            size: 40,
          ),
          onPressed: () {},
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("new.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 25,
            ),
            const Text(
              "Stripes Photos",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
                color: Colors.orange,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Visibility(
                visible: widget.isAdmin,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.orange,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  child: const Text(
                    'click here to add new stripe type',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 10,
                    ),
                  ),
                  onPressed: () async {
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddPhotoTileScreen(),
                      ),
                    );
                  },
                )),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.orange,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
              child: const Text(
                'Click here to custom',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 10,
                ),
              ),
              onPressed: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => custom(
                      isAdmin: widget.isAdmin,
                    ),
                  ),
                );
              },
            ),
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return Flexible(
                      child: GridView.count(
                    padding: const EdgeInsets.all(10),
                    shrinkWrap: true,
                    crossAxisCount: 1,
                    mainAxisSpacing: 10,
                    childAspectRatio: 1.5,
                    children: tileList.map((tile) {
                      return PhotoTile(
                        imageAsset: tile['imageAsset'] ?? "",
                        text: tile['text'] ?? "",
                        amount: tile['amount'] ?? "",
                        hour: tile['hour'] ?? "",
                        isAdmin: widget.isAdmin,
                        onDelete: () {
                          _deleteTile(tile);
                        },
                      );
                    }).toList(),
                  ));
                },
              ),
            )
          ],
        ),
      ),
    ));
  }
}
