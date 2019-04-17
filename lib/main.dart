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

  @override
  void initState(){
    createPost("http://portal.clujbike.eu/Station/Read").then((response){
      setState(() {
       data = response; 
      });
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
            bottom: TabBar(
              tabs: [
                Tab(text: "All"),
                Tab(text: "Favorites"),
                Tab(text: "Mapp"),
              ],
            ),
            title: Text('ClujBikeDart'),
          ),
          body: TabBarView(
            children: [
              AllTab(data),
              FavoritesTab(),
              MappTab(),
            ],
          ),
        ),
      ),
    );
  }
}
