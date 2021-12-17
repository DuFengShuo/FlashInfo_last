import 'package:flashinfo/company/models/company_detail_model.dart';
import 'package:flashinfo/res/colors.dart';
import 'package:flashinfo/res/dimens.dart';
import 'package:flashinfo/res/gaps.dart';
import 'package:flashinfo/res/resources.dart';
import 'package:flashinfo/res/styles.dart';
import 'package:flashinfo/routers/fluro_navigator.dart';
import 'package:flashinfo/widgets/my_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CompanyTags extends StatefulWidget {
  final CompanyDetailModel? companyDetailModel;
  const CompanyTags({Key? key, this.companyDetailModel}) : super(key: key);

  @override
  _CompanyTagsState createState() => _CompanyTagsState();
}

class _CompanyTagsState extends State<CompanyTags> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 360.h,
      decoration: const BoxDecoration(
          color: Colours.material_bg,
          borderRadius: BorderRadius.all(Radius.circular(20))),
      margin: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 20.w),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Business tag',
            style: TextStyles.textBold18.copyWith(fontWeight: FontWeight.bold),
          ),
          Gaps.vGap16,
          Padding(
            padding: EdgeInsets.only(left: 10.w, right: 10.w),
            child: Wrap(
              spacing: 9.w, //主轴上子控件的间距
              runSpacing: 9.0.h, //交叉轴上子控件之间的间距
              children: _industryWidget(
                  widget.companyDetailModel?.industry), //要显示的子控件集合
            ),
          ),
          Gaps.vGap16,
          const Spacer(),
          MyButton(
            onPressed: () => NavigatorUtils.goBack(context),
            text: 'OK',
            minHeight: 44.h,
            backgroundColor: Colours.app_main,
            textColor: Colours.material_bg,
            radius: 40.r,
          )
        ],
      ),
    );
  }

  List<Widget> _industryWidget(List<Industry>? industry) {
    final List<Widget> arr = [];
    final List<Industry> list = industry ?? <Industry>[];
    if (list.isNotEmpty) {
      list.forEach((Industry item) {});
      for (final Industry item in list) {
        arr.add(_borderText(false, item.name ?? ''));
      }
    }
    return arr;
  }

  Widget _borderText(bool isIndustry, String text) {
    return Visibility(
      visible: text.isNotEmpty,
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: Dimens.gap_dp10, vertical: Dimens.gap_v_dp5),
        // constraints: BoxConstraints(maxWidth: 80.w),
        decoration: BoxDecoration(
          color: Colours.bg_color,
          //设置四周圆角 角度
          borderRadius: BorderRadius.all(Radius.circular(20.0.r)),
          //设置四周边框
          // border: new Border.all(
          //     width: isIndustry ? 0 : 0.6.w, color: Colours.material_bg),
        ),
        child: Text(
          text,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: Colours.text_gray,
            fontSize: Dimens.font_sp12,
          ),
        ),
      ),
    );
  }
}
