import 'package:flutter/material.dart';
import 'package:fun_files/constant.dart';
class TextInputField extends StatelessWidget {
  final String labeltext;
  final TextEditingController controller;
  final bool isobsecure;
  final IconData icon;

  const TextInputField({
    Key?key,
    required this.labeltext,
    required this.controller,
    this.isobsecure=false,
    required this.icon
  }):super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText:labeltext,
        prefixIcon: Icon(icon),
        labelStyle: const TextStyle(fontSize: 20),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(7),
          borderSide: const BorderSide(
            color: borderColor,
          )
        ),
      ),
      obscureText: isobsecure,
    );
  }
}
