import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'application.dart';
import 'home_screen.dart';

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
  List<String> todos;
  String input = "";
  SharedPreferences ref;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<SharedPreferences>(
      future: SharedPreferences.getInstance(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        ref = snapshot.data;
        todos = ref.getStringList('todo');
        todos ??= [];

        return _buildBody();
      },
    );
  }

  Widget _buildBody() {
    return Scaffold(
        appBar: AppBar(
          title: Text("TodoList"),
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: _OnPressAdd,
          child: Icon(Icons.add),
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
                          onPressed:()=> _OnPressedRemoved(index),
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.edit,
                            color: Colors.blue,
                          ),
                          onPressed: () => _OnPressedUpdate(index),
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
  _OnPressAdd(){
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
                      print(todos);
                      ref.setStringList('todo', todos);
                      input = "";
                    });
                  },
                  child: Text("Add"),
                ),
              ]);
        });
  }

  _OnPressedRemoved(int index){
    setState(() {
      todos.removeAt(index);
      ref.setStringList('todo', todos);
    });
  }

  _OnPressedUpdate(int index){
    String todo = todos[index];
    showDialog(
        context: context,
        builder: (BuildContext context) {
          final textController = TextEditingController(text: todo);
          return AlertDialog(
              title: Text("Sửa"),
              content: TextField(
                controller: textController,
              ),
              actions: [
                FlatButton(
                  onPressed: () {
                    setState(() {
                      print(textController.text);
                      todos[index] = textController.text;
                      print(todos);
                      ref.setStringList('todo', todos);
                      input = "";
                    });
                  },
                  child: Text("Add"),
                ),
              ]);
        });
  }
}


