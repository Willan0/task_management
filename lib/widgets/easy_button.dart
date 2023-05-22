import 'package:flutter/material.dart';
import 'package:task_management/constant/color.dart';
import 'package:task_management/constant/dimen.dart';
import 'package:task_management/widgets/easy_text.dart';

class EasyButton extends StatelessWidget {
  const EasyButton({Key? key,this.width = kWh120x,required this.onPressed,required this.label,this.color, this.labelColor}) : super(key: key);

  final Function onPressed;
  final String label;
  final double width;
  final Color? labelColor;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      minWidth: width,
      color: color ?? bluishColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(kRi10x))
      ),
      height: kWh50x,
        onPressed: ()=> onPressed(),
      child: EasyText(text: label,fontSize: kFi18x,fontColor: labelColor ?? darkColor,fontWeight: FontWeight.w700,)
    );
  }
}
