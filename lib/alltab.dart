import 'package:flutter/material.dart';
import 'package:hello_flutter/model/station.dart';

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
          child: CircleAvatar(backgroundColor: Colors.green),
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
            Text(data[index].ocuppiedSpots.toString(), style: TextStyle(color: Colors.black)),
            Text(data[index].emptySpots.toString(), style: TextStyle(color: Colors.black))
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

}