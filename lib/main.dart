import 'package:flutter/material.dart';
import 'utils/colors.dart';
import 'package:hello_flutter/alltab.dart';
import 'package:hello_flutter/info.dart';
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

class MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
  List<Station> data = [];
  bool isVisible = true;
  bool isRefreshing = true;
  TabController _tabController;

  final List<Tab> myTabs = <Tab>[
    Tab(text: "All"),
    Tab(text: "Favorites"),
    Tab(text: "Map"),
  ];

  @override
  void initState() {
    getData();
    _tabController =
        new TabController(vsync: this, initialIndex: 0, length: myTabs.length);
    _tabController.addListener(_handleTabSelection);
  }

  void getData(){
    isRefreshing = true;
    createPost("http://portal.clujbike.eu/Station/Read").then((response) {
      setState(() {
        data = response;
        isRefreshing = false;
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
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
                controller: _tabController,
                labelStyle: TextStyle(fontSize: 18),
                tabs: myTabs,
              ),
              title: Text('ClujBikeDart'),
              actions: <Widget>[
                PopupMenuButton(
                  itemBuilder: (BuildContext context) {
                      return <PopupMenuEntry>[
                        new PopupMenuItem(child: InkWell(
                          child: new Text("Info/Settings"),
                          onTap: () => { Navigator.popAndPushNamed(context,'/info') },
                        ),)
                      ];
                  },
                ),
              ],
            ),
            body: TabBarView(
                physics: ScrollPhysics(),
                children: [
                  AllTab(data,this),
                  FavoritesTab(data,this),
                  MappTab(data),
                ],
                controller: _tabController),
            floatingActionButton: Visibility(
                visible: isVisible,
                child: new FloatingActionButton(
                    elevation: 0.0,
                    child: new Icon(Icons.search, color: Colors.white),
                    backgroundColor: ColorUtils.colorPrimary,
                    onPressed: () {})),
          )),
      routes: <String, WidgetBuilder>{
        '/info': (BuildContext context) => new Info(),
      },
    );
  }

  void _handleTabSelection() {
    setState(() {
      if (_tabController.index == 2) {
        isVisible = false;
      } else {
        isVisible = true;
      }
    });
  }
}

