import 'package:flashinfo/brand/brand_rouder.dart';
import 'package:flashinfo/brand/provider/brand_detail_provider.dart';
import 'package:flashinfo/res/resources.dart';
import 'package:flashinfo/routers/fluro_navigator.dart';
import 'package:flashinfo/util/other_utils.dart';
import 'package:flashinfo/widgets/icon_font.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class BrandTagWidget extends StatefulWidget {
  const BrandTagWidget({Key? key, this.tags}) : super(key: key);
  final List<String>? tags;
  @override
  _BrandTagWidgetState createState() => _BrandTagWidgetState();
}

class _BrandTagWidgetState extends State<BrandTagWidget> {
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
    final List<String> list = Utils.maopaoList(widget.tags ?? []);
    final List<String> dataList = [];
    if (list.isNotEmpty) {
      for (int index = 0; index < list.length; index++) {
        if (index < 6) {
          dataList.add(list[index]);
        }
      }
    }

    return Consumer<BrandProvider>(builder: (_, provider, __) {
      return Padding(
        padding: EdgeInsets.only(
          left: 16.w,
          right: 16.w,
          bottom: 24.h,
        ),
        child: ListView(
          // crossAxisAlignment: CrossAxisAlignment.start,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.only(top: 24.h),
          children: [
            Row(
              children: [
                Text(
                  'Tags',
                  style: TextStyles.textGray12,
                ),
                const Spacer(),
                Visibility(
                  visible: _containerHeight > 35.h && dataList.length > 4,
                  child: GestureDetector(
                    onTap: () {
                      NavigatorUtils.push(
                          context, BrandRouder.brandTagListWidget,
                          arguments: provider.brandBean!.summary!.overview);
                    },
                    child: IconFont(
                        isNewIcon: true,
                        name: 0xe66e,
                        size: Dimens.font_sp20,
                        color: Colours.text_gray_c),
                  ),
                )
              ],
            ),
            Gaps.vGap12,
            if (dataList.isNotEmpty)
              Wrap(
                  key: _globalKey,
                  spacing: 5.w, //主轴上子控件的间距
                  runSpacing: 9.h, //交叉轴上子控件之间的间距
                  children: dataList
                      .map((e) => Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 2.w, vertical: 1.h),
                            decoration: BoxDecoration(
                                color: Colours.tag_bg_blue,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(32.0.r))),
                            child: Padding(
                              padding: const EdgeInsets.all(6),
                              child: Text(
                                '$e',
                                style: TextStyle(
                                  color: Colours.app_main,
                                  fontSize: Dimens.font_sp12,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ))
                      .toList())
            else
              Text(
                '-',
                style: TextStyles.textSize12,
              ),
          ],
        ),
      );
    });
  }
}
