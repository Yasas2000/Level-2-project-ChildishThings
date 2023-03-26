import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'app_bar.dart';
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

  Future<void> _fetchLeaderboardData() async {
    final response = await http.get(Uri.parse('http://192.168.1.6:3000/leaderboard'));
    if (response.statusCode == 200) {
      setState(() {
        List<dynamic> leaderbrd  = jsonDecode(response.body) as List;
        for(var item in leaderbrd){
          var id=item['_id'];
          var amount=item['totalAmount'].toString();
          var points=item['points'].toString();
          Color c=Colors.white;
          if(id=='yazaz2000'){
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
          child: CircularProgressIndicator(),
        )
        //     : ListView.builder(
        //   itemCount: leaderboardData.length,
        //   itemBuilder: (BuildContext context, int index) {
        //     return Padding(
        //       padding: const EdgeInsets.only(left: 30,right: 30),
        //       child: Card(
        //         shape: OutlineInputBorder(borderRadius: BorderRadius.circular(25),borderSide:BorderSide(color: Colors.deepOrange)),
        //         elevation: 8.0,
        //         child: ListTile(
        //           leading: Container(
        //             padding: EdgeInsets.only(right: 12.0),
        //             decoration: new BoxDecoration(
        //                 border: new Border(
        //                     right: new BorderSide(width: 1.0, color: Colors.deepOrange))),
        //             child: CircleAvatar(
        //               backgroundImage: NetworkImage("" ),
        //             ),
        //           ),
        //           title: Text('${leaderboardData[index]['_id']}'),
        //           subtitle: Row(
        //             children: [
        //               Text('Total Donation: ${leaderboardData[index]['totalAmount']}'),
        //               SizedBox(width: 10,),
        //               Text('Points: ${leaderboardData[index]['points']}')
        //             ],
        //           ),
        //         ),
        //       ),
        //     );
        //   },
        // ),
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
