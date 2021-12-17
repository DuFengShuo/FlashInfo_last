import 'package:flashinfo/favourites/model/tags_bean.dart';
import 'package:flashinfo/res/resources.dart';
import 'package:flashinfo/widgets/icon_font.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GroupDialogItem extends StatelessWidget {
  const GroupDialogItem(
      {Key? key, this.onTap, required this.gtoupSelecedArray, this.tagsModel})
      : super(key: key);
  final void Function(bool?)? onTap;
  final List<String?> gtoupSelecedArray;
  final TagsModel? tagsModel;
  @override
  Widget build(BuildContext context) {
    final bool seleced = gtoupSelecedArray.contains(tagsModel?.id);
    return GestureDetector(
        onTap: () => onTap!(!seleced),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: Dimens.gap_v_dp10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  tagsModel?.name ?? '-',
                  style: TextStyles.textBold16,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Gaps.hGap10,
              IconFont(
                  isNewIcon: true,
                  name: seleced ? 0xe67d : 0xe67c,
                  size: Dimens.font_sp24,
                  color: seleced ? Colours.app_main : Colours.text_gray_c),
              Gaps.hGap4,
            ],
          ),
        ));
  }
}
