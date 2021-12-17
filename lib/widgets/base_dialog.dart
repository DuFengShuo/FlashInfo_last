import 'package:flutter/material.dart';
import 'package:flashinfo/res/resources.dart';
import 'package:flashinfo/routers/fluro_navigator.dart';
import 'package:flashinfo/util/device_utils.dart';
import 'package:flashinfo/widgets/my_button.dart';
import 'package:flashinfo/util/screen_utils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// 自定义dialog的模板
class BaseDialog extends StatelessWidget {
  const BaseDialog(
      {Key? key,
      this.title,
      this.onPressed,
      this.hiddenTitle = false,
      required this.child,
      this.leftTitle = 'Cancel',
      this.rightTitle = 'Confirm',
      this.textAlign = TextAlign.left,
      this.isBottomShow = false})
      : super(key: key);

  final String? title;
  final VoidCallback? onPressed;
  final Widget child;
  final bool hiddenTitle;
  final String leftTitle;
  final String rightTitle;
  final TextAlign textAlign;
  final bool isBottomShow;
  @override
  Widget build(BuildContext context) {
    final Widget dialogTitle = Visibility(
      visible: !hiddenTitle,
      child: Padding(
        padding: EdgeInsets.all(24.w),
        child: Text(
          hiddenTitle ? '' : title ?? '',
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyles.textBold18.copyWith(fontWeight: FontWeight.bold),
        ),
      ),
    );

    final Widget bottomButton = Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        GestureDetector(
          onTap: () => NavigatorUtils.goBack(context),
          child: Container(
            alignment: Alignment.center,
            width: 136.w,
            height: 44.h,
            decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colours.bg_color),
                borderRadius: BorderRadius.all(Radius.circular(44.h))),
            child: Text(
              '$leftTitle',
              style: TextStyles.text,
            ),
          ),
        ),
        _DialogButton(
          text: rightTitle,
          textColor: Colours.material_bg,
          onPressed: onPressed,
        ),
      ],
    );

    final Widget content = Material(
      borderRadius: BorderRadius.circular(20.0.r),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          dialogTitle,
          Flexible(child: child),
          Gaps.vGap24,
          bottomButton,
          Gaps.vGap24,
        ],
      ),
    );

    final Widget body = MediaQuery.removeViewInsets(
      removeLeft: true,
      removeTop: true,
      removeRight: true,
      removeBottom: true,
      context: context,
      child: isBottomShow
          ? Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              margin: EdgeInsets.only(top: 250.h),
              child: content,
            )
          : Center(
              child: SizedBox(
                width: context.width - 32.w,
                child: content,
              ),
            ),
    );

    /// Android 11添加了键盘弹出动画，这与我添加的过渡动画冲突（原先iOS、Android 没有相关过渡动画，相关问题跟踪：https://github.com/flutter/flutter/issues/19279）。
    /// 因为在Android 11上，viewInsets的值在键盘弹出过程中是变化的（以前只有开始结束的值）。
    /// 所以解决方法就是在Android 11及以上系统中使用Padding代替AnimatedPadding。

    if (Device.getAndroidSdkInt() >= 30) {
      return Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: body,
      );
    } else {
      return AnimatedPadding(
        padding: MediaQuery.of(context).viewInsets,
        duration: const Duration(milliseconds: 120),
        curve: Curves.easeInCubic, // easeOutQuad
        child: body,
      );
    }
  }
}

class _DialogButton extends StatelessWidget {
  const _DialogButton({
    Key? key,
    required this.text,
    this.textColor,
    this.onPressed,
    this.backgroundColor,
  }) : super(key: key);

  final String text;
  final Color? textColor;
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 136.w,
      height: 44.h,
      child: MyButton(
        text: text,
        radius: 44.h,
        fontSize: Dimens.font_sp12,
        backgroundColor: backgroundColor,
        textColor: textColor,
        onPressed: onPressed,
      ),
    );
  }
}
