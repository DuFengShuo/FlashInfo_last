import 'package:flashinfo/profile/page/export/export_page.dart';
import 'package:flashinfo/res/resources.dart';
import 'package:flashinfo/util/input_formatter/number_text_input_formatter.dart';
import 'package:flashinfo/util/other_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:convert' as convert;

class ExportTopWidget extends StatelessWidget {
  const ExportTopWidget(
      {Key? key,
      this.exportStoreParams,
      required this.emailController,
      required this.node1Text,
      this.maxNum = 1000})
      : super(key: key);
  final ExportStoreParams? exportStoreParams;
  final TextEditingController emailController;
  final FocusNode node1Text;
  final double maxNum;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: Dimens.gap_dp16, vertical: Dimens.gap_v_dp10),
      color: Colours.material_bg,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(vertical: Dimens.gap_v_dp5),
            child: Text(
              'Details',
              style: TextStyles.textBold17,
            ),
          ),
          Visibility(
            visible: true,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: Dimens.gap_v_dp5),
              child: Wrap(
                spacing: 5.w, //主轴上子控件的间距
                runSpacing: 5.h, //交叉轴上子控件之间的间距
                children: _wrapItem(), //要显示的子控件集合
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: Dimens.gap_v_dp5),
            child: Row(
              children: [
                Text(
                  'Total Quantity：',
                  style:
                      TextStyles.textBold12.copyWith(color: Colours.text_gray),
                ),
                Text(
                  '${exportStoreParams?.exportCount} pieces',
                  style: TextStyles.textSize12,
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: Dimens.gap_v_dp5),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Export Quantity：',
                  style:
                      TextStyles.textBold12.copyWith(color: Colours.text_gray),
                ),
                Container(
                  width: 60.w,
                  height: 17.h,
                  decoration: BoxDecoration(
                    border:
                        new Border.all(color: Colours.text_gray_c, width: 0.5),
                  ),
                  child: TextField(
                    key: const Key('fund_input'),
                    controller: emailController,
                    focusNode: node1Text,
                    maxLines: 1,
                    style: TextStyles.textSize13,
                    textAlign: TextAlign.center,
                    inputFormatters: [UsNumberTextInputFormatter(max: maxNum)],
                    keyboardType:
                        // ignore: use_named_constants
                        const TextInputType.numberWithOptions(decimal: false),
                    // 金额限制数字格式
                    // inputFormatters: [
                    //   FilteringTextInputFormatter.allow(RegExp('[0-9]'))
                    // ],
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(
                          top: 0.h, left: 0.0.w, right: 0.0.w, bottom: 0.0),
                      isDense: true,
                      border: InputBorder.none,
                      hintStyle: TextStyles.textSize13.copyWith(
                        color: Colours.text_gray_c,
                      ),
                    ),
                    onChanged: (value) {},
                  ),
                ),
                Gaps.hGap10,
                Text(
                  'pieces',
                  style: TextStyles.textSize12,
                ),
              ],
            ),
          ),
          Text(
            'Your export quantities should be within 1 - 1000',
            style: TextStyles.textSize10.copyWith(color: Colours.red),
          )
        ],
      ),
    );
  }

  List<Widget> _wrapItem() {
    final List<Widget> arr = [];
    List<String> array = [];
    print(exportStoreParams?.toJson());
    if (exportStoreParams?.viewCondition != null &&
        exportStoreParams!.viewCondition!.isNotEmpty) {
      final Map<String, dynamic> viewCondition =
          convert.jsonDecode(exportStoreParams!.viewCondition!)
              as Map<String, dynamic>;
      if (exportStoreParams?.source == 'tag') {
        viewCondition.forEach((key, dynamic value) {
          if (key == 'type' || key == 'modelType' || key == 'groupName') {
            array.add(value.toString());
          } else {
            array.add('$key:$value');
          }
        });
      } else {
        viewCondition.forEach((key, dynamic value) {
          if (key == 'KeywordAll' ||
              key == 'GeographyAll' ||
              key == 'IndustryAll') {
            array.add(value.toString());
          } else {
            array.add('$key:$value');
          }
        });
      }
    }

    array = Utils.maopaoList(array);
    arr.addAll(array
        .map((e) => Container(
              decoration: BoxDecoration(
                color: Colours.bg_color,
                borderRadius: BorderRadius.circular(12.0.h),
              ),
              padding: EdgeInsets.symmetric(horizontal: 8.0.w, vertical: 6.h),
              child: Text(
                e,
                style: TextStyles.textGray10.copyWith(
                  color: Colours.text_gray,
                ),
              ),
            ))
        .toList());

    if (arr.isEmpty) {
      arr.add(Container(
        decoration: BoxDecoration(
          color: Colours.bg_color,
          borderRadius: BorderRadius.circular(12.0.h),
        ),
        padding: EdgeInsets.symmetric(horizontal: 8.0.w, vertical: 6.h),
        child: Text(
          'Companies',
          style: TextStyles.textGray10.copyWith(
            color: Colours.text_gray,
          ),
        ),
      ));
    }

    arr.insert(
        0,
        Padding(
          padding: EdgeInsets.symmetric(vertical: 6.h),
          child: Text(
            'Content：',
            style: TextStyles.textBold12.copyWith(color: Colours.text_gray),
          ),
        ));
    return arr;
  }
}
