import 'package:flashinfo/brand/brand_rouder.dart';
import 'package:flashinfo/company/models/company_details_bean.dart';
import 'package:flashinfo/res/colors.dart';
import 'package:flashinfo/res/resources.dart';
import 'package:flashinfo/routers/fluro_navigator.dart';
import 'package:flashinfo/util/other_utils.dart';
import 'package:flashinfo/util/screen_utils.dart';
import 'package:flashinfo/widgets/load_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BusinessCell extends StatelessWidget {
  const BusinessCell(
      {Key? key, required this.isList, this.businessModel, this.lengString = 0})
      : super(key: key);
  final bool isList;
  final BusinessModel? businessModel;
  final int lengString;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => NavigatorUtils.push(context,
          '${BrandRouder.brandDetailPage}?brandId=${businessModel?.id}'), //pA
      child: Padding(
        padding: EdgeInsets.only(bottom: 5.h),
        child: Container(
          decoration: BoxDecoration(
              color: Colours.material_bg,
              borderRadius: BorderRadius.all(Radius.circular(12.r)),
              border: Border.all(width: 1, color: Colours.line)),
          child: Container(
            width:
                isList ? Screen.width(context) : Screen.width(context) - 120.w,
            color: Colors.transparent,
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: Dimens.gap_dp8, vertical: Dimens.gap_v_dp8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      LoadBorderImage('${businessModel?.logo ?? ''}',
                          width: 62.w,
                          height: 62.w,
                          holderImg: 'product/product'),
                      Gaps.hGap10,
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${businessModel?.name ?? '-'}',
                              style: TextStyles.textBold14
                                  .copyWith(fontWeight: FontWeight.bold),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Gaps.vGap10,
                            if ((businessModel?.tags ?? []).isNotEmpty)
                              Row(
                                children: [
                                  Expanded(
                                      child: Container(
                                    color: Colors.transparent,
                                    height: 23.h,
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount: businessModel?.tags?.length,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return BorderText(
                                            title: (Utils.maopaoList(
                                                    businessModel?.tags ??
                                                        [])[index])
                                                .toString());
                                      },
                                    ),
                                  )),
                                ],
                              )
                            else
                              Text('-', style: TextStyles.textSize12),
                          ],
                        ),
                      )
                    ],
                  ),
                  Gaps.vGap8,
                  Text(
                    '${(businessModel?.intro ?? '').isEmpty ? '-' : (businessModel?.intro ?? '')}',
                    style: TextStyles.textGray12,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class BorderText extends StatelessWidget {
  final String title;
  const BorderText({Key? key, this.title = ''}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: Dimens.gap_dp8),
      decoration: BoxDecoration(
        color: const Color(0xFFD6E2FB),
        borderRadius: BorderRadius.all(Radius.circular(12.r)),
      ),
      padding: EdgeInsets.symmetric(
          horizontal: Dimens.gap_dp10, vertical: Dimens.gap_v_dp4),
      child: Text(
        title,
        style: TextStyles.textSize12.copyWith(color: Colours.app_main),
      ),
    );
  }
}
