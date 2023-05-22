import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:task_management/constant/color.dart';
import 'package:task_management/constant/dimen.dart';
import 'package:task_management/widgets/easy_text.dart';

class ResualbeTaskView extends StatelessWidget {
  const ResualbeTaskView(
      {super.key,
      required this.lable,
      required this.hintText,
      required this.validate,
      this.textEditingController,
      this.widget});

  final String lable;
  final TextEditingController? textEditingController;
  final Widget? widget;
  final Function(String value) validate;
  final String hintText;
  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Get.isDarkMode;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        EasyText(
          text: lable,
          fontColor: isDarkMode ? whiteColor : darkColor,
          fontSize: kFi18x,
        ),
        const SizedBox(
          height: kMp10x,
        ),
        Container(
          padding: const EdgeInsets.only(left: kMp10x),
          decoration: BoxDecoration(
              border: Border.all(color: isDarkMode ? whiteColor : darkColor),
              borderRadius: const BorderRadius.all(Radius.circular(kRi10x))),
          child: Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: textEditingController,
                  validator: (value) => validate(value ?? ''),
                  autofocus: false,
                  cursorColor: isDarkMode ? borderColorDark : borderColorLight,
                  readOnly: widget == null ? false : true,
                  style: TextStyle(
                      color: isDarkMode ? Colors.grey[200] : Colors.grey[800]),
                  decoration: InputDecoration(
                    hintText: hintText,
                    hintStyle: const TextStyle(fontSize: kFi15x),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: context.theme.colorScheme.background,
                          width: 0),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: context.theme.colorScheme.background,
                          width: 0),
                    ),
                  ),
                ),
              ),
              widget ?? const SizedBox()
            ],
          ),
        ),
        const SizedBox(
          height: kMp20x,
        )
      ],
    );
  }
}
