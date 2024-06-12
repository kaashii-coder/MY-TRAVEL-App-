import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomContainer extends StatelessWidget {
  const CustomContainer(
      {super.key, 
      this.height,
      this.width,
      required this.onTap,
      this.child,
      this.color});
  final VoidCallback onTap;
  final Widget? child;
  final double? height;
  final double? width;
  final Color? color;
 
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        height: height,
        width: width,
        padding: const EdgeInsets.only(left: 5,right: 8,top: 8,bottom: 5),
        decoration: BoxDecoration(
            color: color, borderRadius: const BorderRadius.all(Radius.circular(8))),
        child: child,
      ),
    );
  }
}
