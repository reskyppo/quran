import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DetailsScreen extends StatefulWidget {
  final int idx;
  const DetailsScreen({Key key, this.idx}) : super(key: key);

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Al Qur-an")),
        automaticallyImplyLeading: false,
      ),
      body: Container(
        child: Text("A"),
      ),
    );
  }
}
