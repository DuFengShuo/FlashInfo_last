import 'package:flashinfo/res/resources.dart';
import 'package:flashinfo/widgets/load_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LogoContainerWidget extends StatelessWidget {
  const LogoContainerWidget({
    Key? key,
    required this.child,
    this.radius = 0.00,
  }) : super(key: key);
  final Widget child;
  final double radius;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colours.bg_color,
          borderRadius: BorderRadius.all(Radius.circular(radius.r))),
      child: Stack(
        children: [
          Wrap(
            children: _logoWidget(),
          ),
          child,
        ],
      ),
    );
  }

  List<Widget> _logoWidget() {
    final List<Widget> arr = [];
    for (var i = 0; i < 100; i++) {
      arr.add(Container(
        padding: EdgeInsets.symmetric(vertical: 40.h),
        transform: Matrix4.rotationZ(-0.3),
        child: LoadAssetImage(
          'dashboard/dashboard_logo',
          color: const Color.fromRGBO(34, 34, 34, 0.1),
          width: 112.w,
          height: 26.h,
        ),
      ));
    }

    return arr;
  }
}
