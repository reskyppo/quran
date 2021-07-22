import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:quran/utils/colors_utils.dart';

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
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: ColorsUtils.Primary),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text(
            title,
            style: TextStyle(color: ColorsUtils.Primary),
          ),
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
                            decoration: BoxDecoration(
                                border: Border(
                              bottom: BorderSide(
                                  width: 1.5, color: ColorsUtils.Text),
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
                                              color: ColorsUtils.Text),
                                          child: Center(
                                            child: Text(
                                              snapshot.data['data']['verses']
                                                      [index]['number']
                                                      ['inSurah']
                                                  .toString(),
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.share,
                                              color: ColorsUtils.Text,
                                            ),
                                            IconButton(
                                                icon: Icon(
                                                  idxPlaying == index
                                                      ? Icons.pause
                                                      : Icons
                                                          .play_arrow_outlined,
                                                  color: ColorsUtils.Text,
                                                ),
                                                onPressed: () {
                                                  setState(() {
                                                    idxPlaying = index;
                                                  });
                                                }),
                                            Icon(
                                              Icons.bookmark_outline,
                                              color: ColorsUtils.Text,
                                            )
                                          ],
                                        )
                                      ],
                                    )),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Container(
                                      child: Flexible(
                                        fit: FlexFit.loose,
                                        child: Text(
                                          snapshot.data['data']['verses'][index]
                                              ['text']['arab'],
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: ColorsUtils.Text),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Flexible(
                                      child: Text(
                                        snapshot.data['data']['verses'][index]
                                            ['text']['transliteration']['en'],
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ),
                                  ],
                                ),
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
