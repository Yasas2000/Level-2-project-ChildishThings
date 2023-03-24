import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/app_bar.dart';
import 'package:payhere_mobilesdk_flutter/payhere_mobilesdk_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

import 'donation_form.dart';

class Payment extends StatelessWidget {
  var id = "yazaz2000";
  final Details d;
  Payment(this.d);
  Future<void> sendPaymentConfirmationEmail(String recipientEmail, String paymentAmount) async {
    final smtpServer = gmail('photoboothme499', 'PhotoboothMe499');

    final message = Message()
      ..from = Address('photoboothme499', 'PhotoboothMe')
      ..recipients.add(recipientEmail)
      ..subject = 'Payment Confirmation'
      ..text = 'Thank you for your payment of $paymentAmount.';

    try {
      final sendReport = await send(message, smtpServer);
      print('Message sent: ' + sendReport.toString());
    } catch (e) {
      print('Error occurred: $e');
    }
  }

  Future<void> forms(var pid) async {
    try {
      var url = 'http://192.168.142.133:3300/submit';
      final response = await http.post(
        Uri.parse(url),
        body: {
          'id': id,
          'paymentid': pid,
          'fname': d.fname,
          'lname': d.lname,
          'email': d.email,
          'amount': d.amount,
          'method': d.method,
        },
      );
      print('${response.body}');
      print('${response.statusCode}');
      if (response.statusCode == 200) {
        return;
      } else {}
    } catch (e) {
      print("failed");
    }
  }

  void startRecuurantPayment(BuildContext context) async {
    Map paymentObject = {
      "sandbox": true,
      "merchant_id": "1222157",
      "merchant_secret": "MTM4MTA5NzM0MTQ4ODE2MjYzOTEwNjU5MTA5ODUyNTM2OTAzMjEw",
      //"authorize": true,
      "notify_url": "https://ent13zfovoz7d.x.pipedream.net/",
      "recurrence": d.period, // Recurring payment frequency
      "duration": d.duration, //Recurring period
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

    PayHere.startPayment(paymentObject, (paymentId) {
      print("Recurring Payment Success. Payment Id: $paymentId");
    }, (error) {
      print("Recurring Payment Failed. Error: $error");
    }, () {
      print("Recurring Payment Dismissed");
    });
  }

  void startPreAprrovalPayment(BuildContext context) async {
    Map paymentObject = {
      "sandbox": true, // true if using Sandbox Merchant ID
      "preapprove": true, // Required
      "merchant_id": "1211149", // Replace your Merchant ID
      "notify_url": "http://sample.com/notify",
      "items": d.purpose,
      "currency": "LKR",
      "first_name": d.fname,
      "last_name": d.lname,
      "email": d.email,
      "phone": "0771234567",
      "address": "No.1, Galle Road",
      "city": "Colombo",
      "country": "Sri Lanka",
      "amount": d.amount // Optional. An amount to pass while pre-approving.
    };

    PayHere.startPayment(paymentObject, (paymentId) {
      print("Tokenization Payment Success. Payment Id: $paymentId");
    }, (error) {
      print("Tokenization Payment Failed. Error: $error");
    }, () {
      print("Tokenization Payment Dismissed");
    });
  }

  void savePaymentDetail(BuildContext context) {
    Map paymentObject = {
      "sandbox": true, // true if using Sandbox Merchant ID
      "authorize": true, // Required
      "merchant_id": "1222157", // Replace your Merchant ID
      "notify_url": "https://ent13zfovoz7d.x.pipedream.net/",
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

    PayHere.startPayment(paymentObject, (paymentId) {
      print("Hold-on-Card Payment Success.");
    }, (error) {
      print("Hold-on-Card Payment Failed. Error: $error");
    }, () {
      print("Hold-on-Card Payment Dismissed");
    });
  }

  void startOneTimepayment(BuildContext context) async {
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

      await forms(paymentId);
      await sendPaymentConfirmationEmail(d.email, d.amount);

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
    return Scaffold(
      appBar: CustomAppBar("Gateway",IconButton(
          icon: Icon(Icons.arrow_back),
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
                borderRadius: BorderRadius.circular(8),
                gradient: LinearGradient(
                    begin: AlignmentDirectional(3, 10),
                    colors: [Colors.deepOrange, Colors.orange])),
            child: Container(
              //margin: EdgeInsets.only(bottom: 200),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: 100,
                        height: 30,
                        child: ColoredBox(
                          color: Colors.deepOrange,
                        ),
                      ),
                      Text(
                        ' Donation Details ',
                        style: TextStyle(
                            fontSize: 25.0,
                            backgroundColor: Colors.white,
                            color: Colors.deepOrange),
                      ),
                      SizedBox(
                        width: 30,
                        height: 30,
                        child: ColoredBox(
                          color: Colors.deepOrange,
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 100,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'Name :',
                            style: TextStyle(
                                fontSize: 18.0,
                                decoration: TextDecoration.underline),
                          ),
                          Text(
                            'Amount :',
                            style: TextStyle(
                                fontSize: 18.0,
                                decoration: TextDecoration.underline),
                          ),
                          Text(
                            'Payment Type :',
                            style: TextStyle(
                                fontSize: 18.0,
                                decoration: TextDecoration.underline),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(d.fname + ' ' + d.lname),
                          Text(d.amount + 'lkr'),
                          Text(d.method),
                        ],
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 90),
                    child: ElevatedButton(
                      onPressed: () {
                        if (d.method == "One time Payment") {
                          startOneTimepayment(context);
                        } else if (d.method == "Recurrant payment") {
                        } else {}
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0)),
                        // primary: Color(0xFF2196F3),
                        backgroundColor: Colors.deepOrange,
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
