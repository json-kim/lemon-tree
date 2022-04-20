import 'package:flutter/material.dart';

final formDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
  enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: Colors.black)),
  border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: Colors.black)),
  errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: Colors.black)),
  focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: Colors.red)),
  focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: Colors.greenAccent)),
  labelStyle: TextStyle(color: Colors.black, fontSize: 14),
  fillColor: Colors.white10,
  filled: true,
);
