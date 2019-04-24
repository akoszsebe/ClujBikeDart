import 'package:flutter/material.dart';
import 'utils/colors.dart';
import 'package:hello_flutter/alltab.dart';
import 'package:hello_flutter/favoritesTab.dart';
import 'package:hello_flutter/maptab.dart';
import 'package:hello_flutter/model/station.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyAppState();
  }
  // This widget is the root of your application.

}

class MyAppState extends State<MyApp> {
  List<Station> data = [];
  Choice _selectedChoice = choices[0];
  @override
  void initState() {
    createPost("http://portal.clujbike.eu/Station/Read").then((response) {
      setState(() {
        data = response;
      });
    });
  }

  void _select(Choice choice) {
    // Causes the app to rebuild with the new _selectedChoice.
    setState(() {
      _selectedChoice = choice;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          primaryColor: ColorUtils.colorPrimary,
          primaryColorDark: ColorUtils.colorPrimaryDark,
          accentColor: ColorUtils.colorAccent,
          dividerColor: ColorUtils.colorDivider),
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
            appBar: AppBar(
              textTheme: TextTheme(title: TextStyle(fontSize: 22)),
              bottom: TabBar(
                labelStyle: TextStyle(fontSize: 18),
                tabs: [
                  Tab(text: "All"),
                  Tab(text: "Favorites"),
                  Tab(text: "Mapp"),
                ],
              ),
              title: Text('ClujBikeDart'),
              actions: <Widget>[
                PopupMenuButton<Choice>(
                  onSelected: _select,
                  itemBuilder: (BuildContext context) {
                    return choices.map((Choice choice) {
                      return PopupMenuItem<Choice>(
                        value: choice,
                        child: Text(choice.title),
                      );
                    }).toList();
                  },
                ),
              ],
            ),
            body: TabBarView(
              physics: ScrollPhysics(),
              children: [
                AllTab(data),
                FavoritesTab(data),
                MappTab(data),
              ],
            ),
            floatingActionButton: new FloatingActionButton(
                elevation: 0.0,
                child: new Icon(Icons.search, color: Colors.white),
                backgroundColor: ColorUtils.colorPrimary,
                onPressed: () {})),
      ),
    );
  }
}

class Choice {
  const Choice({this.title, this.icon});

  final String title;
  final IconData icon;
}

const List<Choice> choices = const <Choice>[
  const Choice(title: 'Info/Settings', icon: Icons.settings)
];

