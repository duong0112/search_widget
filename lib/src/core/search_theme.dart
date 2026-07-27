import 'package:flutter/material.dart';

class SearchThemeData {
  final Color backgroundColor;

  final Color borderColor;

  final Color selectedColor;

  final Color hoverColor;

  final Color textColor;

  final double borderRadius;

  final double elevation;

  const SearchThemeData({
    this.backgroundColor = Colors.white,
    this.borderColor = Colors.grey,
    this.selectedColor =
    const Color(0xFFE3F2FD),
    this.hoverColor =
    const Color(0xFFF5F5F5),
    this.textColor = Colors.black,
    this.borderRadius = 8,
    this.elevation = 6,
  });
}