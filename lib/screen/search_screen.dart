import 'package:flutter/material.dart';

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
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
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
          ))
    ]));
  }
}
