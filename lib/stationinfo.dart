import 'package:flutter/material.dart';
import 'package:hello_flutter/model/station.dart';
import 'utils/colors.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class StationInfo extends StatelessWidget {
  static const routeName = '/stationinfo';

  @override
  Widget build(BuildContext context) {
    final Station station = ModalRoute.of(context).settings.arguments;
    return Scaffold(
        appBar: AppBar(
          textTheme: TextTheme(title: TextStyle(fontSize: 22)),
          title: Text(station.stationName),
          elevation: 0.0,
        ),
        body: Column(children: <Widget>[
          Container(
            height: 100,
            padding: EdgeInsets.all(16.0),
            color: ColorUtils.colorPrimary,
            child: SizedBox.expand(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Bikes " + station.ocuppiedSpots.toString(),
                    style: TextStyle(color: Colors.white, fontSize: 23),
                  ),
                  Text(
                    "Parking " + station.emptySpots.toString(),
                    style: TextStyle(color: Colors.white, fontSize: 23),
                  )
                  
                ],
              ),
            )),
          Container(
            height: 500,
            child:
          SizedBox.expand(child: GoogleMap( mapType: MapType.normal, 
              initialCameraPosition: CameraPosition( 
              target: LatLng(station.latitude, station.longitude), 
              zoom: 12.4746, ), 
              onMapCreated: (c) => {}, 
            )
          )
          )
        ]) 
    ); 
  }
}
