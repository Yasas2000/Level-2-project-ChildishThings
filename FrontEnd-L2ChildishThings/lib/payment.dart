import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/src/form_builder.dart';
import 'package:frontend/app_bar.dart';
import 'package:frontend/configs.dart';
import 'package:payhere_mobilesdk_flutter/payhere_mobilesdk_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'donation_form.dart';
import 'login_state.dart';

/**
 * This is the page for payment widget
 */

class Payment extends StatelessWidget {

  final Details d;
  Payment(this.d);

  Future<void> sendEmail(String recipient, String pid,String amount,String date) async {
    var url = Uri.parse(localhost+'/send-email');
    var response = await http.post(url, body: {
      'recipient': recipient,
      'pid': pid,
      'amount': amount,
      'date':date

    });
    if (response.statusCode == 200) {
      print('Email sent successfully!');
    } else {
      print('Failed to send email. Error code: ${response.statusCode}');
    }
  }
  Future<void> sendNotification(var pid,String uid) async {
    try{
      var url=Uri.parse(localhost+'/notification/pushNotifications');
      final http.Response response;
      String amount=d.amount as String;
      response=await http.post(url,
      body: {
        'uid':uid,
        'title':'Payment $pid Successful',
        'desc':'Thank you for the donation. $amount recieved '
      }
      );

      if(response.statusCode==200){
        print(response.body.toString());
      }
      else{
        print('failed');
      }
    }catch(error){
      print(error);
      return;
    }
  }
  Future<void> sendNotificationtoAdmin(var pid,String uid) async {
    try{
      var url=Uri.parse(localhost+'/notification/pushNotifications');
      final http.Response response;
      String amount=d.amount as String;
      response=await http.post(url,
          body: {
            'uid':'admin',
            'title':'Payment $pid Recieved',
            'desc':'Donation of $amount recieved from $uid '
          }
      );

      if(response.statusCode==200){
        print(response.body.toString());
      }
      else{
        print('failed');
      }
    }catch(error){
      print(error);
      return;
    }
  }

  Future<void> saveDonation(var pid,String userId) async {
    try {
      var url = localhost+'/donation';
      double amount=double.parse(d.amount as String);
      final response = await http.post(
        Uri.parse(url),
        body: {
          'id': userId,
          'pid': pid,
          'fname': d.fname,
          'lname': d.lname,
          'email': d.email,
          'amount':d.amount,
          'method': d.method,
        },
      );

      if (response.statusCode == 200) {
        print('${response.body}');
        print('${response.statusCode}');
        await sendEmail(d.email,pid,d.amount,DateTime.now().toString() );
        //await sendPaymentConfirmationEmail(d.email, d.amount);
        if(userId!=null){
          await sendNotification(pid, userId);
        }
        await sendNotificationtoAdmin(pid, userId);
      } else {
        print('failed');
        return;
      }
    } catch (e) {
      print("failed + $e");
      return;
    }
  }

  void startRecuurantPayment(BuildContext context, String userId) async {
    Map paymentObject = {
      "sandbox": true,
      "merchant_id": "1222157",
      "merchant_secret": "MTM4MTA5NzM0MTQ4ODE2MjYzOTEwNjU5MTA5ODUyNTM2OTAzMjEw",
      //"authorize": true,
      "notify_url": "https://ent13zfovoz7d.x.pipedream.net/",
      "recurrence": d.period! + ' Month', // Recurring payment frequency
      "duration": d.duration! + ' Year', //Recurring period
      "items": d.purpose,
      "currency": "LKR",
      "amount": d.amount,
      "first_name": d.fname,
      "last_name": d.lname,
      "email": d.email,
      "phone": "0771234567",
      "address": "No.1, Galle Road",
      "city": "Colombo",
      "country": "Sri Lanka",
    };

    PayHere.startPayment(paymentObject, (paymentId) async {
      print("Recurring Payment Success. Payment Id: $paymentId");
      await saveDonation(paymentId,userId);

      showAlert(context, "Payment Success!", "Payment Id: $paymentId");
      Navigator.of(context).push(MaterialPageRoute(builder: (context) {
        return DonationForm();
      }));
    }, (error) {
      print("Recurring Payment Failed. Error: $error");
    }, () {
      print("Recurring Payment Dismissed");
    });
  }

  void startOneTimepayment(BuildContext context,String userId) async {
    Map paymentObject = {
      "sandbox": true,
      "merchant_id": "1222157",
      "merchant_secret": "MTM4MTA5NzM0MTQ4ODE2MjYzOTEwNjU5MTA5ODUyNTM2OTAzMjEw",
      //"authorize": true,
      "notify_url": "https://ent13zfovoz7d.x.pipedream.net/",
      "order_id": "ItemNo12345",
      "items": d.purpose,
      "currency": "LKR",
      "first_name": d.fname,
      "last_name": d.lname,
      "email": d.email,
      "phone": "0771234567",
      "address": "No.1, Galle Road",
      "city": "Colombo",
      "country": "Sri Lanka",
      "amount": d.amount
    };
    PayHere.startPayment(paymentObject, (paymentId) async {
      print("One Time Payment Success. Payment Id: $paymentId");

      await saveDonation(paymentId,userId);

      showAlert(context, "Payment Success!", "Payment Id: $paymentId");
      Navigator.of(context).push(MaterialPageRoute(builder: (context) {
        return DonationForm();
      }));
    }, (error) {
      print("One Time Payment Failed. Error: $error");
      showAlert(context, "Payment Failed", "$error");
    }, () {
      print("One Time Payment Dismissed");
      showAlert(context, "Payment Dismissed", "");
    });
  }

  void showAlert(BuildContext context, String title, String msg) {
    // set up the button
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(msg),
      actions: [okButton],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final loginState=Provider.of<LoginState>(context);
    return Scaffold(
      appBar: CustomAppBar(title: "Gateway",leadingIcon: IconButton(
          icon: Icon(Icons.arrow_back_ios_outlined,color: Colors.deepOrange,size: 40,),
      onPressed:(){
        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>
            DonationForm()
        ));
      },
    )),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Center(
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(
                    color: Colors.deepOrange,
                    style: BorderStyle.solid,
                    strokeAlign: BorderSide.strokeAlignCenter),
                borderRadius: BorderRadius.circular(25),
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [ Colors.orange,Color(0xFFFF6F00),])),
            child: Container(
              //margin: EdgeInsets.only(bottom: 200),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Text(
                          ' Donation Details ',
                          style: TextStyle(
                              fontSize: 25.0,
                              wordSpacing: 10,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),

                    ],
                  ),
                  SizedBox(
                    height: 100,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.values[5],
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'Name      :',
                            style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                          Text(
                            'Amount      :',
                            style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                          Text(
                            'Payment Type      :',
                            style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(d.fname + ' ' + d.lname, style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.white),
                          ),
                          Text(d.amount.toString() + 'lkr',style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.white),),
                          Text(d.method,style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.white),),
                        ],
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 90),
                    child: ElevatedButton(
                      onPressed: () {
                        if (d.method == "One time Payment") {
                          startOneTimepayment(context,loginState.id);
                        } else if (d.method == "Recurrant") {
                          startRecuurantPayment(context, loginState.id);
                        } else {}
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0)),
                        // primary: Color(0xFF2196F3),
                        backgroundColor: Colors.deepOrange,
                        elevation: 20,

                      ),
                      child: Container(
                        margin: EdgeInsets.all(8.0),
                        child: Text(
                          'Proceed',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'halter',
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
