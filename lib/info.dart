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
                    colorInfo(ColorUtils.colorActive,"Active"),
                    colorInfo(ColorUtils.colorOffline,"Offline"),
                    colorInfo(ColorUtils.colorNotWorking,"Not Working"),
                    colorInfo(ColorUtils.colorSuprapopulated,"Overpopulated"),
                    colorInfo(ColorUtils.colorUnderpopulated,"Underpopulated"),
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

  Widget colorInfo(Color color,String info){
    return Row(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(8.0),
          child: CircleAvatar(
              backgroundColor: color,
              radius: 12.0),
        ),
        Text(
          info,
          style: TextStyle(fontSize: 23),
        )
      ],
    );
  }
}
