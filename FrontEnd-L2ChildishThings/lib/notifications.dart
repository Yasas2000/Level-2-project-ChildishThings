import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:frontend/configs.dart';
import 'package:http/http.dart' as http;
import 'package:frontend/app_bar.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'donation_form.dart';
import 'homepage.dart';

/**
 * This is the notification page widget
 */

class NotificationsPage extends StatefulWidget {
  @override
  _NotificationsPageState createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {

  List<Notification> _notifications = [];
  String userId="yazaz2000";

  var urlDeletion=Uri.parse(localhost+'/delete');

  Future<List<Notification>> getNotification() async{
    _notifications.clear();
    var urlDeletes=Uri.parse(localhost+'/delete/$userId');
    var url=Uri.parse(localhost+'/notification/viewnotifications/$userId');
    late http.Response response;
    late http.Response responseDelete;

    try{
      responseDelete=await http.get(urlDeletes);
      print('Success');
      response = await http.get(url);
      if (response.statusCode == 200) {

        List notification=jsonDecode(response.body) as List;
        print(notification);
        //List not=notifi as List;
        print(notification[0]['title']);
        for(var item in notification) {
          var title = item['title'];
          var desc = item['desc'];
          var date = item['date'];
          var oid = item['_id'];
          var id = item['uid'];
          if(userId!="null"){
            updateStatus(oid,userId);
          }
          Notification nots = Notification(title, date, desc, oid, id);
          _notifications.add(nots);
          print(_notifications[0].title);

          if (responseDelete.statusCode == 200) {
            List deletes = jsonDecode(responseDelete.body) as List;
            for (var item in deletes) {
              var oid = item['oid'];
              _notifications.removeWhere((element) => element.oid == oid);
            }
          }
        }

      } else {
        return Future.error('Something wrong,${response.statusCode}');
      }

    }catch(e){
      return Future.error(e.toString());

    }
    return _notifications;
  }
  Future<void> updateStatus(String id,String uid)async {
    late http.Response response2;
    var url=Uri.parse(localhost+'/notification/read/$id,$uid');

    response2=await http.put(url);
    print(response2.body.toString());
  }
  Future<void> deleteNotification(String id,String uid) async {
    try{
      if(uid==userId){
        var url = Uri.parse(localhost+'/notification/delete-notification/$id');
        var response = await http.get(url);

        if (response.statusCode == 200) {
          setState(() {
            _notifications.removeWhere((n) => n.oid == id);
          });
        } else {
          throw Exception('Failed to delete notification');
        }

      }else{

        var response=await http.post(urlDeletion,body: {'uid':userId,'oid':id});
        if(response.statusCode==200){
          print(response.body);
        }
        else{
          print(response.statusCode);
        }
        setState(() {

        });
      }

    }catch(error){
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(title: 'Notifications',leadingIcon:IconButton(
          icon: Icon(Icons.home),
          iconSize: 40,
          color: Colors.deepOrange,
          onPressed:(){
            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>
                HomePage()
            ));
          },
        )),
        body: FutureBuilder(
          future: getNotification(),
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
                return Text(' ');
              }else{
                return ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context,int index){
                      return Card(
                        shape: OutlineInputBorder(borderRadius: BorderRadius.circular(25),borderSide:BorderSide(color: Colors.deepOrange)),
                        elevation: 8.0,
                        //margin: new EdgeInsets.symmetric(horizontal: 10.0,vertical: 6.0),
                        child: Container(

                          decoration: BoxDecoration(color: Colors.white,borderRadius:BorderRadius.circular(25)  ),
                          child:
                            ListTile(

                              //contentPadding:EdgeInsets.symmetric(horizontal: 20.0,vertical: 10.0) ,
                              leading: Container(
                                padding: EdgeInsets.only(right: 12.0),
                                decoration: new BoxDecoration(
                                    border: new Border(
                                        right: new BorderSide(width: 1.0, color: Colors.deepOrange))),
                                child: CircleAvatar(
                                  backgroundColor: Colors.deepOrange,
                                  child: Text(snapshot.data[index].title[0],style: TextStyle(fontSize: 30.0,color: Colors.white),textAlign: TextAlign.center),
                                ),
                              ),

                              title: Text(snapshot.data[index].title,style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                              subtitle: Column(

                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(snapshot.data[index].desc),
                                  Text(snapshot.data[index].date),
                                ],
                              ),
                              trailing: IconButton(onPressed:() async{
                              await deleteNotification(snapshot.data[index].oid,snapshot.data[index].id);
                              }, icon:Icon(Icons.delete_outline,color: Colors.deepOrange,)),
                              shape: OutlineInputBorder(borderRadius:BorderRadius.all(Radius.circular(25))),
                              hoverColor: Colors.deepOrange,
                              minVerticalPadding: 20,



                            ),
                        ),
                      );
                    });
              }
            }
          },
        )

      ),
    );
  }
}

class Notification {
  String title;
  String date;
  String desc;
  String oid;
  String id;
  Notification(this.title,this.date,this.desc,this.oid,this.id);
}