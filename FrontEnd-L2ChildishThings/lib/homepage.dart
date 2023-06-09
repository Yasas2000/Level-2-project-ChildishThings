import 'dart:async';
import 'dart:convert';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:frontend/bottom_navbar.dart';
import 'package:frontend/configs.dart';
import 'package:frontend/donation_form.dart';
import 'package:frontend/feedbackpage.dart';
import 'package:frontend/leaderboard.dart';
import 'package:frontend/login_state.dart';
import 'package:frontend/loginscreen.dart';
import 'package:frontend/notifications.dart';
import 'package:frontend/selection.dart';
import 'package:frontend/signup_screen.dart';
import 'package:frontend/type.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'gallery.dart';

/**
 * This the home page widget
 */

class HomePage extends StatefulWidget {
  const HomePage({super.key});


  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>{
  // ignore: non_constant_identifier_names
  Timer? _timer;

  int _selectedIndex = 0;
  int _imageSelectedIndex = 0;
  int _appBarSelectedIndex = 0;
  final PageController _imagePageController = PageController();
  final PageController _appBarPageController = PageController();

  bool _isChatWindowVisible = false;
  bool _isButtonVisible = true;
  late Offset _buttonPosition;


  void _handleDrag (DragUpdateDetails details){
    setState(() {
      _buttonPosition = Offset(
        _buttonPosition.dx + details.delta.dx,
        _buttonPosition.dy + details.delta.dy,
      );
    });
  }

  void _handleDragEnd (DragEndDetails details){
    setState(() {
      _isButtonVisible = true;
    });
  }

  int _notificationsCount = 0;


  @override
  initState()   {
    super.initState();
    _loadNotificationsCount();
    _startTimer();
    _buttonPosition = const Offset(16, 16);
  }
  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      setState(() {
        if (_selectedIndex < 7) {
          _selectedIndex++;
        } else {
          _selectedIndex = 0;
        }
        _imageSelectedIndex = _selectedIndex;
        _imagePageController.animateToPage(
          _selectedIndex,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInExpo,
        );
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _imagePageController.dispose();
    _appBarPageController.dispose();
    super.dispose();
  }

  void _onImagePageChanged(int index) {
    setState(() {
      _imageSelectedIndex = index;
    });
  }

  void _onAppBarTapped(int index) {
    setState(() {
      _appBarSelectedIndex = index;
    });
  }

  void _onDotTapped(double index) {
    final int pageIndex = index.round();
    setState(() {
      _imageSelectedIndex = pageIndex;
      _imagePageController.animateToPage(
        pageIndex,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }

  void _toggleChatWindow(){
    setState(() {
      _isChatWindowVisible = !_isChatWindowVisible;
    });
  }

  Future<void> _fetchNotificationsCount() async {
    final loginState=Provider.of<LoginState>(context,listen: false);
    final userId=loginState.id;
    if(userId!='null'){
      final url = Uri.parse(localhost+'/notification/count/$userId');
      final response = await http.get(url);
      final data = jsonDecode(response.body);
      print(data['count']);
      setState(() {
        _notificationsCount = data['count'];
      });
    }


  }
  Future<void> _loadNotificationsCount() async {
    await _fetchNotificationsCount();
  }

  void _onItemTapped(int index) {
    setState(() {
      //_SelectIndex = index;

    });
  }

  @override
  Widget build (BuildContext context){

    final loginState=Provider.of<LoginState>(context);
    // return  Consumer<LoginState>(
    //     builder: (context, loginState, _) async {
    //       final userId = loginState.id;
    //       if (userId.isNotEmpty) {
    //         await _fetchNotificationsCount(userId);
    //       }
    //     }
    // )
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              toolbarHeight: 100,
              backgroundColor: Colors.deepOrange,
              elevation: 5,

              automaticallyImplyLeading: false,
              leading: IconButton(
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) =>
                          NotificationsPage()
                      ));
                },
                icon: Stack(
                  children: [
                    Icon(
                      Icons.notifications, size: 40, color: Colors.white,),
                    if ( _notificationsCount > 0)
                      Positioned(
                        top: 1,
                        right: 2,
                        child: Container(
                          padding: EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(25),
                          ),
                          constraints: BoxConstraints(
                            minWidth: 16,
                            minHeight: 16,
                          ),
                          child: Text(
                            '$_notificationsCount',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.deepOrange,
                            ),
                          ),
                        ),
                      ),
                          ],
                ),),
              //Image.asset('assets/images/logo.png', height: 50,color: Colors.black),,
              title: SizedBox(

                height: 100,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Image.asset('assets/logoblack.png', height: 100,
                        width: 400,
                        color: Colors.white,
                        scale: 0.5,),
                    ),
                  ],
                ),
              ),
              actions: [
                Padding(
                  padding: EdgeInsets.all(15),
                  child: IconButton(
                    icon: const Icon(
                      Icons.menu, size: 40, color: Colors.white,),
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return  SlidingBar(
                              username: loginState.username,
                              userImageURL: 'https://imgs.search.brave.com/aaP9RIfujXe4q-op1nz8rpwCLTjosRqT-xyZLL8TdSw/rs:fit:706:225:1/g:ce/aHR0cHM6Ly90c2Uy/Lm1tLmJpbmcubmV0/L3RoP2lkPU9JUC5r/Vngwb2hTSm9zWVNE/QjlRWHIxUG9RSGFF/LSZwaWQ9QXBp',
                              loginState: loginState,

                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
            body: Column(
              children: [
                SizedBox(
                  height: 400,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.elliptical(200, 50),
                      bottomRight: Radius.elliptical(200, 50),
                    ),
                    child: PageView(
                      controller: _imagePageController,
                      onPageChanged: _onImagePageChanged,
                      children: [
                        GestureDetector(
                          onTap: () {
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) => MainPhotoGalleryScreen(),
                            //     ),
                            // );
                          },
                          child: Image.asset(
                            'assets/h3.jpeg',
                            fit: BoxFit.cover,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) => MainPhotoGalleryScreen(),
                            //     ),
                            // );
                          },
                          child: Image.asset(
                            'assets/1.jpg',
                            fit: BoxFit.cover,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) => MainPhotoGalleryScreen(),
                            //     ),
                            // );
                          },
                          child: Image.asset(
                            'assets/h1.jpeg',
                            fit: BoxFit.cover,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) => MainPhotoGalleryScreen(),
                            //     ),
                            // );
                          },
                          child: Image.asset(
                            'assets/2.jpg',
                            fit: BoxFit.cover,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) => MainPhotoGalleryScreen(),
                            //     ),
                            // );
                          },
                          child: Image.asset(
                            'assets/h2.jpeg',
                            fit: BoxFit.cover,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) => MainPhotoGalleryScreen(),
                            //     ),
                            // );
                          },
                          child: Image.asset(
                            'assets/3.jpg',
                            fit: BoxFit.cover,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) => MainPhotoGalleryScreen(),
                            //     ),
                            // );
                          },
                          child: Image.asset(
                            'assets/h4.jpeg',
                            fit: BoxFit.cover,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) => MainPhotoGalleryScreen(),
                            //     ),
                            // );
                          },
                          child: Image.asset(
                            'assets/h5.jpeg',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                DotsIndicator(
                  dotsCount: 8,
                  position: _imageSelectedIndex.toDouble(),
                  decorator: DotsDecorator(
                    activeColor: Colors.orangeAccent,
                    color: Colors.grey,
                    size: const Size.square(6.0),
                    activeSize: const Size(12.0, 6.0),
                    activeShape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onTap: _onDotTapped,
                ),

                //Text part
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        SizedBox(height: 20),
                        Text(
                          'Welcome to PhotoBoothMe',
                          style: TextStyle(
                            color: Colors.deepOrangeAccent,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Your one-step solution for all photography needs',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(height: 20),
                        Text(
                          'Empower your impact:',
                          style: TextStyle(
                            color: Colors.deepOrangeAccent,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Seamlessly donate or request donations, harnessing the power of our intuitive app',
                          style: TextStyle(
                            color: Colors.blueGrey,
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            bottomNavigationBar: BottomNavbar(),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                setState(() {
                  _isChatWindowVisible = !_isChatWindowVisible;
                });
              },
              child: const CircleAvatar(
                backgroundColor: Colors.transparent,
                backgroundImage: AssetImage('assets/chat.png'),
              ),
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,


    );

  }
}

class SlidingBar extends StatelessWidget {
  final String username;
  final String userImageURL;
  final LoginState loginState;

  const SlidingBar({
    super.key, required this.username, required this.userImageURL , required this.loginState
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Colors.deepOrange,
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
            onTap: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>
                  type()
              ));
            },
          ),
          ListTile(
            title: const Text('Photo Gallery'),
            onTap: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>
                  ImageGallery()
              ));
            },
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
            title: Text(loginState.isLoggedIn ?'Logout':'Login'),
            onTap: (){
              if (loginState.isLoggedIn) {

                loginState.logout();
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                        (route) => false);

              } else {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => LoginScreen(),
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}

class DraggableFloatWidget extends StatefulWidget {
  final Widget child;
  final Function(DragUpdateDetails) onDragUpdate;
  final Function(DragEndDetails) onDragEnd;

  const DraggableFloatWidget({
    required this.child,
    required this.onDragUpdate,
    required this.onDragEnd,
    Key? key,
  }) : super(key: key);

  @override
  _DraggableFloatWidgetState createState() => _DraggableFloatWidgetState();
}

class _DraggableFloatWidgetState extends State<DraggableFloatWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: widget.onDragUpdate,
      onPanEnd: widget.onDragEnd,
      child: widget.child,
    );
  }
}

//Chat window
class ChatWindow extends StatefulWidget {
  const ChatWindow({Key? key}) : super(key: key);

  @override
  _ChatWindowState createState() => _ChatWindowState();
}

class _ChatWindowState extends State<ChatWindow> {

  late final TextEditingController _textController;
  final List<String> _messages = []; //store message in the chat history

  @override
  void initState(){ //This method is called when the widget is inserted into the widget tree for the first time
    super.initState();
    _textController = TextEditingController();
  }

  @override
  void dispose(){ //This method is called when the widget is removed from the widget tree
    _textController.dispose();
    super.dispose();
  }

  //This method takes a message as an argument, add in to the _message list
  void handleSubmitted(String text){
    _textController.clear(); //Clear the text field
    setState(() {
      _messages.insert(0, text);
    });
    sendUserMessageToChatBot(text); //send the message to the chatBot
  }

  void sendUserMessageToChatBot (String userMessage) async{
    //Chat bot service API endpoint URL
    const apiUrl = '';

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'message': userMessage}),
      ); //Sends user's message to the chatBot API endpoint via HTTP POST request
      final chatBotResponse = jsonDecode(response.body);

      setState(() {
        _messages.insert(0, chatBotResponse['message']); //add chat bots response to the chat history
      });
    } catch(e){
      if (kDebugMode) {
        print('Error sending message to chat bot: $e');
      }
    }
  }



  @override
  Widget build(BuildContext context){
    return Container(
      //appearence of chatbot
      height: 200,
      width: double.infinity,
      color: Colors.white,
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: true,
              itemCount: _messages.length,
              itemBuilder: (BuildContext context, int index) {
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
              hintText: 'Send your question...',
            ),
            onSubmitted: handleSubmitted,
          )
        ],
      ),
    );
  }
}
