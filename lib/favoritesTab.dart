import 'package:hello_flutter/model/station.dart';
import 'package:hello_flutter/basetab.dart';



class FavoritesTab extends BaseTab {
  FavoritesTab(List<Station> _data) :super(filter([85,86,98],_data));

  static List<Station> filter(List<int> ids,List<Station> stations){
    return stations.where((x) => ids.contains(x.id)).toList();
  }
}