import 'package:flutter/material.dart';
import 'package:lemon_tree/presentation/constants/colors.dart';

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
      borderSide: BorderSide(color: mainGreen)),
  labelStyle: TextStyle(color: Colors.black, fontSize: 14),
  fillColor: Colors.white10,
  filled: true,
);

final addFormDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
  enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: Colors.transparent)),
  border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: Colors.transparent)),
  errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: Colors.transparent)),
  focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: Colors.white)),
  focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: Colors.white)),
  labelStyle: TextStyle(color: Colors.black, fontSize: 14),
  errorStyle: TextStyle(color: Colors.yellowAccent),
  fillColor: Colors.white10,
  filled: true,
);
