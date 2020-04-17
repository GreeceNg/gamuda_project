import 'package:flutter/material.dart';
import 'package:gamuda_project/auth.dart';
import 'package:gamuda_project/main.dart';

class Dragable extends StatefulWidget {
  @override
  _DragState createState() => _DragState();
}

class _DragState extends State<Dragable> {
  double dy = 0, dx = 0;

  Future<bool> _onBackPressed() {
    return showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('Sign out'),
            content: new Text('Do you want to sign out and exit the App ?'),
            actions: <Widget>[
              FlatButton(
                  onPressed: () async {
                    bool logout = await FireAuth().handleSignOut();
                    if (!logout) {
                      return showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Oops!!'),
                              content: Text('Something is wrong with logout'),
                              actions: <Widget>[
                                FlatButton(
                                    onPressed: () =>
                                        Navigator.of(context).pop(),
                                    child: Text('OK'))
                              ],
                            );
                          });
                    } else {
                      Navigator.of(context).pop(true);
                    }
                  },
                  child: Text('YES')),
              FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                  child: Text('NO')),
            ],
          ),
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Dragable'),
        ),
        body: Container(
          child: Draggable(
            child: Container(
              child: Column(
                children: <Widget>[
                  Icon(
                    Icons.local_florist,
                    size: 80,
                    color: Colors.red,
                  ),
                  Container(
                    width: 100,
                    height: 20,
                    color: Colors.brown,
                  )
                ],
              ),
              padding: EdgeInsets.only(top: dy, left: dx),
            ),
            feedback: Container(
              child: Icon(
                Icons.local_florist,
                size: 80,
                color: Colors.red,
              ),
              padding: EdgeInsets.only(top: dy, left: dx),
            ),
            onDragEnd: (drag) {
              setState(() {
                if (dy + drag.offset.dy - 80 < 0) {
                  dy = 80;
                } else {
                  dy = dy + drag.offset.dy - 80;
                }
                if (dx + drag.offset.dx < 0) {
                  dx = 0;
                } else {
                  dx = dx + drag.offset.dx;
                }
              });
            },
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
            label: Text('LOGOUT'),
            icon: Icon(Icons.exit_to_app),
            backgroundColor: Colors.pink,
            onPressed: () async {
              bool logout = await FireAuth().handleSignOut();
              if (!logout) {
                return showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Oops!!'),
                        content: Text('Something is wrong with logout'),
                        actions: <Widget>[
                          FlatButton(
                              onPressed: () => Navigator.of(context).pop(),
                              child: Text('OK'))
                        ],
                      );
                    });
              } else {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => MyApp()));
              }
            }),
      ),
    );
  }
}
