import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import './stripesTile.dart';
import 'addStripestile.dart';
import 'addStripestile.dart';
import 'package:http/http.dart' as http;
import 'app_bar.dart';
import 'configs.dart';
import 'custom.dart';
import 'login_state.dart';

//All the stripe tiles will be displayed here



class Stripes extends StatefulWidget {



  @override
  _typeState createState() => _typeState();
}

class _typeState extends State<Stripes> {

  double amount = 0.0;
  List<Stripe> tileList = [];

  Future<List<Stripe>> fetchData() async {
    var url = Uri.parse(localhost + '/api/getAllStripes');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      List data = jsonDecode(response.body) as List;
      tileList.clear();
      print(data);
      print(data[0]['text']);
      for (var items in data){
        var imageAsset=items['imageAsset'];
        var text=items['text'];
        var amount=items['amount'];
        var hour=items['hour'];
        Stripe sr=Stripe(imageAsset, text, amount, hour);
        tileList.add(sr);
        print('hi');

      }
      print('fku');
      print(tileList[0]);
      return tileList;
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  void initState() {
    super.initState();
    tileList.clear();
  }


  void _deleteTile(Stripe tile) {
    setState(() {
      tileList.remove(tile);
    });
  }

  @override
  Widget build(BuildContext context) {
    final loginState=Provider.of<LoginState>(context);
    return Scaffold(
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
            image: AssetImage("Asset/new.jpg"),
            fit:BoxFit.fill,
          ),
        ),
          child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                        color: Colors.deepOrange,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Visibility(
                        visible: loginState.role=="Admin",
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.deepOrange,
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
                        primary: Colors.deepOrange,
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
                            ),
                          ),
                        );
                      },
                    ),
                        FutureBuilder(
                            future: fetchData(),
                            builder: (BuildContext context,AsyncSnapshot snapshot){
                              if(snapshot.connectionState==ConnectionState.waiting){
                                return  Center(
                                  child: LoadingAnimationWidget.staggeredDotsWave(
                                    color: Colors.deepOrange,
                                    size: 100,
                                  ),
                                );
                              }else{
                                if(snapshot.hasError){
                                  return Text(snapshot.error.toString()+'fuck');
                                }
                                else{
                                  return ListView.builder(
                                      shrinkWrap: true,
                                      scrollDirection: Axis.vertical,
                                      itemCount: snapshot.data.length,
                                      itemBuilder: (BuildContext context,int index){
                                        return PhotoTile(
                                          imageAsset: snapshot.data[index].imageAsset ?? "",
                                          text: snapshot.data[index].text ?? "",
                                          amount: snapshot.data[index].amount ?? "",
                                          hour: snapshot.data[index].hour ?? "",
                                          onDelete: () {
                                            _deleteTile(snapshot.data[index]);
                                          }, id: '',
                                        );
                                      });
                                }
                              }
                            }),


                    // Expanded(
                    //   child: LayoutBuilder(
                    //     builder: (context, constraints) {
                    //       return Flexible(
                    //           child: GridView.count(
                    //             padding: const EdgeInsets.all(10),
                    //             shrinkWrap: true,
                    //             crossAxisCount: 1,
                    //             mainAxisSpacing: 10,
                    //             childAspectRatio: 1.5,
                    //             children: tileList.map((tile) {
                    //               return PhotoTile(
                    //                 imageAsset: tile.imageAsset ?? "",
                    //                 text: tile.text?? "",
                    //                 amount: tile.amount?? "",
                    //                 hour: tile.hour ?? "",
                    //                 onDelete: () {
                    //                   _deleteTile(tile as Map<String, dynamic>);
                    //                 }, id: '',
                    //               );
                    //             }).toList(),
                    //           ));
                    //     },
                    //   ),
                    // )




                  ],
                ),
              ),
            
          ),

      ),
    );
  }
}
class Stripe{
  String imageAsset;
  String text;
  String amount;
  String hour;
  Stripe(this.imageAsset,this.text,this.amount,this.hour);
}