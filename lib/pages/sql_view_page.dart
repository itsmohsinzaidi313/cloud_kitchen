import 'package:flutter/material.dart';
import 'package:food_app/database/project_database.dart';

class SqlView extends StatefulWidget {
  @override
  _SqlViewState createState() => _SqlViewState();
}

class _SqlViewState extends State<SqlView> {
  bool applyNewLine = false;
  bool capsColumnNames = false;
  final _textEditingController1 = TextEditingController();
  final _textEditingController2 = TextEditingController();
  List<Map<String, dynamic>> result = [];
  bool check1 = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('SQL VIEW')),
      body: LayoutBuilder(builder: (context, constraints) {
        return SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: <Widget>[
                ListTile(
                  title: TextField(
                    controller: _textEditingController1,
                    decoration: InputDecoration(labelText: 'Query'),
                  ),
                  leading: IconButton(
                    icon: Icon(
                      Icons.check,
                      color: Colors.red,
                    ),
                    onPressed: () {
                      ProjectDatabase().database.then((db) {
                        db
                            .rawQuery(_textEditingController1.text)
                            .then((value) => setState(() {
                                  result = value;
                                }))
                            .catchError((onError) => setState(() {
                                  result = [];
                                  result.add({'Error': onError});
                                }));
                      });
                    },
                  ),
                  trailing: IconButton(
                    icon: Icon(
                      Icons.clear,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      setState(() {
                        result = [];
                        _textEditingController1.text = '';
                      });
                    },
                  ),
                  subtitle: Text('Rows: ${result.length}'),
                ),
                ListTile(
                  title: TextField(
                    controller: _textEditingController2,
                    decoration: InputDecoration(labelText: 'Query'),
                  ),
                  leading: IconButton(
                    icon: Icon(
                      Icons.check,
                      color: Colors.red,
                    ),
                    onPressed: () {
                      ProjectDatabase().database.then((db) {
                        db
                            .rawQuery(_textEditingController2.text)
                            .then((value) => setState(() {
                                  result = value;
                                }))
                            .catchError((onError) => setState(() {
                                  result = [];
                                  result.add({'Error': onError});
                                }));
                      });
                    },
                  ),
                  trailing: IconButton(
                    icon: Icon(
                      Icons.clear,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      setState(() {
                        result = [];
                        _textEditingController2.text = '';
                      });
                    },
                  ),
                  subtitle: Text('Rows: ${result.length}'),
                ),
                ButtonBar(
                  alignment: MainAxisAlignment.start,
                  children: <Widget>[
                    RaisedButton(
                      child: Text('New Line'),
                      onPressed: () {
                        setState(() {
                          applyNewLine = !applyNewLine;
                        });
                      },
                    ),
                    RaisedButton(
                      child: Text('Caps Columns'),
                      onPressed: () {
                        setState(() {
                          capsColumnNames = !capsColumnNames;
                        });
                      },
                    )
                  ],
                ),
                Expanded(
                  child: ListView.builder(
                      itemCount: result.length,
                      itemBuilder: (BuildContext context, int index) =>
                          getWidget(context, index)),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget getWidget(BuildContext context, int index) {
    return Container(
      child: Card(
        child: ListTile(
          leading: Text(
            '${index + 1}',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          title: Text(styleColumns(result[index])),
        ),
      ),
    );
  }

  String styleColumns(Map<String, dynamic> map) {
    String string = '';
    String newLine = '';
    if (applyNewLine) newLine = '\n';
    map.forEach((key, value) {
      if (capsColumnNames) {
        string += '${key.toUpperCase()}: $value$newLine ';
      } else {
        string += '$key: $value$newLine ';
      }
    });
    return string;
  }

  @override
  void dispose() {
    super.dispose();
    _textEditingController1.dispose();
    _textEditingController2.dispose();
  }
}
