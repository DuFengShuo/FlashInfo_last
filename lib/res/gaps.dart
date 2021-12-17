import 'package:flashinfo/res/resources.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flashinfo/util/theme_utils.dart';

/// 间隔
/// 官方做法：https://github.com/flutter/flutter/pull/54394
class Gaps {
  /// 水平间隔
  static Widget hGap4 = SizedBox(width: Dimens.gap_dp4);
  static Widget hGap5 = SizedBox(width: Dimens.gap_dp5);
  static Widget hGap6 = SizedBox(width: Dimens.gap_dp6);
  static Widget hGap8 = SizedBox(width: Dimens.gap_dp8);
  static Widget hGap10 = SizedBox(width: Dimens.gap_dp10);
  static Widget hGap12 = SizedBox(width: Dimens.gap_dp12);
  static Widget hGap15 = SizedBox(width: Dimens.gap_dp15);
  static Widget hGap16 = SizedBox(width: Dimens.gap_dp16);
  static Widget hGap17 = SizedBox(width: Dimens.gap_dp17);
  static Widget hGap18 = SizedBox(width: Dimens.gap_dp18);
  static Widget hGap19 = SizedBox(width: Dimens.gap_dp19);
  static Widget hGap20 = SizedBox(width: Dimens.gap_dp20);
  static Widget hGap120 = SizedBox(width: Dimens.gap_dp20);

  static Widget hGap32 = SizedBox(width: Dimens.gap_dp32);

  /// 垂直间隔
  static Widget vGap4 = SizedBox(height: Dimens.gap_v_dp4);
  static Widget vGap5 = SizedBox(height: Dimens.gap_v_dp5);
  static Widget vGap8 = SizedBox(height: Dimens.gap_v_dp8);
  static Widget vGap10 = SizedBox(height: Dimens.gap_v_dp10);
  static Widget vGap12 = SizedBox(height: Dimens.gap_v_dp12);
  static Widget vGap15 = SizedBox(height: Dimens.gap_v_dp15);
  static Widget vGap16 = SizedBox(height: Dimens.gap_v_dp16);
  static Widget vGap17 = SizedBox(height: Dimens.gap_v_dp17);
  static Widget vGap18 = SizedBox(height: Dimens.gap_v_dp18);
  static Widget vGap19 = SizedBox(height: Dimens.gap_v_dp19);
  static Widget vGap20 = SizedBox(height: Dimens.gap_v_dp20);
  static Widget vGap24 = SizedBox(height: Dimens.gap_v_dp24);
  static Widget vGap32 = SizedBox(height: Dimens.gap_v_dp32);
  static Widget vGap50 = SizedBox(height: Dimens.gap_v_dp50);

  static Widget lineV = SizedBox(
    height: Dimens.gap_v_dp5,
    width: double.infinity,
    child: const LineMargin(),
  );

  static Widget line = Divider(
    height: Dimens.gap_v_dp1,
    color: Colours.line,
  );

  static Widget vLine = SizedBox(
    width: Dimens.gap_dp1,
    height: Dimens.gap_v_dp24,
    child: const VerticalDivider(),
  );

  static const Widget empty = SizedBox.shrink();
}

class LineMargin extends StatelessWidget {
  const LineMargin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
        decoration: BoxDecoration(
            color:
                context.isDark ? Colours.dark_line : const Color(0xFFF5F5F7)));
  }
}
