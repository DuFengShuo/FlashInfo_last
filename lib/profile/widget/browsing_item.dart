import 'package:flashinfo/profile/model/browsing_bean.dart';
import 'package:flashinfo/res/colors.dart';
import 'package:flashinfo/res/dimens.dart';
import 'package:flashinfo/res/resources.dart';
import 'package:flashinfo/widgets/load_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BrowsingItem extends StatelessWidget {
  const BrowsingItem({
    Key? key,
    this.onTabItem,
    this.browsingModel,
  }) : super(key: key);
  final void Function()? onTabItem;
  final BrowsingModel? browsingModel;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTabItem,
      child: Container(
        color: Colours.material_bg,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: Dimens.gap_dp20),
          child: Row(
            children: [
              LoadBorderImage(browsingModel?.modelLogo ?? '',
                  width: 30.w,
                  height: 30.h,
                  holderImg: '${browsingModel?.model}/${browsingModel?.model}'),
              Gaps.hGap15,
              Expanded(
                  child: Container(
                alignment: Alignment.centerLeft,
                height: 50.0.h,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: Divider.createBorderSide(context, width: 0.8.w),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        browsingModel?.modelName ?? '',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyles.textBold15,
                      ),
                    ),
                    Gaps.hGap10,
                    Text(
                      browsingModel?.createdTime ?? '',
                      style: TextStyles.textSize10
                          .copyWith(color: Colours.text_gray),
                    )
                  ],
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }
}
