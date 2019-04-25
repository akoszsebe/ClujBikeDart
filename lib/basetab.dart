import 'package:flutter/material.dart';
import 'package:hello_flutter/model/station.dart';
import 'package:hello_flutter/utils/colors.dart';
import 'package:hello_flutter/main.dart';

class BaseTab extends StatelessWidget {
  MyAppState myAppState;

  BaseTab(List<Station> _data, MyAppState _myAppState) {
    data = _data;
    myAppState = _myAppState;
  }

  List<Station> data;

  Widget _buildListItem(BuildContext context, int index) {
    return Row(
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
                        backgroundColor: colorSelector(data[index].statusType),
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
                    "Parking" + data[index].emptySpots.toString(),
                    style: TextStyle(color: Colors.grey),
                    textScaleFactor: 1.1,
                  )
                ]),
          ),
        ]);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: RefreshIndicator(
          onRefresh: _refreshStockPrices,
          child: ListView.separated(
      separatorBuilder: (context, index) => Divider(color: Colors.grey),
      itemBuilder: _buildListItem,
      itemCount: data.length,
    )));
  }

  Future<Null> _refreshStockPrices() async
  {
    print('refreshing stocks...');  
    myAppState.getData();
  }

  Color colorSelector(StatusType s) {
    switch (s) {
      case StatusType.ONLINE:
        return ColorUtils.colorActive;
      case StatusType.OFFLINE:
        return Colors.grey;
      case StatusType.SUBPOPULATED:
        return Colors.blue;
      case StatusType.SUPRAPOPULATED:
        return Colors.red;
    }
  }
}
