import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:loading_animation_widget/loading_animation_widget.dart';

import 'app_bar.dart';
import 'configs.dart';
import 'homepage.dart';

class LeaderboardPage extends StatefulWidget {
  @override
  _LeaderboardPageState createState() => _LeaderboardPageState();
}

class _LeaderboardPageState extends State<LeaderboardPage> {
  List<Leaderboard> leaderboardData = [];

  @override
  void initState() {
    super.initState();
    _fetchLeaderboardData();
  }
  late Color cl;
  String UserId='yazaz2000';


  Future<void> _fetchLeaderboardData() async {
    final response = await http.get(Uri.parse(localhost+'/donation'));
    if (response.statusCode == 200) {
      setState(() {
        List<dynamic> leaderboard  = jsonDecode(response.body) as List;
        for(var item in leaderboard){
          var id=item['_id'];
          var amount=item['totalAmount'].toString();
          var points=item['points'].toString();
          Color c=Colors.white;
          if(id==UserId){
            c=Colors.deepOrange;
          }
          Leaderboard l=Leaderboard(id, amount, points, c);
          leaderboardData.add(l);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(title:'Leaderboard',leadingIcon:IconButton(
          icon: Icon(Icons.home),
          iconSize: 40,
          color: Colors.deepOrange,
          onPressed:(){
            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>
                HomePage()
            ));
          },
        )),
        body: leaderboardData.isEmpty
            ? Center(
        child: LoadingAnimationWidget.staggeredDotsWave(
        color: Colors.deepOrange,
          size: 100,
         ),
        )
        :SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(color: Colors.white),

            child: DataTable(

              columnSpacing: Checkbox.width,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(25),
                  border: Border.all(color: Colors.deepOrange)),

              columns: [
                DataColumn(
                  label: Text('Rank',
                  style: TextStyle(color: Colors.deepOrange,fontWeight: FontWeight.bold),),
                ),
                DataColumn(
                  label: Text('UserID',
                      style: TextStyle(color: Colors.deepOrange,fontWeight: FontWeight.bold)),
                ),
                DataColumn(
                  label: Text('Total Donation',
                      style: TextStyle(color: Colors.deepOrange,fontWeight: FontWeight.bold)),
                ),
                DataColumn(
                  label: Text('Points',
                      style: TextStyle(color: Colors.deepOrange,fontWeight: FontWeight.bold)),
                ),
              ],
              rows: List<DataRow>.generate(
                leaderboardData.length,
                    (int index) => DataRow(

                      color: MaterialStateColor.resolveWith((states) {
                        if (states.contains(MaterialState.selected)) {
                          return Colors.grey.withOpacity(0.5);
                        }
                        if (states.contains(MaterialState.hovered)) {
                          return Colors.grey.withOpacity(0.2);
                        }
                        return leaderboardData[index].col.withOpacity(0.2);
                      }),
                  cells: <DataCell>[
                    DataCell(Text((index + 1).toString())),
                    DataCell(Text(leaderboardData[index].id)),
                    DataCell(Text(leaderboardData[index].amount.toString())),
                    DataCell(Text(leaderboardData[index].points.toString())),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
class Leaderboard{
  String id;
  String amount;
  String points;
  Color col;
  Leaderboard(this.id,this.amount,this.points,this.col);
}
