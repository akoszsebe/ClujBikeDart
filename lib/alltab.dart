import 'package:flutter/material.dart';
import 'package:hello_flutter/model/station.dart';
import 'utils/colors.dart';

class AllTab extends StatelessWidget {

  AllTab(List<Station> _data) {
    data = _data;
  }

List<Station> data;

Widget _buildProductItem(BuildContext context, int index) {
    return Card(
      margin: new EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
      child: Container(
        decoration: BoxDecoration(color: Colors.white),
        child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        leading: Container(
          padding: EdgeInsets.only(right: 12.0),
          child: CircleAvatar(backgroundColor: colorSelector(data[index].statusType)),
        ),
        title: Text(
          data[index].stationName,
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        subtitle: Row(
          children: <Widget>[
            Text(data[index].address, style: TextStyle(color: Colors.black))
          ],
        ),
        trailing: Column(
          children: <Widget>[
            Icon(Icons.map),
            Text("Bikes " + data[index].ocuppiedSpots.toString(), style: TextStyle(color: Colors.black)),
            Text("Parking" + data[index].emptySpots.toString(), style: TextStyle(color: Colors.black))
          ]),
      ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: _buildProductItem,
      itemCount: data.length,
    );
  }


  Color colorSelector(StatusType s){
    switch(s){
      case StatusType.ONLINE:
      return ColorUtils.colorActive;
      case StatusType.OFFLINE:
      return Colors.grey;
      case StatusType.Subpopulated:
      return Colors.blue;
      case StatusType.Suprapopulated:
      return Colors.red;
    }
  }

}