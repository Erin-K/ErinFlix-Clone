import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:inflearn_netflix_clone/model/model_movie.dart';

import 'detail_screen.dart';

class SearchScreen extends StatefulWidget {
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _filter = TextEditingController(); // 검색 위젯 컨트롤 위젯
  FocusNode focusNode = FocusNode(); // 현재 검색 위젯에 커서가 있는지에 대한 상태를 가지는 위젯
  String _searchText = '';

  // 서치 스크린 상태 관리 방법
  _SearchScreenState() {
    _filter.addListener(() {
      setState(() {
        _searchText = _filter.text;
      });
    });
  }

  Widget _buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance.collection('movie').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return LinearProgressIndicator();
          return _buildList(context, snapshot.data!.documents);
        }
    );
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    List<DocumentSnapshot> searchResults = [];
    for (DocumentSnapshot d in snapshot) {
      if (d.data.toString().contains(_searchText)) {
        searchResults.add(d);
      }
    }
    return Expanded(
      child: GridView.count(
          crossAxisCount: 3,
          childAspectRatio: 1 / 1.5,
          padding: EdgeInsets.all(3),
          children: searchResults.map((data) =>
              _buildListItem(context, data)).toList(),
      ),
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
    final movie = Movie.fromSnapShot(data);
    return InkWell(
        child: Image.network(movie.poster),
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute<Null>(
              fullscreenDialog: true,
              builder: (BuildContext context) {
                return DetailScreen(movie: movie);
              }
          ));
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(children: <Widget>[
          Padding(
            padding: EdgeInsets.all(30),
          ),
          Container(
              color: Colors.black,
              padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
              child: Row(
                children: <Widget>[
                  Expanded(
                      flex: 6,
                      child: TextField(
                          focusNode: focusNode,
                          style: TextStyle(
                            fontSize: 15,
                          ),
                          autofocus: true,
                          controller: _filter,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white12,
                            prefixIcon: Icon(
                              Icons.search,
                              color: Colors.white60,
                              size: 20,
                            ),
                            suffixIcon: focusNode.hasFocus
                                ? IconButton(
                                onPressed: () {
                                  setState(() {
                                    _filter.clear();
                                    _searchText = '';
                                  });
                                },
                                icon: Icon(
                                  Icons.cancel,
                                  size: 20,
                                ))
                                : Container(),
                            hintText: '검색',
                            labelStyle: TextStyle(
                                color: Colors.white
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                              borderRadius: BorderRadius.all(
                                  Radius.circular(10)),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                              borderRadius: BorderRadius.all(
                                  Radius.circular(10)),
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                              borderRadius: BorderRadius.all(
                                  Radius.circular(10)),
                            ),
                          )
                      )
                  ),
                  focusNode.hasFocus
                      ? Expanded(
                      child: FlatButton(
                          onPressed: () {
                            setState(() {
                              _filter.clear();
                              _searchText = '';
                              focusNode.unfocus();
                            });
                          },
                          child: Text('취소')
                      )
                  )
                      : Expanded(
                    flex: 0,
                    child: Container(),
                  ),
                ],
              )),
          _buildBody(context),
        ]));
  }
}
