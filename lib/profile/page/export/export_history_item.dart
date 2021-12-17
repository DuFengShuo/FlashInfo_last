import 'package:flashinfo/profile/model/export_bean.dart';
import 'package:flashinfo/res/resources.dart';
import 'package:flashinfo/util/other_utils.dart';
import 'package:flashinfo/widgets/my_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ExportHistoryItem extends StatelessWidget {
  const ExportHistoryItem({Key? key, this.exportModel}) : super(key: key);
  final ExportModel? exportModel;
  @override
  Widget build(BuildContext context) {
    final textStatus = exportModel?.sendStatus == 0
        ? 'In Process'
        : (exportModel?.sendStatus == 1 ? 'Success' : 'Failed');
    final Color textStatusColor = exportModel?.sendStatus == 0
        ? const Color(0xffFFBB00)
        : (exportModel?.sendStatus == 1
            ? const Color(0xff8AD043)
            : const Color(0xffEB4034));
    return Padding(
      padding: EdgeInsets.only(
        left: 10.0.w,
        right: 10.0.w,
        bottom: 10.0.h,
      ),
      child: MyCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 12.0.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    exportModel?.createdAt ?? '',
                    style: TextStyles.textBold13,
                  ),
                  Text(textStatus,
                      style: TextStyles.textSize12
                          .copyWith(color: textStatusColor)),
                ],
              ),
            ),
            Gaps.line,
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 10.0.h),
              child: Wrap(
                spacing: 5.w, //主轴上子控件的间距
                runSpacing: 5.h, //交叉轴上子控件之间的间距
                children: _wrapItem(), //要显示的子控件集合
              ),
            ),
            Gaps.line,
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 12.0.h),
              child: Row(
                children: [
                  Text(
                    'Export Quantity：',
                    style: TextStyles.textBold12
                        .copyWith(color: Colours.text_gray),
                  ),
                  Text(
                    '${exportModel?.exportQuantity ?? 0} pieces',
                    style: TextStyles.textSize12,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _wrapItem() {
    final List<Widget> arr = [];
    if (exportModel?.condition == null || exportModel!.condition!.isEmpty) {
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
    } else {
      List<String> array = [];
      if (exportModel?.source == 'tag') {
        exportModel?.condition!.forEach((String key, dynamic value) {
          array.add(value.toString().replaceAll(',', '、'));
        });
      } else {
        exportModel?.condition!.forEach((String key, dynamic value) {
          if (key.contains('All')) {
            array.add(value.toString().replaceAll(',', '、'));
          } else {
            array.add(key + ':' + value.toString().replaceAll(',', '、'));
          }
        });
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
}
