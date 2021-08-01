import 'package:flutter/material.dart';
import 'package:inflearn_netflix_clone/model/model_movie.dart';
import 'dart:ui';

class DetailScreen extends StatefulWidget {
  final Movie movie;

  DetailScreen({required this.movie});

  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  void initState() {
    super.initState();
    var like = widget.movie.like;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            child: SafeArea(
      child: ListView(children: <Widget>[
        Stack(
          children: <Widget>[
            Container(
                width: double.maxFinite,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(widget.movie.poster),
                    fit: BoxFit.cover,
                  ),
                ),
                child: ClipRect(
                    child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                        child: Container(
                            alignment: Alignment.center,
                            color: Colors.black.withOpacity(0.1),
                            child: Container(
                                child: Column(children: <Widget>[
                              Container(
                                padding: EdgeInsets.fromLTRB(0, 45, 0, 10),
                                child: Image.network(
                                    widget.movie.poster),
                                height: 300,
                              ),
                              Container(
                                padding: EdgeInsets.all(7),
                                child: Text('99%의 일치 2019 15+ 시즌 1개',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 13)),
                              ),
                              Container(
                                  padding: EdgeInsets.all(7),
                                  child: Text(
                                    widget.movie.title,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  )),
                              Container(
                                  padding: EdgeInsets.all(7),
                                  child: TextButton(
                                      onPressed: () {},
                                      style: TextButton.styleFrom(
                                          primary: Colors.white,
                                          backgroundColor: Colors.red),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Icon(Icons.play_arrow),
                                          Text('재생')
                                        ],
                                      ))),
                              Container(
                                  padding: EdgeInsets.all(5),
                                  child: Text(
                                    widget.movie.toString(),
                                  )),
                              Container(
                                  padding: EdgeInsets.all(5),
                                  alignment: Alignment.centerLeft,
                                  child: Text('출연: 현빈, 손예진, 서지혜\n제작자: 이정호, 박지은',
                                      style: TextStyle(
                                        color: Colors.white60,
                                        fontSize: 12,
                                      )))
                            ])))))),
            Positioned(
                child: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
            ))
          ],
        ),
        Container(
          color: Colors.black26,
          child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  color: Colors.black26,
                  child: InkWell(
                      onTap: () {},
                      child: Column(children: <Widget>[
                        widget.movie.like ? Icon(Icons.check) : Icon(Icons.add),
                        Padding(
                          padding: EdgeInsets.all(5),
                        ),
                        Text(
                          '내가 찜한 콘텐츠',
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.white60,
                          ),
                        ),
                      ])),
                ),
                Container(
                    padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                    child: Column(
                      children: <Widget>[
                        Icon(Icons.thumb_up),
                        Padding(
                          padding: EdgeInsets.all(5),
                        ),
                        Text(
                          '평가',
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.white60,
                          ),
                        ),
                      ],
                    ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: Column(
                    children: <Widget>[
                      Icon(Icons.send),
                      Padding(padding: EdgeInsets.all(5)),
                      Text(
                        '공유',
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.white60,
                        ),
                      ),
                    ],
                  ),
                )
              ]),
        ),
      ]),
    )));
  }
}
