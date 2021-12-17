import 'package:flashinfo/company/models/company_details_bean.dart';
import 'package:flashinfo/res/resources.dart';
import 'package:flashinfo/widgets/load_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CompanyReviewsItemWidget extends StatelessWidget {
  const CompanyReviewsItemWidget(
      {Key? key, required this.model, this.isMaxLines = false, this.onTap})
      : super(key: key);
  final ReviewsModel? model;
  final bool isMaxLines;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin:
            EdgeInsets.symmetric(vertical: 4.h, horizontal: Dimens.gap_dp16),
        decoration: BoxDecoration(
            color: Colours.material_bg,
            border: Border.all(width: 1, color: Colours.border_grey),
            borderRadius: BorderRadius.all(Radius.circular(8.r))),
        child: Container(
            padding: EdgeInsets.symmetric(
                vertical: Dimens.gap_v_dp10, horizontal: Dimens.gap_dp16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    LoadBorderImage(model!.user!.userAvatar ?? '',
                        width: 44.w,
                        height: 44.w,
                        radius: 22.w,
                        holderImg: 'personnel/personnel'),
                    Gaps.hGap10,
                    Expanded(
                        child: SizedBox(
                      height: 44.h,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${model?.user?.userName ?? 'Anonymous'}',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyles.textBold14
                                .copyWith(color: Colours.app_main),
                          ),
                          Text(
                            '${model?.creationTime ?? ''}',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyles.textSize12
                                .copyWith(color: Colours.text_gray_c),
                          ),
                        ],
                      ),
                    )),
                  ],
                ),
                Gaps.vGap10,
                Gaps.line,
                Gaps.vGap8,
                if (isMaxLines)
                  Text(
                    model?.title ?? '',
                    textAlign: TextAlign.left,
                    style: TextStyles.textBold14,
                  )
                else
                  Text(
                    model?.title ?? '',
                    textAlign: TextAlign.left,
                    style: TextStyles.textBold14,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                Gaps.vGap8,
                if (isMaxLines)
                  Text(
                    model?.comments ?? '',
                    style: TextStyles.textGray12.copyWith(height: 1.5),
                  )
                else
                  Text(
                    model?.comments ?? '',
                    style: TextStyles.textGray12.copyWith(height: 1.5),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                Visibility(
                    visible: model?.wtripartite != 0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Gaps.vGap8,
                        Gaps.line,
                        Gaps.vGap8,
                        Text(
                          'From other platforms',
                          style: TextStyles.textGray12.copyWith(height: 1.5),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ))
              ],
            )),
      ),
    );
  }
}
