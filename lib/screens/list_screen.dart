import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_todo_list/models/todo.dart';
import 'package:flutter_todo_list/providers/todo_default.dart';

class ListScreen extends StatefulWidget {
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  List<Todo> todos = [];
  TodoDefault todoDefault = TodoDefault();
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 2), () {
      todos = todoDefault.getTodos();
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        appBar: AppBar(
          title: Text('할 일 목록 앱'),
          actions: [
            InkWell(
              onTap: () {},
              child: Container(
                padding: EdgeInsets.all(5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Icon(Icons.book), Text('뉴스')],
                ),
              ),
            )
          ],
        ),

        floatingActionButton: FloatingActionButton(
          child: Text('+',
            style: TextStyle(fontSize: 25),
          ),
          onPressed: () { // + 버튼 눌렀을 때
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  String title ='';
                  String description = '';
                  return AlertDialog( //ShowDialog에서 띄울 다이얼로그를 AlertDialog로 정의
                    title: Text('할 일 추가하기'), //다이얼로그 제목
                    content: Container( //다이얼로그 내용
                      height: 200,
                      child: Column(
                        children: [
                          TextField(
                            onChanged: (value) {
                              title = value;
                            },
                            decoration: InputDecoration(labelText: '제목'),
                          ),
                          TextField(
                            onChanged: (value) {
                              description = value;
                            },
                            decoration: InputDecoration(labelText: '설명'),
                          ),
                        ],
                      ),
                    ),
                    actions: [ //다이얼로그 버튼
                      TextButton( //추가 버튼
                        child: Text('추가'),
                        onPressed: () {
                          setState(() {
                            print('[UI] ADD');
                            todoDefault.addTodo( //Todo를 추가하도록 작성함
                              Todo(title: title, description: description),
                            );
                          });
                          Navigator.of(context).pop();
                        }),
                      TextButton( //취소 버튼
                        child: Text('취소'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        }),
                    ],
                  );
                });
          },
        ),

        body: isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView.separated( //ListView.builder와 유사하지만 List의 각 요소들 사이에 Divider을 넣어줌
                itemCount: todos.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(todos[index].title),
                    onTap: () {},
                    trailing: Container(
                      width: 80,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            padding: EdgeInsets.all(5),
                            child: InkWell(
                              child: Icon(Icons.edit),
                              onTap: () {},
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(5),
                            child: InkWell(
                              child: Icon(Icons.delete),
                              onTap: () {},
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return Divider();
                },
              ),
    );
  }
}
