import 'package:hello_flutter/model/station.dart';
import 'package:hello_flutter/basetab.dart';
import 'package:hello_flutter/main.dart';



class FavoritesTab extends BaseTab {
  FavoritesTab(List<Station> _data,List<String> ids, MyAppState myAppState) :super(filter(ids,_data),myAppState);

  static List<Station> filter(List<String> ids,List<Station> stations){
    return stations.where((x) => ids.contains(x.id.toString())).toList();
  }
}