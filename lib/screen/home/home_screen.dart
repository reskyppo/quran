import 'package:flutter/material.dart';
import 'package:quran/screen/home/components/body.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Al Qur-an")),
      ),
      body: Body(),
    );
  }
}
