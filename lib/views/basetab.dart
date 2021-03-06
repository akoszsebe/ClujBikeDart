import 'package:flutter/material.dart';
import 'package:clujbikedart/model/station.dart';
import 'package:clujbikedart/utils/colors.dart';
import 'package:clujbikedart/views/home.dart';
import 'package:clujbikedart/views/stationinfo.dart';
import 'package:url_launcher/url_launcher.dart';

class BaseTab extends StatelessWidget {
  final HomePageState myAppState;
  final List<Station> data;

  BaseTab(this.data, this.myAppState);

  Widget _buildListItem(BuildContext context, int index) {
    return InkWell(
        onTap: () {
          Navigator.pushNamed(context, StationInfo.routeName,
              arguments: data[index]);
        },
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(16.0),
                        child: CircleAvatar(
                            backgroundColor:
                                _colorSelector(data[index].statusType),
                            radius: 13.0),
                      ),
                      Container(
                          width: 200,
                          child: Text(
                            data[index].stationName,
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.normal,
                                fontSize: 23.0),
                            maxLines: 2,
                          ))
                    ],
                  ),
                  Container(
                      padding: EdgeInsets.only(left: 16.0),
                      width: 230,
                      child: Text(
                        data[index].address,
                        style: TextStyle(color: Colors.grey),
                        maxLines: 2,
                      ))
                ],
              ),
              Container(
                padding: EdgeInsets.only(right: 16.0),
                height: 70,
                child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      GestureDetector(
                          onTap: () {
                           _openMap(data[index].latitude,data[index].longitude);
                          },
                          child: Image.asset("assets/images/map_icon.png",
                              width: 25)),
                      Text("Bikes " + data[index].ocuppiedSpots.toString(),
                          style: TextStyle(color: Colors.grey),
                          textScaleFactor: 1.1),
                      Text(
                        "Parking " + data[index].emptySpots.toString(),
                        style: TextStyle(color: Colors.grey),
                        textScaleFactor: 1.1,
                      )
                    ]),
              ),
            ]));
  }

  void _openMap(double lat,double lon) async {
    String url = 'https://www.google.com/maps/search/?api=1&query=${lat},${lon}';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Expanded(
              child: RefreshIndicator(
                  onRefresh: _refreshStockPrices,
                  child: ListView.separated(
                    separatorBuilder: (context, index) =>
                        Divider(color: Colors.grey),
                    itemBuilder: _buildListItem,
                    itemCount: data.length,
                  )))
        ]);
  }

  Future<Null> _refreshStockPrices() async {
    print('refreshing stocks...');
    myAppState.getData();
  }

  Color _colorSelector(StatusType s) {
    switch (s) {
      case StatusType.ONLINE:
        return ColorUtils.colorActive;
      case StatusType.OFFLINE:
        return ColorUtils.colorOffline;
      case StatusType.SUBPOPULATED:
        return ColorUtils.colorUnderpopulated;
      case StatusType.SUPRAPOPULATED:
        return ColorUtils.colorSuprapopulated;
    }
    return ColorUtils.colorNotWorking;
  }
}
