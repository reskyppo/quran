import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DetailsScreen extends StatelessWidget {
  final String idx;

  const DetailsScreen({Key key, @required this.idx}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String url = 'https://api.quran.sutanlab.id/surah/' + idx;
    Future fetchAPI() async {
      var res = await http.get(Uri.parse(url));
      return json.decode(res.body);
    }

    Size size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
          title: Center(child: Text("Al Qur-an")),
          automaticallyImplyLeading: false,
        ),
        body: FutureBuilder(
            future: fetchAPI(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: snapshot.data['data']['verses'].length,
                    itemBuilder: (context, index) {
                      return Padding(
                          padding: EdgeInsets.all(size.width * 0.05),
                          child: Container(
                            height: size.height * 0.1,
                            decoration: BoxDecoration(
                                border: Border(
                              bottom: BorderSide(
                                  width: 1.5,
                                  color: Colors.deepPurple.shade200),
                            )),
                            child: Column(
                              children: [
                                Container(
                                    height: 40.0,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(6),
                                      color: Colors.deepPurple.shade50,
                                    ),
                                    child: Row(
                                      children: [
                                        Container(
                                          margin: EdgeInsets.symmetric(
                                            horizontal: 20,
                                          ),
                                          width: 24,
                                          height: 24,
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.deepPurple),
                                          child: Center(
                                            child: Text(
                                              snapshot.data['data']['verses']
                                                      [index]['number']
                                                      ['inSurah']
                                                  .toString(),
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                        Text(index.toString()),
                                      ],
                                    )),
                                Text(index.toString()),
                              ],
                            ),
                          ));
                    });
              } else {
                return Text("err");
              }
            }));
  }
}
