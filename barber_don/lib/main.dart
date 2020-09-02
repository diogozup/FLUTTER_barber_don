import 'package:barber_don/Home.dart';
import 'package:barber_don/login.page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(MaterialApp(localizationsDelegates: [
    DefaultWidgetsLocalizations.delegate,
    DefaultMaterialLocalizations.delegate,
  ], debugShowCheckedModeBanner: false, home: LoginPage()));
}
