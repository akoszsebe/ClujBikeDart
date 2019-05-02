import 'package:flutter/material.dart';
import 'package:clujbikedart/views/home.dart';
import 'package:clujbikedart/utils/colors.dart';
import 'package:clujbikedart/views/info.dart';
import 'package:clujbikedart/views/stationinfo.dart';
import 'package:clujbikedart/services/stations_services.dart';

void main() => runApp(MyApp(apiSvc: StationService()));

class MyApp extends StatelessWidget{
  final IClujBikeApi apiSvc;

  MyApp({@required this.apiSvc});
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          primaryColor: ColorUtils.colorPrimary,
          primaryColorDark: ColorUtils.colorPrimaryDark,
          accentColor: ColorUtils.colorAccent,
          dividerColor: ColorUtils.colorDivider),
      home: HomePage(apiSvc: apiSvc),
      routes: <String, WidgetBuilder>{
        Info.routeName: (BuildContext context) => Info(),
        StationInfo.routeName: (BuildContext context) => StationInfo(),
      },
    );
  }
}



