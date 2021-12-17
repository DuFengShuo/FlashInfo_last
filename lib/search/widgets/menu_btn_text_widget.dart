import 'package:flashinfo/res/resources.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MenuBtnTextWidget extends StatelessWidget {
  const MenuBtnTextWidget(
      {Key? key,
      required this.selectTitle,
      required this.text,
      required this.minWidth,
      this.onTap})
      : super(key: key);
  final String selectTitle;
  final String text;
  final double minWidth;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
        onTap!();
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 5.0.h, horizontal: 10.0.w),
        constraints: BoxConstraints(minWidth: minWidth),
        decoration: BoxDecoration(
          color: text == selectTitle ? Colours.app_main : Colours.bg_color,
          borderRadius: BorderRadius.circular(5.0.w),
        ),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyles.textSize12.copyWith(
            color: text == selectTitle ? Colours.material_bg : Colours.text,
          ),
        ),
      ),
    );
  }
}
