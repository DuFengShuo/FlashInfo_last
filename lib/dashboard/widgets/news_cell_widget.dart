import 'package:flashinfo/dashboard/models/news_bean.dart';
import 'package:flashinfo/res/resources.dart';
import 'package:flashinfo/widgets/load_image.dart';
import 'package:flashinfo/widgets/my_card.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class NewsCellWidget extends StatelessWidget {
  const NewsCellWidget({Key? key, this.newsModel, this.onTap})
      : super(key: key);
  final BrandNewModel? newsModel;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.only(
            left: Dimens.gap_dp16,
            right: Dimens.gap_dp16,
            bottom: Dimens.gap_dp8,
          ),
          child: MyCard(
              child: Padding(
            padding: EdgeInsets.all(Dimens.gap_dp12),
            child: Row(
              children: [
                // ClipRRect(
                //   borderRadius: BorderRadius.circular(10.r),
                //   child: LoadImage(newsModel?.logo ?? '',
                //       width: 114.5.w, height: 75.5.h),
                // ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: Dimens.gap_v_dp4),
                    height: 70.h,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          newsModel?.title ?? '',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyles.textBold16
                              .copyWith(color: const Color(0xff4B4B59)),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                newsModel?.source ?? '',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyles.textGray12,
                              ),
                            ),
                            Gaps.hGap10,
                            Text(
                              newsModel?.publishTime ?? '',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyles.textGray12,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          )),
        )
        // Container(
        //   decoration: BoxDecoration(
        //     color: Colours.material_bg,
        //     border: Border(
        //       bottom: Divider.createBorderSide(context, width: Dimens.gap_v_dp1),
        //     ),
        //   ),
        //   padding: EdgeInsets.symmetric(
        //       horizontal: Dimens.gap_dp16, vertical: Dimens.gap_v_dp10),
        //   child:
        // ),
        );
  }
}
