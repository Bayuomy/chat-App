import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class CustomTextFild extends StatelessWidget {
  CustomTextFild(
      {required this.hinttext, required this.obscureText, this.onChanged});
  Function(String)? onChanged;
  String hinttext;
  bool obscureText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (data) {
        if (data!.isEmpty) {
          return 'field is required';
        }
      },
      keyboardType: TextInputType.emailAddress,
      onChanged: onChanged,
      obscureText: obscureText,
      decoration: InputDecoration(
          hintText: hinttext,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(50)))),
    );
  }
}
