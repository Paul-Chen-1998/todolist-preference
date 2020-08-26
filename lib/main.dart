import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Colors.blue),
      home: _bodyBuilder(),
    );
  }
}

class _bodyBuilder extends StatefulWidget {
  _bodyBuilder({Key key}) : super(key:key);
  @override
  __bodyBuilderState createState() => __bodyBuilderState();
}

class __bodyBuilderState extends State<_bodyBuilder> {
  
  List todos = List();
  String input = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    todos.add("item1");
    todos.add("item2");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("TodoList"),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                      title: Text("Thêm"),
                      content: TextField(
                        onChanged: (String value) {
                          input = value;
                        },
                      ),
                      actions: [
                        FlatButton(
                          onPressed: () {
                            setState(() {
                              todos.add(input);
                            });
                          },
                          child: Text("Add"),
                        ),
                      ]);
                });
          },
        ),
        body: ListView.builder(
          itemCount: todos.length,
          itemBuilder: (BuildContext context, int index) {
            return Dismissible(
              key: Key(todos[index]),
              child: Card(
                margin: EdgeInsets.all(16),
                elevation: 4,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                child: ListTile(
                  title: Text(todos[index]),
                  trailing: Container(
                    width: 100,
                    child: Row(
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                          onPressed: () {
                            setState(() {
                              todos.removeAt(index);
                            });
                          },
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.update,
                            color: Colors.blue,
                          ),
                          onPressed: () {
                            showDialog(context: context,
                              builder: (BuildContext context){
                              return AlertDialog(
                                title: Text("Thay Đổi"),
                                content: TextField(
                                  onChanged: (String value){
                                    input = value;
                                  },
                                ),
                                actions: [
                                  FlatButton(
                                    onPressed: (){

                                    },
                                    child: Text("Xác nhận"),
                                  )
                                ],
                              );
                              }
                            );
                          },
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ));
  }
}
