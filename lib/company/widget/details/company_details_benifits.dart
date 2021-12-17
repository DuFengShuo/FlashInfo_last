import 'dart:math';

import 'package:flashinfo/brand/provider/brand_detail_provider.dart';
import 'package:flashinfo/company/company_rouder.dart';

import 'package:flashinfo/res/resources.dart';
import 'package:flashinfo/routers/fluro_navigator.dart';
import 'package:flashinfo/util/other_utils.dart';
import 'package:flashinfo/widgets/icon_font.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CompanyWelfare extends StatefulWidget {
  const CompanyWelfare({Key? key}) : super(key: key);

  @override
  _CompanyWelfareState createState() => _CompanyWelfareState();
}

class _CompanyWelfareState extends State<CompanyWelfare> {
  final GlobalKey _globalKey = GlobalKey();
  double _containerHeight = 0.0;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback(
      (_) {
        _containerHeight = _globalKey.currentContext?.size?.height ?? 0.0;
        setState(() {});
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BrandProvider>(builder: (_, provider, __) {
      final List<String> list = Utils.maopaoList(
          provider.brandBean!.summary!.overview!.benefit ?? []);

      return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(12.r)),
            color: Colours.material_bg,
          ),
          // height: 170.h,
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  left: 16.w,
                  right: 16.w,
                ),
                child: Row(
                  children: [
                    Text(
                      'Benefit',
                      style: TextStyles.textGray12,
                    ),
                    const Spacer(),
                    Visibility(
                      visible: _containerHeight > 35.h && list.length > 4,
                      child: GestureDetector(
                        onTap: () {
                          NavigatorUtils.push(
                              context, CompanyRouder.companyWelfareDetail,
                              arguments: provider.brandBean!.summary!.overview);
                        },
                        child:
                        // IconFont(
                        //   isNewIcon: true,
                        //   name: 0xe66e,
                        //   color: Colors.black,
                        //   size: Dimens.font_sp18,
                        // )
                        IconFont(
                            isNewIcon: true,
                            name: 0xe66e,
                            size: Dimens.font_sp20,
                            color: Colours.text_gray_c),
                        // const Icon(
                        //   Icons.navigate_next,
                        //   color: Colours.text_gray_c,
                        // ),
                      ),
                    )
                  ],
                ),
              ),

              //Gaps.line,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                child: list.isNotEmpty
                    ? Container(
                   color: Colours.material_bg,
                      height: 70.h,
                      child: Wrap(
                          key: _globalKey,
                          spacing: 8.w, //主轴上子控件的间距
                          runSpacing: 8.0.h, //交叉轴上子控件之间的间距
                          children: _industryWidget(list), //要显示的子控件集合
                          clipBehavior: Clip.antiAlias,
                        ),
                    )
                    : Text(
                        '-',
                        style: TextStyles.textSize12,
                      ),
              ),
            ],
          ));
    });
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
    if (list.isNotEmpty) {
      list.forEach((String item) {
        final int labelIndex = getColorsIndex();
        arr.add(_borderText(false, item, labelColors[labelIndex],
            labelTextColors[labelIndex]));
        // if (arr.length > 10) {
        //   return;
        // } else {
        //   arr.add(_borderText(false, item, labelColors[labelIndex],
        //       labelTextColors[labelIndex]));
        // }
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
        padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
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
