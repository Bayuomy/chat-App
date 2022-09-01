import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class Custom_button extends StatelessWidget {
  Custom_button({required this.text, this.ontap});
  String text;
  VoidCallback? ontap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          width: double.infinity,
          height: 50,
          child: Center(
            child: Text(text),
          ),
        ),
      ),
    );
  }
}
