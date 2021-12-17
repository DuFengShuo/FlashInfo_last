import 'package:flashinfo/widgets/icon_font.dart';
import 'package:flutter/material.dart';
import 'package:flashinfo/res/resources.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ClickItem extends StatelessWidget {
  const ClickItem(
      {Key? key,
      this.onTap,
      required this.title,
      this.content = '',
      this.textAlign = TextAlign.start,
      this.maxLines = 1,
      this.iconName = 0,
      this.iconColor = Colours.app_main,
      this.titleStyle,
      this.contentStyle})
      : super(key: key);

  final GestureTapCallback? onTap;
  final String title;
  final TextStyle? titleStyle;
  final String content;
  final TextStyle? contentStyle;
  final TextAlign textAlign;
  final int maxLines;
  final int iconName;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    Widget child = Row(
      //为了数字类文字居中
      crossAxisAlignment:
          maxLines == 1 ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: <Widget>[
        if (iconName == 0)
          Gaps.empty
        else
          IconFont(name: iconName, size: 24.0.sp, color: iconColor),
        if (iconName == 0) Gaps.empty else Gaps.hGap12,
        Text(
          title,
          style: titleStyle ?? TextStyles.textSize14,
        ),
        const Spacer(),
        Gaps.hGap16,
        Expanded(
          flex: 4,
          child: Text(
            content,
            maxLines: maxLines,
            textAlign: maxLines == 1 ? TextAlign.right : textAlign,
            overflow: TextOverflow.ellipsis,
            style: contentStyle ??
                TextStyles.textGray10.copyWith(color: Colours.text_gray_c),
          ),
        ),
        if (onTap == null) Gaps.empty else Gaps.hGap8,
        Visibility(
          // 无点击事件时，隐藏箭头图标
          visible: onTap == null ? false : true,
          child: Padding(
            padding: EdgeInsets.only(top: maxLines == 1 ? 0.0 : 2.0),
            child: Images.arrowRight,
          ),
        )
      ],
    );

    /// 分隔线
    child = Container(
      padding: EdgeInsets.symmetric(
          horizontal: Dimens.gap_dp16, vertical: Dimens.gap_v_dp16),
      constraints: BoxConstraints(
        maxHeight: double.infinity,
        minHeight: 48.0.h,
      ),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colours.material_bg,
        border: Border(
          bottom: Divider.createBorderSide(context, width: 0.6),
        ),
      ),
      child: child,
    );

    return InkWell(
      onTap: onTap,
      child: child,
    );
  }
}
