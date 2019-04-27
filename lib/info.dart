import 'package:flutter/material.dart';
import 'utils/colors.dart';
import 'package:hello_flutter/utils/localdb.dart';

class Info extends StatefulWidget {
  static const routeName = '/info';

  @override
  State<StatefulWidget> createState() => _InfoState();
}

class _InfoState extends State<Info> {
  int _groupValue;

  @override
  void initState() {
    _groupValue = 0;
    LocalDb.getStartUpTab().then((tab) {
      setState(() {
        _groupValue = tab;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          textTheme: TextTheme(title: TextStyle(fontSize: 22)),
          title: Text("Info/Settings"),
        ),
        body: Column(children: <Widget>[
          Container(
              height: 500,
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
                    colorInfo(ColorUtils.colorActive, "Active"),
                    colorInfo(ColorUtils.colorOffline, "Offline"),
                    colorInfo(ColorUtils.colorNotWorking, "Not Working"),
                    colorInfo(ColorUtils.colorSuprapopulated, "Overpopulated"),
                    colorInfo(ColorUtils.colorUnderpopulated, "Underpopulated"),
                    new Container(
                      margin: EdgeInsets.all(8),
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
                      padding: EdgeInsets.only(left: 24),
                      height: 10,
                      child: Text(
                        "Startup Tab:",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    radioElement("All", 0, radioClicked),
                    radioElement("Favorites", 1, radioClicked),
                  ],
                ),
              )),
        ]));
  }

  void radioClicked(int value) {
    LocalDb.setStartUpTab(value).then((response) {
      if (response) {
        setState(() {
          _groupValue = value;
        });
      }
    });
  }

  Widget radioElement(String title, int value, Function listner) {
    return new Container(
      padding: EdgeInsets.only(left: 8),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          new Text(
            title,
            style: new TextStyle(fontSize: 16.0),
          ),
          new Radio(value: value, groupValue: _groupValue, onChanged: listner),
        ],
      ),
    );
  }

  Widget colorInfo(Color color, String info) {
    return Row(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(8.0),
          child: CircleAvatar(backgroundColor: color, radius: 12.0),
        ),
        Text(
          info,
          style: TextStyle(fontSize: 23),
        )
      ],
    );
  }
}
