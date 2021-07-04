import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:quran/screen/details/details_screen.dart';

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
                return InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DetailsScreen()));
                  },
                  child: Container(
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
                                shape: BoxShape.circle,
                                color: Colors.deepPurple),
                            child: Center(
                              child: Text(
                                snapshot.data['data'][index]['number']
                                    .toString(),
                                style: TextStyle(
                                    fontSize: 15, color: Colors.white),
                              ),
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                snapshot.data['data'][index]['name']
                                    ['transliteration']['id'],
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w700),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 8),
                                child: Text(
                                  snapshot.data['data'][index]['revelation']
                                              ['id']
                                          .toUpperCase() +
                                      "  " +
                                      snapshot.data['data'][index]
                                              ['numberOfVerses']
                                          .toString() +
                                      " VERSES",
                                  style: TextStyle(fontSize: 12),
                                ),
                              )
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: size.width * 0.3),
                            child: Text(
                              snapshot.data['data'][index]['name']['short'],
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w700),
                            ),
                          )
                        ],
                      ),
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
