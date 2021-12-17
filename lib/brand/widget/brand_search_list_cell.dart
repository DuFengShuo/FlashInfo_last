import 'package:flashinfo/brand/brand_rouder.dart';
import 'package:flashinfo/brand/models/brand_list_bean.dart';
import 'package:flashinfo/res/resources.dart';
import 'package:flashinfo/routers/fluro_navigator.dart';
import 'package:flashinfo/widgets/hight_light_text_widget.dart';
import 'package:flashinfo/widgets/load_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BrandSearchListCell extends StatelessWidget {
  const BrandSearchListCell(
      {Key? key, this.model, this.highlightText = '', this.index = 0})
      : super(key: key);
  final BrandItemModel? model;
  final String? highlightText;
  final int? index;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // if (index == 0) {
        //   NavigatorUtils.push(context,
        //       '${BrandRouder.brandDetailPage}?brandId=KAm45M78JjJALgJx');
        // } else {
        NavigatorUtils.push(
            context, '${BrandRouder.brandDetailPage}?brandId=${model?.id}');
        // }
      }, //pAGVeODy7Zk56439
      // onTap: () => NavigatorUtils.push(context,
      //    BrandRouder.brandScrollView), //pAGVeODy7Zk56439
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colours.material_bg,
              borderRadius: BorderRadius.circular(8.r),
            ),
            padding: EdgeInsets.all(
              Dimens.gap_dp8,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    LoadBorderImage(model?.logo ?? '',
                        width: 80.w, height: 80.w, holderImg: 'brand/brand'),
                    Gaps.hGap16,
                    Expanded(
                        child: SizedBox(
                      height: 80.h,
                      child: Padding(
                        padding: EdgeInsets.only(right: 15.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            HighlightTextWidget(
                                name: model?.name ?? '-',
                                highlightText: highlightText ?? ''),
                            Text(
                              'Last Funding Type: ',
                              style: TextStyles.textGray12,
                            ),
                            Text(
                              model!.lastFundingType!.isEmpty
                                  ? '-'
                                  : model?.lastFundingType ?? '',
                              style: TextStyles.textSize12,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ))
                  ],
                ),
                Gaps.vGap8,
                Text(
                  model?.intro ?? '',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyles.textSize12,
                ),
              ],
            ),
          ),
          Positioned(
            right: 8.w,
            child: LoadAssetImage(
              'brand/brands_icon',
              width: 24.w,
              height: 32.h,
            ),
          ),
        ],
      ),
    );
  }
}
