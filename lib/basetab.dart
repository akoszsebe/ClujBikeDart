import 'package:flutter/material.dart';
import 'package:hello_flutter/model/station.dart';
import 'package:hello_flutter/utils/colors.dart';
import 'package:hello_flutter/main.dart';
import 'package:hello_flutter/stationinfo.dart';

class BaseTab extends StatelessWidget {
  final MyAppState myAppState;
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
                                colorSelector(data[index].statusType),
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
                      Image.asset("assets/images/map_icon.png", width: 25),
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
                  ))),
          Visibility(
              visible: myAppState.isSearchVisible,
              child: TextField(
                onChanged: (text) {
                  print("First text field: $text");
                  myAppState.filterdata(text);
                },
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(24),                    
                    fillColor: ColorUtils.colorGray,
                    filled: true,
                    hintText: 'Please enter a search term',hintStyle: TextStyle(color: Colors.white30)),
              ))
        ]);
  }

  Future<Null> _refreshStockPrices() async {
    print('refreshing stocks...');
    myAppState.getData();
  }

  Color colorSelector(StatusType s) {
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
