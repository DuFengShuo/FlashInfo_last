import 'dart:ui';

import 'package:common_utils/common_utils.dart';
import 'package:flashinfo/common/common.dart';
import 'package:flutter/material.dart';
import 'package:flashinfo/util/theme_utils.dart';
import 'package:flashinfo/util/toast_utils.dart';
import 'package:keyboard_actions/keyboard_actions_item.dart';
import 'package:keyboard_actions/keyboard_actions_config.dart';
import 'package:sp_util/sp_util.dart';
import 'package:url_launcher/url_launcher.dart';

class Utils {
  /// 打开链接
  static Future<void> launchWebURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      Toast.show('Failed to open link！');
    }
  }

  /// 调起拨号页
  static Future<void> launchTelURL(String phone) async {
    final String url = 'tel:' + phone.replaceAll(new RegExp(r'\s+\b|\b\s'), '');
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      Toast.show('Dial-up failure！');
    }
  }

  static String formatPrice(String price,
      {MoneyFormat format = MoneyFormat.END_INTEGER}) {
    return MoneyUtil.changeYWithUnit(
        NumUtil.getDoubleByValueStr(price) ?? 0, MoneyUnit.YUAN,
        format: format);
  }

  static KeyboardActionsConfig getKeyboardActionsConfig(
      BuildContext context, List<FocusNode> list) {
    return KeyboardActionsConfig(
      keyboardBarColor: ThemeUtils.getKeyboardActionsColor(context),
      nextFocus: true,
      actions: List.generate(
          list.length,
          (i) => KeyboardActionsItem(
                focusNode: list[i],
                toolbarButtons: [
                  (node) {
                    return GestureDetector(
                      onTap: () => node.unfocus(),
                      child: const Padding(
                        padding: EdgeInsets.only(right: 16.0),
                        child: Text('Close'),
                      ),
                    );
                  },
                ],
              )),
    );
  }

  static String? getCurrLocale() {
    final String locale = SpUtil.getString(Constant.locale)!;
    if (locale == '') {
      return window.locale.languageCode;
    }
    return locale;
  }

  static List<String> maopaoList(List<String> list) {
    final List<String> array = [...list];
    for (var i = 0; i < array.length - 1; i++) {
      for (var j = 0; j < array.length - 1 - i; j++) {
        if (array[j].length > array[j + 1].length) {
          final String temp = array[j];
          array[j] = array[j + 1];
          array[j + 1] = temp;
        }
      }
    }
    return array;
  }

  /// 邮箱正则
  static String regexEmail =
      // ignore: use_raw_strings
      '^\\w+([-+.]\\w+)*@\\w+([-.]\\w+)*\\.\\w+([-.]\\w+)*\$';

  /// 检查是否是邮箱格式
  static bool isEmail(String input) {
    if (input == null || input.isEmpty) return false;
    return new RegExp(regexEmail).hasMatch(input);
  }

  bool textExceedMaxLines(
      String text, TextStyle textStyle, int maxLine, double maxWidth) {
    final TextSpan textSpan = TextSpan(text: text, style: textStyle);
    final TextPainter textPainter = TextPainter(
        text: textSpan, maxLines: maxLine, textDirection: TextDirection.ltr);
    textPainter.layout(maxWidth: maxWidth);
    print(textPainter.height);
    if (textPainter.didExceedMaxLines) {
      return true;
    }
    return false;
  }
}

Future<T?> showElasticDialog<T>({
  required BuildContext context,
  bool barrierDismissible = true,
  required WidgetBuilder builder,
}) {
  return showGeneralDialog(
    context: context,
    pageBuilder: (BuildContext buildContext, Animation<double> animation,
        Animation<double> secondaryAnimation) {
      final Widget pageChild = Builder(builder: builder);
      return SafeArea(
        child: pageChild,
      );
    },
    barrierDismissible: barrierDismissible,
    barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
    barrierColor: Colors.black54,
    transitionDuration: const Duration(milliseconds: 550),
    transitionBuilder: _buildDialogTransitions,
  );
}

Widget _buildDialogTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child) {
  return FadeTransition(
    opacity: CurvedAnimation(
      parent: animation,
      curve: Curves.easeOut,
    ),
    child: SlideTransition(
      position: Tween<Offset>(begin: const Offset(0.0, 0.3), end: Offset.zero)
          .animate(CurvedAnimation(
        parent: animation,
        curve: const ElasticOutCurve(0.85),
        reverseCurve: Curves.easeOutBack,
      )),
      child: child,
    ),
  );
}

/// String 空安全处理
extension StringExtension on String? {
  String get nullSafe => this ?? '';
}
