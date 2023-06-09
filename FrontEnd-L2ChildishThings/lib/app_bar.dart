import 'dart:convert';
import 'package:badges/badges.dart' as badges;
import "package:flutter/material.dart";
import 'package:frontend/configs.dart';
import 'package:frontend/notifications.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'feedbackpage.dart';
import 'home.dart';
import 'login_state.dart';
enum MenuItem{
  item1,
  item2,
  item3,
  item4,
}
/**
 * This is app bar widget
 */

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;

  final Widget? leadingIcon;
  const CustomAppBar({Key? key,required this.title, this.leadingIcon,}) :super(key: key);


  @override
  State<CustomAppBar> createState() => _CustomAppBarState();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(60.0);
}

class _CustomAppBarState extends State<CustomAppBar> {
  int _notificationsCount = 0;
  @override
  initState()   {
    super.initState();
    _loadNotificationsCount();
  }

  Future<void> _fetchNotificationsCount() async {
    final loginState=Provider.of<LoginState>(context,listen: false);
    String userId=loginState.id;
    final url = Uri.parse(localhost+'/notification/count/$userId');
    final response = await http.get(url);
    final data = jsonDecode(response.body);
    setState(() {
      _notificationsCount = data['count'];
    });

  }
  Future<void> _loadNotificationsCount() async {
    await _fetchNotificationsCount();
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      surfaceTintColor: Colors.deepOrange,
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      automaticallyImplyLeading: false,
      title: Text(widget.title,style: TextStyle(color: Colors.deepOrange),),
      leading:widget.leadingIcon ,

      actions: [
        badges.Badge(
          position: badges.BadgePosition.topEnd(top: 5, end: 0),
          showBadge: (_notificationsCount>0),
          badgeContent: Text('$_notificationsCount',style: TextStyle(color: Colors.white),),
          badgeAnimation: badges.BadgeAnimation.rotation(
            animationDuration: Duration(seconds: 1),
            colorChangeAnimationDuration: Duration(seconds: 1),
            loopAnimation: false,
            curve: Curves.fastOutSlowIn,
            colorChangeAnimationCurve: Curves.easeInCubic,
          ),
          badgeStyle: badges.BadgeStyle(
            shape: badges.BadgeShape.circle,
            badgeColor: Colors.deepOrange,
            borderRadius: BorderRadius.circular(4),

            elevation: 0,
          ),

          child: IconButton(
            icon: Icon(Icons.notifications,color: Colors.deepOrange,size: 40,),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context){
                    return NotificationsPage();
                  }));
            },

          ),
        ),

        PopupMenuButton<MenuItem>(
            icon: Icon(Icons.drag_indicator,color: Colors.deepOrange,),
            iconSize: 40,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),side: BorderSide(color: Colors.deepOrange)),
            color: Colors.white,
            onSelected: (value){
              if(value==MenuItem.item1){
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context)=> Homepage()));
              }else if(value==MenuItem.item2){

              }else if(value==MenuItem.item3){
                Navigator.push(context, MaterialPageRoute(builder: (BuildContext context){
                  return FeedbackBar();
                }));

              }

            },

            itemBuilder: (context)=>[

              PopupMenuItem(
                value: MenuItem.item1,


                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [

                    Container(
                      padding: EdgeInsets.only(right: 12.0),
                      decoration: new BoxDecoration(
                          border: new Border(
                              right: new BorderSide(width: 1.0, color: Colors.deepOrange))),
                      child:Icon(Icons.settings,color: Colors.deepOrange,),
                    ),
                    Text(' Settings',style: TextStyle(color: Colors.deepOrange),),

                  ],
                ),
              ),
              PopupMenuItem(

                  value: MenuItem.item2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.only(right: 12.0),
                        decoration: new BoxDecoration(
                            border: new Border(
                                right: new BorderSide(width: 1.0, color: Colors.deepOrange))),
                        child:Icon(Icons.help,color: Colors.deepOrange,),
                      ),
                      Text(' Help amd Support',style: TextStyle(color: Colors.deepOrange)),
                    ],
                  )),
              PopupMenuItem(

                  value: MenuItem.item3,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.only(right: 12.0),
                        decoration: new BoxDecoration(
                            border: new Border(
                                right: new BorderSide(width: 1.0, color: Colors.deepOrange))),
                        child:Icon(Icons.feedback,color: Colors.deepOrange,),
                      ),
                      Text(' Feedback',style: TextStyle(color: Colors.deepOrange,)),
                    ],
                  )
              )
            ])
      ],
    );
  }

}







