import 'package:flutter/material.dart';

class HexColor extends Color {
  HexColor(final String hexColor) 
    : super(int.parse(hexColor.replaceAll("#", "").padLeft(8, 'F'), radix: 16));
}