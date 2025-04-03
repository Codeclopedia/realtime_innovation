import 'package:flutter/material.dart';
import 'package:realtime_innovation/core/utils/app_sizing.dart';

Widget buildTextField(
    IconData icon, String hintText, TextEditingController controller) {
  return TextFormField(
    controller: controller,
    style: TextStyle(fontSize: AppSizing.sp(15)),
    decoration: InputDecoration(
      prefixIcon: Icon(icon),
      hintText: hintText,
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizing.w(1))),
    ),
  );
}
