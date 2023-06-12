import 'package:flutter/material.dart';
import 'package:frontend/portraitEsti.dart';
import 'package:frontend/stripes.dart';
import 'package:provider/provider.dart';
import 'app_bar.dart';
import 'login_state.dart';

//Display whether to choose stripe photos or portrait photos

class type extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final loginState=Provider.of<LoginState>(context);
    final screenWidth = MediaQuery.of(context).size.width;

    return  Scaffold(
        appBar: CustomAppBar(
          title: 'Type',
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
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("Asset/new.jpg"),
              fit: BoxFit.cover,
              opacity: 0.5
            ),
          ),
          child: Column(
            children: <Widget>[
              Flexible(
                flex: 1,
                child: Container(
                  child: Image.asset(
                    'assets/logo.png',
                    width: 0.8 * screenWidth,
                    height: 0.8 * screenWidth,
                    color: Colors.deepOrange,
                  ),
                ),
              ),
              Flexible(
                flex: 2,
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Container(
                    child: GridView.count(
                      crossAxisCount: 1,
                      mainAxisSpacing: 10,
                      childAspectRatio: 1.5,
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(25.0),
                                ),
                                border: Border.all(
                                  color: Colors.deepOrange,
                                  width: 0.01 * screenWidth,
                                ),
                              ),
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Stripes(
                                      ),
                                    ),
                                  );
                                },
                                child: Image.asset(
                                  'Asset/stripe1.jpg',
                                  width: 0.4 * screenWidth,
                                  height: 0.4 * screenWidth,
                                ),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'STRIPE PHOTO',
                                style: TextStyle(
                                  color: Colors.deepOrange,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
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
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(25.0),
                                ),
                                border: Border.all(
                                  color: Colors.deepOrange,
                                  width: 0.01 * screenWidth,
                                ),
                              ),
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => portraitEsti(
                                      ),
                                    ),
                                  );
                                },
                                child: Image.asset(
                                  'Asset/potarit1.jpg',
                                  width: 0.4 * screenWidth,
                                  height: 0.4 * screenWidth,
                                ),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'PORTRAIT PHOTO',
                                style: TextStyle(
                                  color: Colors.deepOrange,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
  }
}
