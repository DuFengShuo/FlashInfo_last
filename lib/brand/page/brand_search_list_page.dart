import 'package:flashinfo/brand/brand_rouder.dart';
import 'package:flashinfo/brand/models/brand_list_bean.dart';
import 'package:flashinfo/brand/widget/brand_search_list_cell.dart';
import 'package:flashinfo/provider/base_list_provider.dart';
import 'package:flashinfo/res/colors.dart';
import 'package:flashinfo/res/resources.dart';
import 'package:flashinfo/routers/fluro_navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flashinfo/util/screen_utils.dart';

class BrandSearchListPage extends StatefulWidget {
  const BrandSearchListPage(
      {Key? key,
      required this.searcBrandListProvider,
      this.keyword = '',
      this.backOnPressed})
      : super(key: key);
  final BaseListProvider<BrandItemModel> searcBrandListProvider;
  final String keyword;
  final VoidCallback? backOnPressed;
  @override
  _BrandSearchListPageState createState() => _BrandSearchListPageState();
}

class _BrandSearchListPageState extends State<BrandSearchListPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colours.bg_color,
      width: double.infinity,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 16.w, top: 8.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                RichText(
                  maxLines: 2,
                  text: TextSpan(
                    text:
                        '${widget.searcBrandListProvider.metaModel?.pagination?.total ?? 0} ',
                    style:
                        TextStyles.textBold14.copyWith(color: Colours.app_main),
                    children: const <TextSpan>[
                      TextSpan(
                        text: 'Brands Found',
                        style: TextStyle(color: Colours.text),
                      ),
                    ],
                  ),
                ),
                Visibility(
                    visible: widget.searcBrandListProvider.list.length > 3,
                    child: GestureDetector(
                        onTap: () => NavigatorUtils.pushResult(context,
                                '${BrandRouder.brandListPage}?keyword=${widget.keyword}',
                                (value) {
                              widget.backOnPressed!();
                            }),
                        child: SizedBox(
                          width: 50.w,
                          child: Images.arrowRight,
                        )))
              ],
            ),
          ),
          Gaps.vGap12,
          Expanded(
              child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: widget.searcBrandListProvider.list.length > 5
                      ? 5
                      : widget.searcBrandListProvider.list.length,
                  itemExtent: Screen.width(context) - 80.w,
                  padding: EdgeInsets.only(left: 16.w, right: 8.w),
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: EdgeInsets.only(right: 8.w),
                      child: BrandSearchListCell(
                          index: index,
                          highlightText: widget.keyword,
                          model: widget.searcBrandListProvider.list[index]),
                    );
                  }))
        ],
      ),
    );
  }
}
