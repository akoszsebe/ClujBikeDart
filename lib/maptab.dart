import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/foundation.dart';
import 'package:clujbikedart/model/station.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';

class MappTab extends StatefulWidget {
  final List<Station> data;

  MappTab(this.data);

  @override
  State<MappTab> createState() => _MappTabState(data);
}

class _MappTabState extends State<MappTab>{
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  List<Station> data;
  _MappTabState(List<Station> _data) {
    data =_data;
      
  }

  GoogleMapController  mapController;
  
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(46.769126, 23.588346),
    zoom: 12.4746,
  );

  


@override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: _kGooglePlex,
        onMapCreated: _onMapCreated,
        gestureRecognizers: Set()
        ..add(Factory<HorizontalDragGestureRecognizer>(() => HorizontalDragGestureRecognizer()))
        ..add(Factory<VerticalDragGestureRecognizer>(() => VerticalDragGestureRecognizer())),
       markers: Set<Marker>.of(markers.values)
      )
    );
  }

 void _onMapCreated(GoogleMapController  controller) {
    setState(() { mapController = controller; });
      data.forEach((element)=>{
      setState(() {
            final MarkerId markerId = MarkerId(element.id.toString());
            final Marker marker = Marker(
            markerId: markerId,
            position: LatLng(
              element.latitude,
              element.longitude,
            ),
            infoWindow: InfoWindow(title: element.stationName, snippet: element.address)
            );
            markers[markerId] = marker;
          })  
      });
 }
}