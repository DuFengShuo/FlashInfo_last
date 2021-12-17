import 'dart:math';

import 'package:flashinfo/personal/model/peoples_new_bean.dart';
import 'package:flashinfo/res/resources.dart';
import 'package:flashinfo/util/other_utils.dart';
import 'package:flashinfo/util/screen_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SkillTagWidget extends StatefulWidget {
  final List<Skills>? skill;

  const SkillTagWidget({Key? key, this.skill}) : super(key: key);

  @override
  _SkillTagWidgetState createState() => _SkillTagWidgetState();
}

class _SkillTagWidgetState extends State<SkillTagWidget> {
  @override
  Widget build(BuildContext context) {
    final List<String> skillList = [];
    int count =0;
    if(widget.skill!.length>10){
      count=10;
    }else{
      count= widget.skill!.length;
    }
    for (int i = 0; i < count; i++) {
      Skills skillee = widget.skill![i];
      skillList.add(skillee.name ?? '');
    }
    final List<String> datalist = Utils.maopaoList(skillList);

    return Container(
      // constraints: BoxConstraints(
      //   maxHeight: 118.h,
      // ),
      color: Colours.material_bg,
      child: Wrap(
        spacing: 8.w, //主轴上子控件的间距
        runSpacing: 8.0.h, //交叉轴上子控件之间的间距
        children: datalist.map((e) => _borderText('$e')).toList(),
        //要显示的子控件集合
        clipBehavior: Clip.antiAlias,
      ),
    );
  }

  List<Widget> _industryWidget(List<String>? industry) {
    final List<Color> labelColors = [
      const Color(0xFFD6E2FB),
      const Color(0xFFFFF0F6),
      const Color(0xFFE6FFFB),
      const Color(0xFFFFF1CC),
      const Color(0xFFE7D6FF)
    ];
    final List<Color> labelTextColors = [
      const Color(0xFF3270ED),
      const Color(0xFFEB2F96),
      const Color(0xFF13C2C2),
      const Color(0xFFFFBB00),
      const Color(0xFF722ED1)
    ];
    int getColorsIndex() {
      final rnm = new Random(); //随机数生成类
      return rnm.nextInt(5);
    }

    final List<Widget> arr = [];
    final List<String> list = industry ?? <String>[];
    // if (list.isNotEmpty) {
    //   list.forEach((String item) {
    //     final int labelIndex = getColorsIndex();
    //     arr.add(_borderText( labelColors[labelIndex],
    //         ));
    //     // if (arr.length > 10) {
    //     //   return;
    //     // } else {
    //     //   arr.add(_borderText(false, item, labelColors[labelIndex],
    //     //       labelTextColors[labelIndex]));
    //     // }
    //   });
    //   }
    return arr;
  }

  Widget _borderText(
    String text,
  ) {
    return Visibility(
      visible: text.isNotEmpty,
      child: Container(
        // height: 32.h,
        // alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
        // constraints: BoxConstraints(maxWidth: 80.w),
        decoration: BoxDecoration(
          color: Colours.line,
          //设置四周圆角 角度
          borderRadius: BorderRadius.all(Radius.circular(32.0.r)),
          //设置四周边框
          // border: new Border.all(
          //     width: isIndustry ? 0 : 0.6.w, color: Colours.material_bg),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          child: Container(
            constraints:
                BoxConstraints(maxWidth: Screen.width(context) - 100.w),
            child: Text(
              text,
              maxLines: 200,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  color: Colours.text_gray,
                  fontSize: Dimens.font_sp12,
                  height: 1.3),
            ),
          ),
        ),
      ),
    );
  }
}
