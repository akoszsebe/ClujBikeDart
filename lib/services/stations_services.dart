import 'package:http/http.dart' as http;
import 'package:clujbikedart/model/station.dart';
import 'dart:async';
import 'dart:convert';

abstract class IClujBikeApi {
  Future<List<Station>> getSationsData();
}

class StationService implements IClujBikeApi {
  final _baseUrl = "http://portal.clujbike.eu";
  final _stationsData = "/Station/Read";

  Future<List<Station>> getSationsData() async {
    return http.post(_baseUrl+_stationsData).then((http.Response response) {
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error while fetching data");
      }
      return StationsData.fromJson(json.decode(response.body)).data;
    });
  }
}
