import 'package:flashinfo/favourites/model/tags_bean.dart';
import 'package:flashinfo/res/colors.dart';
import 'package:flashinfo/res/dimens.dart';
import 'package:flashinfo/res/resources.dart';
import 'package:flashinfo/res/styles.dart';
import 'package:flashinfo/widgets/icon_font.dart';
import 'package:flutter/material.dart';

class TagsItem extends StatelessWidget {
  const TagsItem({Key? key, this.tagsModel}) : super(key: key);
  final TagsModel? tagsModel;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: Dimens.gap_dp16, vertical: Dimens.gap_v_dp10),
      decoration: BoxDecoration(
        color: Colours.material_bg,
        border: Border(
          bottom: Divider.createBorderSide(context, width: Dimens.gap_dp1),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  tagsModel?.name ?? '',
                  style: TextStyles.textBold14,
                ),
                Gaps.vGap10,
                Text(
                  tagsModel?.createdAt ?? '',
                  style: TextStyles.textGray12,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          Text(
            tagsModel?.contentCount.toString() ?? '',
            style: TextStyles.textGray14,
          ),
          Gaps.hGap8,
          const IconFont(
            name: 0xe66e,
            size: 25,
            color: Colours.text_gray_c,
            isNewIcon: true,
          )
        ],
      ),
    );
  }
}
