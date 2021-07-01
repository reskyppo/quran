import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Body extends StatelessWidget {
  String url = 'https://api.quran.sutanlab.id/surah';

  Future fetchAPI() async {
    var res = await http.get(Uri.parse(url));
    return json.decode(res.body);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return FutureBuilder(
      future: fetchAPI(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
              itemCount: snapshot.data['data'].length,
              itemBuilder: (context, index) {
                return Container(
                  height: size.height * 0.15,
                  child: Card(
                    elevation: 2,
                    child: Row(
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 20),
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            border:
                                Border.all(width: 3, color: Colors.deepPurple),
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Text(
                              snapshot.data['data'][index]['number'].toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.deepPurple),
                            ),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(snapshot.data['data'][index]['name']
                                ['transliteration']['id']),
                            Text(snapshot.data['data'][index]['name']
                                ['translation']['id']),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              });
        } else {
          return Text("data err");
        }
      },
    );
  }
}
