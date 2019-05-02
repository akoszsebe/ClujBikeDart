import 'package:flutter/material.dart';
import 'package:clujbikedart/utils/colors.dart';

class FilterItem extends StatelessWidget {
  final void Function(String) listener;
  final bool isSearchVisible;

  const FilterItem({this.listener, this.isSearchVisible});

  @override
  Widget build(BuildContext context) {
    return Visibility(
        visible: isSearchVisible,
        child: TextField(
          onChanged: (text) {
            listener(text);
          },
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
              contentPadding: EdgeInsets.all(24),
              fillColor: ColorUtils.colorGray,
              filled: true,
              hintText: 'Please enter a search term',
              hintStyle: TextStyle(color: Colors.white30)),
        ));
  }
}
