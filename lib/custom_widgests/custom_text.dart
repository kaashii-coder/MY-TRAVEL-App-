import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final Color? color;
  final double? size;
  final FontWeight? fontweight;
  const CustomText( {super.key, required this.text, this.size, this.color,this.fontweight});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(fontSize: size, color: color,fontWeight:fontweight ),
    );
  }
}
