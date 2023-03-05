import 'package:device_preview/device_preview.dart';
import "package:flutter/material.dart";

import 'package:intl/intl.dart';
import 'package:mypart/payment.dart';

void main() {
  runApp(DevicePreview(
    enabled: true,
    builder: (context) => MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    var supportedLocales;
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      theme: ThemeData.light(),
      home: Payment(),
      // routes: <String,WidgetBuilder>{
      //   '/second':(context)=>CreditCardPage()
      // },
    );
  }
}
