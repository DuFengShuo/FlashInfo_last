import 'package:flutter/material.dart';
import 'package:flashinfo/res/colors.dart';
import 'package:flashinfo/util/theme_utils.dart';

class MyCard extends StatelessWidget {
  const MyCard({Key? key, required this.child, this.color, this.shadowColor})
      : super(key: key);

  final Widget child;
  final Color? color;
  final Color? shadowColor;

  @override
  Widget build(BuildContext context) {
    final bool isDark = context.isDark;

    final Color _backgroundColor =
        color ?? (isDark ? Colours.dark_bg_gray_ : Colors.white);
    final Color _shadowColor =
        isDark ? Colors.transparent : (shadowColor ?? const Color(0xffDDDDDD));

    return DecoratedBox(
      decoration: BoxDecoration(
        color: _backgroundColor,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: _shadowColor,
              offset: const Offset(0.0, 2.0),
              blurRadius: 8.0,
              spreadRadius: 0.0),
        ],
      ),
      child: child,
    );
  }
}
