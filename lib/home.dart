import 'utils/colors.dart';
import 'package:hello_flutter/alltab.dart';
import 'package:hello_flutter/info.dart';
import 'package:hello_flutter/stationinfo.dart';
import 'package:hello_flutter/favoritesTab.dart';
import 'package:hello_flutter/maptab.dart';
import 'package:hello_flutter/model/station.dart';
import 'package:hello_flutter/utils/localdb.dart';
import 'package:hello_flutter/utils/fancyfab.dart';
import 'package:flutter/material.dart';


class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  List<Station> data = [];
  List<Station> uiData = [];
  List<String> favoriteIds = [];
  bool isVisible = true;
  bool isSearchVisible = false;
  bool isRefreshing = true;
  bool loaded = false;
  Icon fabIcon = Icon(Icons.search, color: Colors.white);
  TabController _tabController;
  int startUpTab = 2;

  final List<Tab> myTabs = <Tab>[
    Tab(text: "All"),
    Tab(text: "Favorites"),
    Tab(text: "Map"),
  ];

  @override
  void initState() {
    _tabController =
        new TabController(vsync: this, initialIndex: 0, length: myTabs.length);
    _tabController.addListener(_handleTabSelection);
    LocalDb.getStartUpTab().then((tab) {
      setState(() {
        if (tab != _tabController.index) {
          _tabController.animateTo(tab);
        }
      });
    });
    getData();
  }

  void getData() {
    isRefreshing = true;
    createPost("http://portal.clujbike.eu/Station/Read").then((response) {
      LocalDb.getFavoriteIds().then((ids) {
        setState(() {
          favoriteIds = ids;
          data = response;
          uiData = response;
          isRefreshing = false;
          loaded = true;
        });
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
            body: NestedScrollView(
              headerSliverBuilder: _buildAppBar,
              body: _buildBody(),
            ),
            floatingActionButton:
                Visibility(visible: isVisible, child: _buildFab()),
          )),
      routes: <String, WidgetBuilder>{
        Info.routeName: (BuildContext context) => Info(),
        StationInfo.routeName: (BuildContext context) => StationInfo(),
      },
    );
  }

  List<Widget> _buildAppBar(context, innerBoxIsScrolled) {
    return <Widget>[
      SliverAppBar(
          textTheme: TextTheme(title: TextStyle(fontSize: 22)),
          title: Text("ClujBikeDart"),
          pinned: true,
          floating: true,
          forceElevated: innerBoxIsScrolled,
          bottom: TabBar(
            tabs: myTabs,
            controller: _tabController,
            labelStyle: TextStyle(fontSize: 18),
          ),
          actions: <Widget>[
            PopupMenuButton(itemBuilder: (BuildContext context) {
              return <PopupMenuEntry>[
                PopupMenuItem(
                  child: InkWell(
                    child: Text("Info/Settings"),
                    onTap: () =>
                        {Navigator.popAndPushNamed(context, Info.routeName)},
                  ),
                )
              ];
            })
          ]),
    ];
  }

  Widget _buildFab() {
    return FancyFab((b) => {
          setState(() {
            isSearchVisible = b;
            if (uiData.length != data.length) {
              uiData = data;
            }
          })
        });
  }

  Widget _buildBody() {
    if (loaded) {
      return TabBarView(
          physics: ScrollPhysics(),
          children: [
            AllTab(uiData, this),
            FavoritesTab(uiData, favoriteIds, this),
            MappTab(uiData),
          ],
          controller: _tabController);
    } else {
      return new Center(
        child: CircularProgressIndicator(),
      );
    }
  }

  void filterdata(String filter) {
    setState(() {
      if (filter.isEmpty) {
        uiData = data;
      } else {
        uiData = data
            .where((x) =>
                x.stationName.toLowerCase().contains(filter.toLowerCase()))
            .toList();
      }
    });
  }

  void _handleTabSelection() {
    setState(() {
      if (uiData.length != data.length) {
        uiData = data;
      }
      if (_tabController.index == 2) {
        isVisible = false;
      } else {
        isVisible = true;
      }
    });
  }
}