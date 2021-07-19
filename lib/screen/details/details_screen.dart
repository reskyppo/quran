import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DetailsScreen extends StatefulWidget {
  final String idx;

  const DetailsScreen({Key key, @required this.idx}) : super(key: key);

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  bool isPlaying = false;
  int idxPlaying;
  String title = "...";

  @override
  Widget build(BuildContext context) {
    String url = 'https://api.quran.sutanlab.id/surah/' + widget.idx;
    Future fetchAPI() async {
      var res = await http.get(Uri.parse(url));
      setState(() {
        title = json.decode(res.body)['data']['name']['transliteration']['id'];
      });
      return json.decode(res.body);
    }

    Size size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
          title: Text(title),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
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
                                        IconButton(
                                            icon: Icon(
                                              idxPlaying == index
                                                  ? Icons.pause
                                                  : Icons.play_arrow_outlined,
                                              color: Colors.deepPurple.shade400,
                                            ),
                                            onPressed: () {
                                              setState(() {
                                                idxPlaying = index;
                                              });
                                            })
                                      ],
                                    )),
                                Text(index.toString()),
                              ],
                            ),
                          ));
                    });
              } else {
                return Text("...");
              }
            }));
  }
}
