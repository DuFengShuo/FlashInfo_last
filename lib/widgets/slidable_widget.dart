import 'package:flashinfo/res/colors.dart';
import 'package:flashinfo/widgets/icon_font.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SlidableWidget extends StatelessWidget {
  const SlidableWidget(
      {Key? key,
      required this.index,
      required this.slidableController,
      required this.child,
      this.onTap,
      this.onTapDele})
      : super(key: key);
  final int index;
  final Widget child;
  final void Function()? onTap;
  final void Function()? onTapDele;
  // 保留一个Slidable打开
  final SlidableController slidableController;
  @override
  Widget build(BuildContext context) {
    // 侧滑删除
    return Slidable(
      key: Key(index.toString()),
      controller: slidableController,
      actionPane: const SlidableDrawerActionPane(),
      actionExtentRatio: 0.20,

      ///右侧的action
      secondaryActions: <Widget>[
        SlideAction(
          child: Container(
            width: 72.0,
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child:
                IconFont(name: 0xe60a, size: 18.sp, color: Colours.material_bg),
          ),
          color: Theme.of(context).errorColor,
          onTap: onTapDele,
        ),
      ],
      child: InkWell(
        onTap: () {
          // / 如果侧滑菜单打开，关闭侧滑菜单。否则跳转
          if (slidableController.activeState != null) {
            slidableController.activeState!.close();
          } else {
            onTap!();
          }
        },
        child: child,
      ),
    );
  }
}
