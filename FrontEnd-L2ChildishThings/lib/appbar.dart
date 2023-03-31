import 'dart:convert';
import "package:flutter/material.dart";
import 'package:http/http.dart' as http;

enum MenuItem {
  item1,
  item2,
  item3,
  item4,
}
//App bar

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;

  final Widget? leadingIcon;
  const CustomAppBar({
    Key? key,
    required this.title,
    this.leadingIcon,
  }) : super(key: key);

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(60.0);
}

class _CustomAppBarState extends State<CustomAppBar> {
  String id = 'ymeka2000';
  int _notificationsCount = 0;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      automaticallyImplyLeading: false,
      title: Text(
        widget.title,
        style: TextStyle(color: Colors.deepOrange),
      ),
      leading: widget.leadingIcon,
      actions: [
        PopupMenuButton<MenuItem>(
            icon: Icon(
              Icons.drag_indicator,
              color: Colors.deepOrange,
            ),
            iconSize: 40,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
                side: BorderSide(color: Colors.deepOrange)),
            color: Colors.white,
            onSelected: (value) {},
            itemBuilder: (context) => [
                  PopupMenuItem(
                    value: MenuItem.item1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.only(right: 12.0),
                          decoration: new BoxDecoration(
                              border: new Border(
                                  right: new BorderSide(
                                      width: 1.0, color: Colors.deepOrange))),
                          child: Icon(
                            Icons.settings,
                            color: Colors.deepOrange,
                          ),
                        ),
                        Text(
                          ' Settings',
                          style: TextStyle(color: Colors.deepOrange),
                        ),
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
                                    right: new BorderSide(
                                        width: 1.0, color: Colors.deepOrange))),
                            child: Icon(
                              Icons.help,
                              color: Colors.deepOrange,
                            ),
                          ),
                          Text(' Help amd Support',
                              style: TextStyle(color: Colors.deepOrange)),
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
                                    right: new BorderSide(
                                        width: 1.0, color: Colors.deepOrange))),
                            child: Icon(
                              Icons.feedback,
                              color: Colors.deepOrange,
                            ),
                          ),
                          Text(' Feedback',
                              style: TextStyle(
                                color: Colors.deepOrange,
                              )),
                        ],
                      ))
                ])
      ],
    );
  }
}
