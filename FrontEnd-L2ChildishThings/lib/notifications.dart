import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mypart/app_bar.dart';

import 'donation_form.dart';

class NotificationsPage extends StatefulWidget {
  @override
  _NotificationsPageState createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {

  List<Notification> _notifications = [];
 // @override
  // void initState() {
  //   super.initState();
  //   //_fetchNotifications();
  // }
  var url3=Uri.parse('http://192.168.1.6:3000/deletes/ymeka2000');
  var url4=Uri.parse('http://192.168.1.6:3000/delete');
  String all='null';
  Future<List<Notification>> getNotifi() async{
    _notifications.clear();
    var url=Uri.parse('http://192.168.1.6:3000/notifications/ymeka2000');
    var url2=Uri.parse('http://192.168.1.6:3000/commonnots/$all');
    late http.Response rp;
    late http.Response response;
    late http.Response response1;

    try{
      rp=await http.get(url2);
      response1=await http.get(url3);
      print('Success');

      if(rp.statusCode==200){
        List notification=jsonDecode(rp.body) as List;
        for(var item in notification){
          var title=item['title'];
          var desc=item['desc'];
          var date=item['date'];
          var oid=item['_id'];
          var id=item['uid'];
          Notification nots=Notification(title,date,desc,oid,id);
          _notifications.add(nots);
          print(_notifications[0].oid);
        }
        if(response1.statusCode==200){
          List deletes=jsonDecode(response1.body) as List;
          for(var item in deletes){
            var oid=item['oid'];
            _notifications.removeWhere((element) => element.oid==oid);
          }
        }
      }
      else{

        return Future.error('Something wrong,${rp.statusCode}');
      }

    }catch(e){
      return Future.error(e.toString());

    }


    try{
      response = await http.get(url);
      if (response.statusCode == 200) {

        List notifi=jsonDecode(response.body) as List;
        print(notifi);
        //List not=notifi as List;
        print(notifi[0]['title']);
        for(var item in notifi){
          var title=item['title'];
          var desc=item['desc'];
          var date=item['date'];
          var oid=item['_id'];
          var id =item['uid'];
          Notification nots=Notification(title,date,desc,oid,id);
          _notifications.add(nots);
          print(_notifications[0].title);
        }

      } else {
        return Future.error('Something wrong,${response.statusCode}');
      }

    }catch(e){
      return Future.error(e.toString());

    }
    return _notifications;
  }

  Future<void> deleteNotification(String id,String uid) async {
    if(uid=='ymeka2000'){
      var url = Uri.parse('http://192.168.1.6:3000/delete-notification/$id');
      var response = await http.get(url);

      if (response.statusCode == 200) {
        setState(() async {
          _notifications.removeWhere((n) => n.oid == id);




        });
      } else {
        throw Exception('Failed to delete notification');
      }

    }else{

      final response3=await http.post(url4,body: {'uid':'ymeka2000','oid':id});
      if(response3.statusCode==200){
        print(response3.body);
      }
      else{
        print(response3.statusCode);
      }
      setState(() {

      });
    }

  }

  // _fetchNotifications() async {
  //   var url=Uri.parse('http://10.0.2.2:3000/notifications/ymeka200');
  //   late http.Response response;
  //
  //   try{
  //     response = await http.get(url);
  //     if (response.statusCode == 200) {
  //       print('Success');
  //       List notifi=jsonDecode(response.body) as List;
  //       print(notifi);
  //       //List not=notifi as List;
  //       print(notifi[0]['_not']);
  //       for(var item in notifi){
  //         var not=item['_not'];
  //         var date=item['_date'];
  //         Notification nots=Notification(not,date);
  //         _notifications.add(nots);
  //         print(_notifications[0].not);
  //       }
  //
  //     } else {
  //       throw Exception('Failed to load notifications');
  //     }
  //
  //   }catch(e){
  //     print(e);
  //
  //   }
  //
  // }

  @override
  Widget build(BuildContext context) {





    return Scaffold(
      appBar: CustomAppBar('Notifications',IconButton(
        icon: Icon(Icons.home),
        iconSize: 40,
        color: Colors.deepOrange,
        onPressed:(){
          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>
              DonationForm()
          ));
        },
      )),
      body: FutureBuilder(
        future: getNotifi(),
        builder: (BuildContext context,AsyncSnapshot snapshot){
          if(snapshot.connectionState==ConnectionState.waiting){
            return const Center(
              child: Text('Waiting'),
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
                                child: Text(snapshot.data[index].title[0],style: TextStyle(fontSize: 30.0,color: Colors.white),),
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