import 'package:flutter/material.dart';
import 'package:mypart/credi_card_page.dart';
class Homepage extends StatefulWidget {




  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int count=0;
  void increment(){
    setState(() {
      count=count+1;
      print(count);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Text("Notification"),
        leading:IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: (){
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context)=> CreditCardPage()));
          },
        ) ,
        actions: <Widget>[
          IconButton(
              icon:Icon(Icons.search),
              onPressed: (){}),
          IconButton(
              icon:Icon(Icons.more_vert),
              onPressed: (){})
        ],
        // flexibleSpace: Image.asset("Asset/sample.jpg",fit:BoxFit.cover),

        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("You have to push button times",style: TextStyle(
                fontSize: 25.0),
            ),
            Text('$count'
              ,style: Theme.of(context).textTheme.displaySmall,
            ),
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: increment,
      //   child:Icon(Icons.add), ) ,
    );
  }
}