import 'package:hello_flutter/model/station.dart';
import 'package:hello_flutter/basetab.dart';
import 'package:hello_flutter/main.dart';



class FavoritesTab extends BaseTab {
  FavoritesTab(List<Station> _data, MyAppState myAppState) :super(filter([85,86,98],_data),myAppState);

  static List<Station> filter(List<int> ids,List<Station> stations){
    return stations.where((x) => ids.contains(x.id)).toList();
  }
}