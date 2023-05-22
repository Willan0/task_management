import 'package:flutter/material.dart';
import 'package:task_management/constant/color.dart';

import '../constant/dimen.dart';

class EasyIcon extends StatelessWidget {
  const EasyIcon({
    super.key,
    this.isClick = false,
    this.color = darkColor,
    required this.icon,
    required this.onPressed,
    this.size = kFi20x,
  });

  final bool isClick;
  final Color color;
  final IconData icon;
  final Function onPressed;
  final double size;
  @override
  Widget build(BuildContext context) {
    return isClick
        ? IconButton(
            color: color,
            iconSize: size,
            icon: Icon(icon),
            onPressed: () => onPressed(),
          )
        : Icon(
            icon,
            color: color,
            size: size,
          );
  }
}
