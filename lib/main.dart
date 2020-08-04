import 'package:flutter/material.dart';
import 'package:readr_app/helpers/constants.dart';
import 'package:readr_app/pages/homePage.dart';

void main() {
  runApp(MirrorApp());
}

class MirrorApp extends StatelessWidget {
  final routes = <String, WidgetBuilder>{
    latestPageTag: (context) => HomePage(),
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: appTitle,
      theme: ThemeData(
        primaryColor: appColor,
      ),
      home: HomePage(),
      routes: routes,
    );
  }
}
