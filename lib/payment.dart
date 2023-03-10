import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:payhere_mobilesdk_flutter/payhere_mobilesdk_flutter.dart';

class Details {
  var period = "2";
  var duration = "4";
  var purpose = "For bat";
  var lname = "yasas";
  var fname = "Ekan";
  var email = "ymeka2000@gmail.com";
  var amount = "400";
  var method = "one time";
}

class Payment extends StatelessWidget {
  var id = "yazaz2000";

  Details d = new Details();

  void startRecuurantPayment(BuildContext context) async {
    Map paymentObject = {
      "sandbox": true,
      "merchant_id": "",
      "merchant_secret": "",
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
      "merchant_id": "1211149", // Replace your Merchant ID
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
      "merchant_id": "put your merchant id",
      "merchant_secret": "Put your merchant secret",
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
    PayHere.startPayment(paymentObject, (paymentId) {
      print("One Time Payment Success. Payment Id: $paymentId");

      showAlert(context, "Payment Success!", "Payment Id: $paymentId");
      Navigator.pop(context, true);
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
      appBar: AppBar(
        title: Text('Payment gateway'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Center(
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(
                    color: Colors.deepOrange,
                    style: BorderStyle.solid,
                    strokeAlign: StrokeAlign.inside),
                borderRadius: BorderRadius.circular(8),
                gradient: LinearGradient(
                    begin: AlignmentDirectional(3, 10),
                    colors: [Colors.deepOrange, Colors.white])),
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
                        if (d.method == "one time") {
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
