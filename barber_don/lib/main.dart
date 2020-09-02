
import 'package:barber_don/Home.dart';
import 'package:barber_don/login.page.dart';
import 'package:flutter/material.dart';

void main(){
  runApp(MaterialApp(
    localizationsDelegates: [
      DefaultWidgetsLocalizations.delegate,
      DefaultMaterialLocalizations.delegate,
    ],
    debugShowCheckedModeBanner: false,
    home: LoginPage()
  ));
}