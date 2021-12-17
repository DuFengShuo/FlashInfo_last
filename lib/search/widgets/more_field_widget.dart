import 'package:flashinfo/res/resources.dart';
import 'package:flashinfo/util/input_formatter/number_text_input_formatter.dart';
import 'package:flashinfo/widgets/icon_font.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MoreFieldWidget extends StatelessWidget {
  const MoreFieldWidget({
    Key? key,
    this.hintText,
    this.onSubmitted,
    this.onChanged,
    this.controller,
    this.isText = false,
    this.onCleanTap,
  }) : super(key: key);
  final String? hintText;
  final void Function(String)? onSubmitted;
  final void Function(String)? onChanged;
  final TextEditingController? controller;
  final void Function()? onCleanTap;
  final bool isText;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 60.w,
          height: 17.h,
          decoration: BoxDecoration(
            color: isText ? Colours.app_main : Colours.bg_color,
            borderRadius: BorderRadius.circular(2.0),
          ),
          child: TextField(
            key: const Key('fund_input'),
            controller: controller,
            maxLines: 1,
            cursorColor: isText ? Colours.material_bg : Colours.app_main,
            style: TextStyles.textSize13.copyWith(
              color: isText ? Colours.material_bg : Colours.text,
            ),
            textAlign: TextAlign.center,
            // ignore: use_named_constants
            keyboardType: const TextInputType.numberWithOptions(decimal: false),
            // 金额限制数字格式
            inputFormatters: [UsNumberTextInputFormatter(max: 10000)],

            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(
                  top: 0.h, left: 0.0.w, right: 0.0.w, bottom: 0.0),
              isDense: true,
              border: InputBorder.none,
              hintText: hintText,
              hintStyle: TextStyles.textSize13.copyWith(
                color: Colours.text_gray_c,
              ),
            ),
            onChanged: onSubmitted,
            onSubmitted: onSubmitted,
          ),
        ),
        Visibility(
          visible: true,
          child: InkWell(
            onTap: () {
              FocusManager.instance.primaryFocus?.unfocus();
              controller!.clear();
              onCleanTap!();
            },
            child: SizedBox(
              width: 22.sp,
              child: IconFont(
                name: 0xe634,
                size: 12.sp,
                color: isText ? Colours.material_bg : Colours.text_gray_c,
              ),
            ),
          ),
        )
      ],
    );
  }
}

class TextIconBtn extends StatelessWidget {
  const TextIconBtn(
      {Key? key,
      this.selectTap,
      required this.selectIcon,
      required this.text,
      this.isYear = true,
      this.hitText = ''})
      : super(key: key);
  final void Function()? selectTap;
  final void Function()? selectIcon;
  final String text;
  final String hitText;
  final bool isYear;
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
          selectTap!();
        },
        child: Row(
          children: [
            Text(
              text == '0' ? hitText : text,
              textAlign: TextAlign.center,
              style: TextStyles.textSize12.copyWith(
                color: text == '0' ? Colours.text_gray_c : Colours.material_bg,
              ),
            ),
            if (isYear) Gaps.hGap15 else Gaps.empty,
            Visibility(
              visible: true,
              child: InkWell(
                onTap: selectIcon,
                child: Container(
                  color: Colors.transparent,
                  width: 22.sp,
                  child: IconFont(
                    name: 0xe634,
                    size: 12.sp,
                    color:
                        text == '0' ? Colours.text_gray_c : Colours.material_bg,
                  ),
                ),
              ),
            )
          ],
        ));
  }
}
