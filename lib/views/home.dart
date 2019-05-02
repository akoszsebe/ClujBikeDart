
import 'package:clujbikedart/views/alltab.dart';
import 'package:clujbikedart/views/info.dart';
import 'package:clujbikedart/views/favoritesTab.dart';
import 'package:clujbikedart/views/maptab.dart';
import 'package:clujbikedart/model/station.dart';
import 'package:clujbikedart/utils/localdb.dart';
import 'package:clujbikedart/utils/fancyfab.dart';
import 'package:flutter/material.dart';
import 'package:clujbikedart/services/stations_services.dart';
import 'package:clujbikedart/utils/colors.dart';


class HomePage extends StatefulWidget {
  final IClujBikeApi apiSvc;

  HomePage({@required this.apiSvc});

  @override
  State<StatefulWidget> createState() {
    return HomePageState(apiSvc: apiSvc);
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
  
  final IClujBikeApi apiSvc;
  HomePageState({@required this.apiSvc});

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
    apiSvc.getSationsData().then((response) {
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
    return 
      Scaffold(
            body: NestedScrollView(
              headerSliverBuilder: _buildAppBar,
              body: _buildBody(),
            ),
            floatingActionButton:
                Visibility(visible: isVisible, child: _buildFab()),
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
      return  Flex(
        direction: Axis.vertical,
        children: <Widget>[
         Expanded(child:
        TabBarView(
          physics: ScrollPhysics(),
          children: [
            AllTab(uiData, this),
            FavoritesTab(uiData, favoriteIds, this),
            MappTab(uiData),
          ],
          controller: _tabController)
          )
          ,Visibility(
              visible: isSearchVisible,
              child: TextField(
                onChanged: (text) {
                  filterdata(text);
                },
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(24),                    
                    fillColor: ColorUtils.colorGray,
                    filled: true,
                    hintText: 'Please enter a search term',hintStyle: TextStyle(color: Colors.white30)),
              ))
          ]
          );
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
        isSearchVisible = false;
      } else {
        isVisible = true;
      }
    });
  }
}