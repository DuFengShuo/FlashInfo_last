import 'package:flutter/material.dart';
import 'package:flashinfo/res/resources.dart';
import 'package:flashinfo/util/screen_utils.dart';
import 'package:flashinfo/widgets/icon_font.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchTabWidget extends StatefulWidget {
  const SearchTabWidget(
      {Key? key,
      required this.tabName,
      required this.selecd,
      this.onTap,
      required this.seleIcon,
      required this.tabLenght})
      : super(key: key);
  final String tabName;
  final bool selecd;
  final void Function()? onTap;
  final bool seleIcon;
  final int tabLenght;
  @override
  _SearchTabWidgetState createState() => _SearchTabWidgetState();
}

class _SearchTabWidgetState extends State<SearchTabWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10.0.h),
        color: Colours.material_bg,
        width: Screen.width(context) / widget.tabLenght,
        child: Row(
          children: [
            const Spacer(),
            Text(widget.tabName,
                style: widget.selecd
                    ? TextStyles.textSize12.copyWith(color: Colours.app_main)
                    : TextStyles.textGray12),
            Gaps.hGap8,
            IconFont(
                name: widget.seleIcon ? 0xe632 : 0xe633,
                size: 6.sp,
                color: widget.selecd ? Colours.app_main : Colours.text_gray_c),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
