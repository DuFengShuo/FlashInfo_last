import 'package:flashinfo/brand/models/brand_bean.dart';
import 'package:flashinfo/res/resources.dart';
import 'package:flashinfo/widgets/load_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EventCellWidget extends StatelessWidget {
  final EventModel model;

  const EventCellWidget({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colours.material_bg,
          border: Border.all(width: 1, color: Colours.border_grey),
          borderRadius: BorderRadius.all(Radius.circular(8.r))),
      margin: EdgeInsets.only(bottom: 8.h),
      padding: EdgeInsets.symmetric(
          vertical: Dimens.gap_v_dp8, horizontal: Dimens.gap_dp8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              LoadBorderImage('${model.eventImg}',
                  width: 42.w, height: 42.w, holderImg: 'brand/brand_event'),
              Gaps.hGap10,
              Expanded(
                child: Text(
                  '${model.eventName}',
                  style: TextStyles.textBold14.copyWith(
                      color: Colours.text, fontWeight: FontWeight.bold),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Gaps.hGap8
            ],
          ),
          Gaps.vGap5,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${model.appearanceType}',
                style: TextStyles.textGray12.copyWith(height: 1.4.sp),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                '${model.eventStartsOn}',
                style: TextStyles.textGray12.copyWith(height: 1.4.sp),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              )
            ],
          ),
        ],
      ),
    );
  }
}
