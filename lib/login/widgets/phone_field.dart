import 'package:flashinfo/login/widgets/my_text_field.dart';
import 'package:flashinfo/res/resources.dart';
import 'package:flashinfo/widgets/icon_font.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PhoneField extends StatelessWidget {
  const PhoneField(
      {Key? key,
      required this.phoneController,
      this.nodeText,
      this.areaCode,
      this.onTapAreaCode})
      : super(key: key);

  final TextEditingController phoneController;
  final FocusNode? nodeText;
  final int? areaCode;
  final void Function()? onTapAreaCode;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: onTapAreaCode,
          child: Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: Divider.createBorderSide(context, width: 0.8),
              ),
            ),
            width: 60.0.w,
            height: 48.0,
            child: Row(
              children: [
                Text('+' + areaCode.toString()),
                Gaps.hGap4,
                IconFont(name: 0xe61a, size: 6.0.w, color: Colours.text),
              ],
            ),
          ),
        ),
        Expanded(
          child: MyTextField(
            focusNode: nodeText,
            controller: phoneController,
            maxLength: 11,
            keyboardType: TextInputType.number,
            hintText: 'Phone Number',
          ),
        ),
      ],
    );
  }
}
