import 'package:flashinfo/favourites/model/collects_list_beam.dart';
import 'package:flashinfo/res/resources.dart';
import 'package:flashinfo/widgets/icon_font.dart';
import 'package:flashinfo/widgets/load_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FavouritesBrandCell extends StatelessWidget {
  const FavouritesBrandCell(
      {Key? key, required this.model, this.onTap, this.onTapitem})
      : super(key: key);
  final BrandTagModel model;
  final void Function()? onTap;
  final void Function()? onTapitem;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapitem,
      child: Container(
        decoration: BoxDecoration(
            color: Colours.material_bg,
            border: Border.all(width: 1, color: Colours.border_grey),
            borderRadius: BorderRadius.all(Radius.circular(8.r))),
        margin: EdgeInsets.symmetric(horizontal: Dimens.gap_dp16),
        padding: EdgeInsets.symmetric(
            horizontal: Dimens.gap_dp8, vertical: Dimens.gap_v_dp8),
        child: Row(
          children: [
            Stack(
              children: [
                LoadBorderImage(model.brandDetail.logo ?? '',
                    width: 80.w,
                    height: 80.w,
                    radius: 8.r,
                    holderImg: 'brand/brand'),
                Positioned(
                  right: 0,
                  top: 0,
                  child: LoadAssetImage(
                    'brand/brand_tag',
                    width: 36.w,
                    height: 36.w,
                  ),
                )
              ],
            ),
            Gaps.hGap8,
            Expanded(
                child: SizedBox(
              height: 80.w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    model.brandDetail.name ?? '',
                    style: TextStyles.textBold18,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    model.brandDetail.founder ?? '',
                    style: TextStyles.textSize12,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    model.createdAt ?? '',
                    style: TextStyles.textGray12,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            )),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Dimens.gap_dp20),
              child: GestureDetector(
                onTap: onTap,
                child: IconFont(
                    name: model.brandDetail.isCollect ? 0xe60d : 0xe66a,
                    size: 25,
                    color: model.brandDetail.isCollect
                        ? Colours.app_main
                        : Colours.text_gray_c),
              ),
            )
          ],
        ),
      ),
    );
  }
}
