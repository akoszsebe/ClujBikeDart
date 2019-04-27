import 'package:flutter/material.dart';
import 'package:hello_flutter/model/station.dart';
import 'utils/colors.dart';
import 'package:hello_flutter/utils/localdb.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class StationInfo extends StatefulWidget {
  static const routeName = '/stationinfo';

  @override
  State<StatefulWidget> createState() => StationInfoState();
}

class StationInfoState extends State<StationInfo> {
  Icon favoriteIcon = Icon(
    Icons.favorite_border,
    size: 35,
  );
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

  bool sarted = true;

  @override
  void initState() {
    sarted = true;
  }

  @override
  Widget build(BuildContext context) {
    final Station station = ModalRoute.of(context).settings.arguments;
    if (sarted) {
      sarted = false;
      getfavoriteIcon(station.id.toString());
    }
    return Scaffold(
        appBar: AppBar(
            textTheme: TextTheme(title: TextStyle(fontSize: 22)),
            title: Text(station.stationName),
            elevation: 0.0,
            actions: <Widget>[
              // action button
              IconButton(
                padding: const EdgeInsets.only(right: 16.0),
                icon: favoriteIcon,
                onPressed: () {
                  setState(() {
                    if (favoriteIcon.icon == Icons.star) {
                      favoriteIcon = Icon(Icons.favorite_border, size: 35);
                      LocalDb.removefavoriteId(station.id.toString());
                    } else {
                      favoriteIcon = Icon(Icons.favorite, size: 35,);
                      LocalDb.setfavoriteId(station.id.toString());
                    }
                  });
                },
              ),
            ]),
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
          Expanded(
              child: GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: CameraPosition(
              target: LatLng(station.latitude, station.longitude),
              zoom: 16,
            ),
            onMapCreated: (c) => {
              setState(() {
                  final MarkerId markerId = MarkerId(station.id.toString());
                  final Marker marker = Marker(
                  markerId: markerId,
                  position: LatLng(
                    station.latitude,
                    station.longitude,
                  ),
                  infoWindow: InfoWindow(title: station.stationName, snippet: station.address)
                  );
                  markers[markerId] = marker;
                })  
            },
            markers: Set<Marker>.of(markers.values)
          ))
        ]));
  }

  void getfavoriteIcon(String id) {
    print("getfavoriteIcon" + id);
    LocalDb.containsFavoriteId(id).then((response) {
      print("resp " + response.toString());
      if (response) {
        setState(() {
          favoriteIcon = Icon(Icons.favorite, size: 35);
        });
      } else {
        setState(() {
          favoriteIcon = Icon(Icons.favorite_border, size: 35);
        });
      }
    });
  }
}
