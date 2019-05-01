import 'package:flutter/material.dart';
import 'package:clujbikedart/views/home.dart';
import 'package:clujbikedart/utils/colors.dart';
import 'package:clujbikedart/views/info.dart';
import 'package:clujbikedart/views/stationinfo.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          primaryColor: ColorUtils.colorPrimary,
          primaryColorDark: ColorUtils.colorPrimaryDark,
          accentColor: ColorUtils.colorAccent,
          dividerColor: ColorUtils.colorDivider),
      home: HomePage(),
      routes: <String, WidgetBuilder>{
        Info.routeName: (BuildContext context) => Info(),
        StationInfo.routeName: (BuildContext context) => StationInfo(),
      },
    );
  }
}



