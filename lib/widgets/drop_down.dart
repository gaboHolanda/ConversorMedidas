import 'package:flutter/material.dart';

Widget customDropDown(
    List<String> _items,
    String _value,
    void onChange(val)
  ){
  return Container(
    padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 18.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8.0)
    ),
    child: DropdownButton(
      items: _items.map((String item) => DropdownMenuItem<String>(child: Text(item), value: item)).toList(),
      onChanged: (String? value) {
        onChange(value);
      },
      value: _value,
    ),
  );
}