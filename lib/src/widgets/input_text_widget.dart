import 'package:flutter/material.dart';
import 'package:search_widget_v2/src/core/color_custom.dart';

class SearchInput extends StatelessWidget {
  const SearchInput({super.key, required this.controller, required this.focusNode, required this.hintText, required this.border, required this.borderFocus});

  final TextEditingController controller;
  final FocusNode focusNode;
  final String hintText;
  final InputBorder? border;
  final InputBorder? borderFocus;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      focusNode: focusNode,
      decoration: InputDecoration(
        hintText: hintText,
        suffixIcon: Container(
          margin: EdgeInsets.only(right: 4),
          padding: EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.blue.withOpacityAlpha(0.20),
            borderRadius: BorderRadius.circular(18),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [SizedBox(width: 6), Text("Search"), SizedBox(width: 4), Icon(Icons.search, size: 18)],
          ),
        ),
        border: border,
        enabledBorder: border,
        focusedBorder: borderFocus ?? border,
      ),
    );
  }
}
