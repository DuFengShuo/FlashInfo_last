import 'package:flashinfo/res/resources.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MenuButtonWidget extends StatelessWidget {
  const MenuButtonWidget({Key? key, this.onClearTap, this.onConfirmTap})
      : super(key: key);
  final void Function()? onClearTap;
  final void Function()? onConfirmTap;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colours.material_bg,
      padding: EdgeInsets.symmetric(horizontal: 10.0.h, vertical: 10.0.h),
      width: double.infinity,
      child: Row(
        children: [
          Expanded(
            child: InkWell(
              onTap: () {
                FocusManager.instance.primaryFocus?.unfocus();
                onClearTap!();
              },
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colours.text_gray_c,
                  borderRadius: BorderRadius.circular(7.w),
                ),
                height: 40.h,
                child: Text(
                  'Clear',
                  style: TextStyles.textSize14
                      .copyWith(color: Colours.material_bg),
                ),
              ),
            ),
          ),
          Gaps.hGap10,
          Gaps.hGap10,
          Expanded(
            child: InkWell(
              onTap: () {
                FocusManager.instance.primaryFocus?.unfocus();
                onConfirmTap!();
              },
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colours.app_main,
                  borderRadius: BorderRadius.circular(7.w),
                ),
                height: 40.h,
                child: Text(
                  'Confirm',
                  style: TextStyles.textSize14
                      .copyWith(color: Colours.material_bg),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
