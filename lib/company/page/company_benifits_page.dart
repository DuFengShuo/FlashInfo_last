import 'dart:math';
import 'package:flashinfo/brand/models/brand_bean.dart';
import 'package:flashinfo/res/resources.dart';
import 'package:flashinfo/widgets/card_widget.dart';
import 'package:flashinfo/widgets/my_app_bar.dart';
import 'package:flashinfo/widgets/my_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CompanyWelfarePage extends StatefulWidget {
  final Overview? overview;

  const CompanyWelfarePage({Key? key, this.overview}) : super(key: key);

  @override
  _CompanyWelfarePageState createState() => _CompanyWelfarePageState();
}

class _CompanyWelfarePageState extends State<CompanyWelfarePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colours.bg_color,
        appBar: const MyAppBar(
          centerTitle: 'Benifits',
        ),
        body: MyScrollView(
          children: [
            Padding(
                padding: EdgeInsets.only(
                    left: 16.w, right: 16.w, bottom: 16.h, top: 16.h),
                child: CardWidget(
                    radius: 12.0.r,
                    child: Container(
                        color: Colours.material_bg,
                        // height: 400.h,
                        width: double.infinity,
                        margin: EdgeInsets.only(top: 8.h, bottom: 8.h),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Wrap(
                            spacing: 8.w, //主轴上子控件的间距
                            runSpacing: 8.0.h, //交叉轴上子控件之间的间距
                            children: _industryWidget(
                                widget.overview!.benefit ?? []), //要显示的子控件集合
                          ),
                        ))))
          ],
        ));
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
    // final List<String> list = Utils.maopaoList(industry ?? <String>[]);
    if (list.isNotEmpty) {
      list.forEach((String item) {
        final int labelIndex = getColorsIndex();
        arr.add(_borderText(
            false, item, labelColors[labelIndex], labelTextColors[labelIndex]));
      });
    }
    return arr;
  }

  Widget _borderText(
      bool isIndustry, String text, Color bgColor, Color labelColor) {
    return Visibility(
      visible: text.isNotEmpty,
      child: Container(
        // height: 32.h,
        // alignment: Alignment.center,
        padding: EdgeInsets.symmetric(
            horizontal: Dimens.gap_dp10, vertical: Dimens.gap_v_dp5),
        // constraints: BoxConstraints(maxWidth: 80.w),
        decoration: BoxDecoration(
          color: bgColor,
          //设置四周圆角 角度
          borderRadius: BorderRadius.all(Radius.circular(32.0.r)),
          //设置四周边框
          // border: new Border.all(
          //     width: isIndustry ? 0 : 0.6.w, color: Colours.material_bg),
        ),
        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: Text(
            text,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: labelColor,
              fontSize: Dimens.font_sp12,
            ),
          ),
        ),
      ),
    );
  }
}
