/*import 'package:flutter/material.dart';

import 'package:admin/stripes.dart';
import 'package:admin/portraitEsti.dart';
import 'package:flutter/services.dart';

class type extends StatelessWidget {
  final bool isAdmin;

  const type({required this.isAdmin});
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      double availableWidth = constraints.maxWidth;
      double availableHeight = constraints.maxHeight;

      return Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("new.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'logo.png',
              width: availableWidth * 0.5, // adjust width based on screen size
              height:
                  availableHeight * 0.2, // adjust height based on screen size
            ),
            const Text(
              "Photoboothme Pricing Calculator",
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
            ),
            const Text(
              "What are you looking for?",
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            Expanded(
              child: GridView.count(
                physics: NeverScrollableScrollPhysics(),
                padding: EdgeInsets.all(availableWidth *
                    0.1), // adjust padding based on screen size
                shrinkWrap: true,
                crossAxisCount: availableWidth > 600
                    ? 2
                    : 1, // adjust column count based on screen size
                childAspectRatio: 1.0,
                mainAxisSpacing: availableWidth *
                    0.05, // adjust spacing based on screen size
                crossAxisSpacing: availableWidth *
                    0.05, // adjust spacing based on screen size
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(25.0),
                            topRight: Radius.circular(25.0),
                            bottomLeft: Radius.circular(25.0),
                            bottomRight: Radius.circular(25.0),
                          ),
                          border: Border.all(
                            color: Colors.orange,
                            width: 4,
                          ),
                        ),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Stripes(
                                        isAdmin: isAdmin,
                                      )),
                            );
                          },
                          child: Image.asset(
                            'stripe1.jpg',
                            width: availableWidth *
                                0.3, // adjust width based on screen size
                            height: availableHeight *
                                0.3, // adjust height based on screen size
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text(
                          'STRIPE PHOTO',
                          style: TextStyle(
                            color: Colors.orange,
                            fontSize: 22,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(25.0),
                            topRight: Radius.circular(25.0),
                            bottomLeft: Radius.circular(25.0),
                            bottomRight: Radius.circular(25.0),
                          ),
                          border: Border.all(
                            color: Colors.orange,
                            width: 4,
                          ),
                        ),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => portraitEsti(
                                        isAdmin: isAdmin,
                                      )),
                            );
                          },
                          child: Image.asset(
                            'potarit1.jpg',
                            width: availableWidth *
                                0.3, // adjust width based on screen size
                            height: availableHeight *
                                0.3, // adjust height based on screen size
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text(
                          'PORTRAIT PHOTO',
                          style: TextStyle(
                            color: Colors.orange,
                            fontSize: 22,
                          ),
                          textAlign: TextAlign.center,
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
    }));
  }
}*/

import 'package:flutter/material.dart';
import 'package:admin/stripes.dart';
import 'package:admin/portraitEsti.dart';




class type extends StatelessWidget {
  final bool isAdmin;

  const type({required this.isAdmin});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
          body: Padding(
            padding: EdgeInsets.all(5),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("new.jpg"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Image.asset(
                    'logo.png',
                    width: 200,
                    height: 200,
                  ),
                  const Text(
                    "Photoboothme Pricing Calculator",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                  ),
                  const Text(
                    "What are you looking for?",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: GridView.count(
                      physics: NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.all(100),
                      shrinkWrap: true,
                      crossAxisCount: 1,
                      childAspectRatio: 1.0,
                      mainAxisSpacing: 2.0,
                      crossAxisSpacing: 2.0,
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(25.0),
                                  topRight: Radius.circular(25.0),
                                  bottomLeft: Radius.circular(25.0),
                                  bottomRight: Radius.circular(25.0),
                                ),
                                border: Border.all(
                                  color: Colors.orange,
                                  width: 4,
                                ),
                              ),
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Stripes(
                                        isAdmin: isAdmin,
                                      )),
                            );

                                },
                                child: Image.asset(
                                  'stripe1.jpg',
                                  width: 250,
                                  height: 250,
                                ),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Text(
                                'STRIPE PHOTO',
                                style: TextStyle(
                                  color: Colors.orange,
                                  fontSize: 22,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(25.0),
                                  topRight: Radius.circular(25.0),
                                  bottomLeft: Radius.circular(25.0),
                                  bottomRight: Radius.circular(25.0),
                                ),
                                border: Border.all(
                                  color: Colors.orange,
                                  width: 4,
                                ),
                              ),
                              child: InkWell(
                                onTap: () {
                                  onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => portraitEsti(
                                        isAdmin: isAdmin,
                                      )),
                            );
                          };

                                },
                                child: Image.asset(
                                  'potarit1.jpg',
                                  width: 250,
                                  height: 250,
                                ),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'PORTRAIT PHOTO',
                                style: TextStyle(
                                  color: Colors.orange,
                                  fontSize: 22,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
    );
  }
}

