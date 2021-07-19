import 'package:flutter/material.dart';
import 'package:quran/screen/home/components/body.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Quran App")),
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      body: Body(),
    );
  }
}
