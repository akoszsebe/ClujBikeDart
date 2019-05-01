import 'package:clujbikedart/model/station.dart';
import 'package:clujbikedart/views/basetab.dart';
import 'package:clujbikedart/views/home.dart';



class FavoritesTab extends BaseTab {
  FavoritesTab(List<Station> _data,List<String> ids, HomePageState myAppState) :super(filter(ids,_data),myAppState);

  static List<Station> filter(List<String> ids,List<Station> stations){
    return stations.where((x) => ids.contains(x.id.toString())).toList();
  }
}