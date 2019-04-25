import 'package:flutter/material.dart';
import 'utils/colors.dart';

class Info extends StatelessWidget {
  static const routeName = '/info';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          textTheme: TextTheme(title: TextStyle(fontSize: 22)),
          title: Text("Info/Settings"),
        ),
        body: Column(children: <Widget>[
          Container(
              height: 440,
              padding: EdgeInsets.all(16.0),
              child: SizedBox.expand(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Info",
                      style: TextStyle(
                          color: ColorUtils.colorPrimary, fontSize: 20),
                    ),
                    Row(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.all(8.0),
                          child: CircleAvatar(
                              backgroundColor: ColorUtils.colorActive,
                              radius: 12.0),
                        ),
                        Text(
                          "Active",
                          style: TextStyle(fontSize: 23),
                        )
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.all(8.0),
                          child: CircleAvatar(
                              backgroundColor: Colors.grey, radius: 12.0),
                        ),
                        Text(
                          "Offline",
                          style: TextStyle(fontSize: 23),
                        )
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.all(8.0),
                          child: CircleAvatar(
                              backgroundColor: Colors.yellow, radius: 12.0),
                        ),
                        Text(
                          "Not Working",
                          style: TextStyle(fontSize: 23),
                        )
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.all(8.0),
                          child: CircleAvatar(
                              backgroundColor: Colors.red, radius: 12.0),
                        ),
                        Text(
                          "Overpopulated",
                          style: TextStyle(fontSize: 23),
                        )
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.all(8.0),
                          child: CircleAvatar(
                              backgroundColor: Colors.blue, radius: 12.0),
                        ),
                        Text(
                          "Underpopulated",
                          style: TextStyle(fontSize: 23),
                        )
                      ],
                    ),
                    new Container(
                      padding: EdgeInsets.all(18),
                      height: 1,
                      color: Colors.black,
                    ),
                    Text(
                      "Settings",
                      style: TextStyle(
                          color: ColorUtils.colorPrimary, fontSize: 20),
                    ),
                    new Container(
                      padding: EdgeInsets.all(18),
                      height: 30,
                      child: Text(
                        "Startup Tab",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    new Container(
                      padding: EdgeInsets.all(8),
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        new Text(
                          'All',
                          style: new TextStyle(fontSize: 16.0),
                        ),
                        new Radio(
                          value: 0,
                          groupValue: 0,
                          onChanged: (x){},
                        ),
                      ],
                    ),
                    ),
                    new Container(
                      padding: EdgeInsets.all(8),
                    child: 
                    new Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        new Text(
                          'Favorites',
                          style: new TextStyle(fontSize: 16.0),
                        ),
                        new Radio(
                          value: 1,
                          groupValue: 0,
                          onChanged: (x){},
                        ),
                      ],
                    ),
                    ),
                  ],
                ),
              )),
        ]));
  }
}
