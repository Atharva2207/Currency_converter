// ignore_for_file: use_function_type_syntax_for_parameters

import 'package:flutter/material.dart';

Widget customDropDown(
  List<String>items,
  String value,
  void onChange(val)
){
  return Container(
    padding:  EdgeInsets.symmetric(vertical: 30.0,
    horizontal: 30.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(5.0)
    ),
    child: DropdownButton<String>(
      value: value,
      onChanged: (val) {
        onChange(val);
      },
      items: items.map<DropdownMenuItem<String>>((String val ) {
      return DropdownMenuItem(
                child: Text(val),
        value: val,
        );
        }
      ).toList())
      );
}