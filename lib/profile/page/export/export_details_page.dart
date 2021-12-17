import 'package:flashinfo/profile/model/export_bean.dart';
import 'package:flashinfo/res/colors.dart';
import 'package:flashinfo/res/dimens.dart';
import 'package:flashinfo/res/gaps.dart';
import 'package:flashinfo/res/styles.dart';
import 'package:flashinfo/util/other_utils.dart';
import 'package:flashinfo/widgets/my_app_bar.dart';
import 'package:flashinfo/widgets/my_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ExportDetailsPage extends StatefulWidget {
  const ExportDetailsPage({Key? key, required this.exportModel})
      : super(key: key);
  final ExportModel exportModel;
  @override
  _ExportDetailsPageState createState() => _ExportDetailsPageState();
}

class _ExportDetailsPageState extends State<ExportDetailsPage> {
  late ExportModel model;
  @override
  void initState() {
    model = widget.exportModel;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colours.bg_color,
      appBar: const MyAppBar(
        centerTitle: 'Details',
      ),
      body: Container(
        width: double.infinity,
        color: Colours.material_bg,
        child: MyScrollView(
            children: _buildBody(),
            padding: EdgeInsets.symmetric(horizontal: Dimens.gap_dp16)),
      ),
    );
  }

  List<Widget> _buildBody() {
    final String textStatus = model.sendStatus == 0
        ? 'In Process'
        : (model.sendStatus == 1 ? 'Success' : 'Failed');
    final Color textStatusColor = model.sendStatus == 0
        ? const Color(0xffFFBB00)
        : (model.sendStatus == 1
            ? const Color(0xff8AD043)
            : const Color(0xffEB4034));
    return <Widget>[
      Gaps.line,
      Padding(
        padding: EdgeInsets.symmetric(vertical: Dimens.gap_v_dp10),
        child: Text(
          'Details',
          style: TextStyles.textBold17,
        ),
      ),
      Gaps.line,
      Padding(
        padding: EdgeInsets.symmetric(vertical: Dimens.gap_v_dp10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Content：',
              style: TextStyles.textBold13,
            ),
            Expanded(
              child: Wrap(
                alignment: WrapAlignment.start,
                spacing: 5.w, //主轴上子控件的间距
                runSpacing: 5.h, //交叉轴上子控件之间的间距
                children: _wrapItem(), //要显示的子控件集合
              ),
            )
          ],
        ),
      ),
      Gaps.line,
      ExportDetailsItem(
          title: 'Export Quantity：',
          text: '${model.exportQuantity ?? 0} pieces'),
      Gaps.line,
      ExportDetailsItem(title: 'Format：', text: model.format ?? ''),
      Gaps.line,
      ExportDetailsItem(title: 'Time：', text: model.createdAt ?? ''),
      Gaps.lineV,
      Padding(
        padding: EdgeInsets.symmetric(vertical: Dimens.gap_v_dp10),
        child: Text(
          'Recipient Information',
          style: TextStyles.textBold17,
        ),
      ),
      Gaps.line,
      ExportDetailsItem(title: 'E-mai：', text: model.email ?? ''),
      Gaps.line,
      ExportDetailsItem(
        title: 'Send Status：',
        text: textStatus.toString(),
        textColor: textStatusColor,
      ),
    ];
  }

  List<Widget> _wrapItem() {
    final List<Widget> arr = [];
    if (model.condition == null || model.condition!.isEmpty) {
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
      return arr;
    } else {
      List<String> array = [];
      if (model.source == 'tag') {
        model.condition!.forEach((String key, dynamic value) {
          array.add(value.toString().replaceAll(',', '、'));
        });
      } else {
        model.condition!.forEach((String key, dynamic value) {
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
                  style: TextStyles.textGray13.copyWith(
                    color: Colours.text_gray,
                  ),
                ),
              ))
          .toList());

      return arr;
    }
  }
}

class ExportDetailsItem extends StatelessWidget {
  const ExportDetailsItem(
      {Key? key,
      required this.title,
      required this.text,
      this.textColor = Colours.text_gray})
      : super(key: key);
  final String title;
  final String text;
  final Color? textColor;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: Dimens.gap_v_dp10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyles.textBold13,
          ),
          Text(
            text,
            style: TextStyles.textGray13.copyWith(color: textColor),
          )
        ],
      ),
    );
  }
}
