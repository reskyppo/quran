import 'package:flutter/material.dart';
import 'package:quran/screen/home/components/body.dart';
import 'package:quran/utils/colors_utils.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: Text("Quran App",
                style: TextStyle(color: ColorsUtils.Primary))),
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      body: Body(),
    );
  }
}
