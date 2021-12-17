
import 'package:flashinfo/routers/fluro_navigator.dart';
import 'package:flashinfo/util/device_utils.dart';
import 'package:flashinfo/util/other_utils.dart';
import 'package:flashinfo/widgets/icon_font.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HeaderShareRowWidget extends StatelessWidget {
  final Color? bgColor;
  final String? title;
  final int iconName;
  final String? iconUrl;
  final double? radius;
  final bool isVisible;
  final double leftMargin;
  const HeaderShareRowWidget(
      {Key? key,
        this.bgColor,
        this.title,
        required this.iconName,
        this.iconUrl,
        this.leftMargin = 8,
        required this.radius,
        this.isVisible = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    void _launchWebURL(String? title, String url, BuildContext context) {
      if (Device.isMobile) {
        NavigatorUtils.goWebViewPage(context, '', url);
      } else {
        Utils.launchWebURL(url);
      }
    }

    return Visibility(
      visible: isVisible,
      child: GestureDetector(
        onTap: () {
          _launchWebURL(title, iconUrl!, context);
        },
        child: Container(
          margin: EdgeInsets.only(left: leftMargin),
          child: IconFont(
            name: iconName,
            color: bgColor!,
            size: radius!.sp,
            isNewIcon: true,
          ),
        ),
      ),
    );
  }
}
