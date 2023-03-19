//import 'package:carousel_slider/carousel_slider.dart';
//import 'dart:html';

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:frontend/donation_form.dart';
import 'package:frontend/feedbackpage.dart';
import 'package:frontend/leaderboard.dart';
import 'package:frontend/loginscreen.dart';
import 'package:frontend/notifications.dart';
import 'package:frontend/signup_screen.dart';
import 'package:http/http.dart' as http;


class HomePage extends StatefulWidget {
  const HomePage({super.key});


  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>{
  // ignore: non_constant_identifier_names
  int _SelectIndex =0;

  void _onItemTapped(int index) {
    setState(() {
      _SelectIndex = index;
    });
  }

  @override
  Widget build (BuildContext context){
    return  Scaffold(

        appBar: AppBar(
          centerTitle: true,
          toolbarHeight:250 ,
          backgroundColor: Colors.transparent,
          elevation: 0,

          automaticallyImplyLeading: false,
          leading:IconButton(
              onPressed: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>
                    NotificationsPage()
                ));
              },
              icon: Icon(Icons.notifications,color: Colors.deepOrange,size: 40,)), //Image.asset('assets/images/logo.png', height: 50,color: Colors.black),,
          title: SizedBox(

            height: 300,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Image.asset('assets/images/logo.png', height: 300,width: 400,color: Colors.deepOrange,scale:0.5,),
                ),
                // const SizedBox(height: 10),
                // Expanded(child:  Container(
                //   height: 50,
                //   child: const Text(
                //     'PhotoBoothMe',
                //     style: TextStyle(
                //       color: Colors.black,
                //       fontSize: 18.0,
                //       fontWeight: FontWeight.bold,
                //     ),
                //   ),
                // ),
                // ),

              ],
            ),
          ),
          actions: [
            Padding(
              padding: EdgeInsets.all(5),
              child: IconButton(
                icon: const Icon(Icons.menu,size: 40,color: Colors.deepOrange,),
                onPressed: (){
                  showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context){
                      return const SlidingBar(
                          username: 'Johnna Max',
                          userImageURL: 'https://imgs.search.brave.com/aaP9RIfujXe4q-op1nz8rpwCLTjosRqT-xyZLL8TdSw/rs:fit:706:225:1/g:ce/aHR0cHM6Ly90c2Uy/Lm1tLmJpbmcubmV0/L3RoP2lkPU9JUC5r/Vngwb2hTSm9zWVNE/QjlRWHIxUG9RSGFF/LSZwaWQ9QXBp'

                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
        body: Container(
          child: SingleChildScrollView(

            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: [
                  Container(
                    height: 300,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/1.jpg'),
                        fit: BoxFit.cover,

                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          'Welcome to PhotoBoothMe',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Your one-stop solution for all photography needs',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Expanded(
                    child: Center(
                      child: Text('Home page'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.deepOrange,
          items:  [
            BottomNavigationBarItem(
              icon: Icon(Icons.home, color: Colors.deepOrange),
              label: 'Home',
            ),
            BottomNavigationBarItem(
            icon: IconButton(
              icon: Icon(Icons.handshake,color: Colors.deepOrange,),
              onPressed: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>
                    DonationForm()
                ));
              },
            ),
              label: 'Donation',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.money, color: Colors.deepOrange),
              label: 'Request money',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.dashboard, color: Colors.deepOrange),
              label: 'Dashboard',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.photo_camera_back, color: Colors.deepOrange),
              label: 'PhotoBoothMe icon',
            ),
          ],
          currentIndex: _SelectIndex,
          selectedItemColor: Colors.amber,
          onTap: _onItemTapped,
        ),
      );

  }
}

class SlidingBar extends StatelessWidget {
  final String username;
  final String userImageURL;

  const SlidingBar({
    super.key, required this.username, required this.userImageURL
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Colors.orange,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CircleAvatar(
                  radius: 40.0,
                  backgroundImage: NetworkImage(userImageURL),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Text(
                  username,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            title: const Text('Log In'),
            onTap: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>
                  LoginScreen()
              ));
            },
          ),
          ListTile(
            title: const Text('Create Account'),
            onTap: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>
                  SignUpScreen()
              ));
            },
          ),

          ListTile(
            title: const Text('Our Story'),
            onTap: (){},
          ),
          ListTile(
            title: const Text('Pricing'),
            onTap: (){},
          ),
          ListTile(
            title: const Text('Photo Gallery'),
            onTap: (){},
          ),
          ListTile(
            title: const Text('Leaderboard'),
            onTap: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>
                  LeaderboardPage()
              ));
            },
          ),
          ListTile(
            title: const Text('Feedback'),
            onTap:(){
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>
                  FeedbackBar()
              ));
            },
          ),
          ListTile(
            title: const Text('Log Out'),
            onTap: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>
                  HomePage()
              ));
            },
          ),
        ],
      ),
    );
  }
}

class SliderState extends State<HomePage>{ //<slider>
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Carousel Slider'),
      ),
      // body: ListView(
      //   children: [
      //     CarouselSlider(
      //         items: [
      //           Container(
      //             margin: const EdgeInsets.all(6.0),
      //             decoration: BoxDecoration(
      //               borderRadius: BorderRadius.circular(8.0),
      //               image: const DecorationImage(
      //               image: NetworkImage('https://images.squarespace-cdn.com/content/v1/5f633f2a3ceb25330f960d39/1678801331388-XRCF7E05N3LH1CRNVUWY/image-asset.jpeg?format=500w'),
      //               fit: BoxFit.cover,
      //               ),
      //             ),
      //           )
      //         ], options: null,
      //     ),
      //   ],
      // ),
    );
  }
}

class ChatBot extends State<HomePage>{
  late final TextEditingController _textController;
  final List<String> _messages = [];

  @override
  void initState(){
    super.initState();
    _textController = TextEditingController();
  }

  @override
  void dispose(){
    _textController.dispose();
    super.dispose();
  }

  void handleSubmitted(String text){
    _textController.clear();
    setState(() {
      _messages.insert(0, text);
    });
    sendUserMessageToChatBot(text);
  }

  void sendUserMessageToChatBot (String userMessage) async{
    //Chat bot service API endpoint URL
    final apiUrl = '';

    try {
      final response = await http.post(Uri.parse(apiUrl), body: {'message': userMessage});
      final chatBotResponse = jsonDecode(response.body);

      setState(() {
        _messages.insert(0, chatBotResponse['message']);
      });
    } catch(e){
      print('Error sending message to chat bot: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat bot'),
        actions: [
          IconButton(
            icon: const Icon(Icons.android),
            onPressed: (){
              //handle chat bot icon press
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: true,
              itemCount: _messages.length,
              itemBuilder: (BuildContext context, int index){
                final message = _messages[index];
                return ListTile(
                  title: Text(message),
                );
              },
            ),
          ),
          TextField(
            controller: _textController,
            decoration: const InputDecoration(
              hintText: 'Send a message',
            ),
            onSubmitted: handleSubmitted,
          ),
        ],
      ),
    );
  }
}
