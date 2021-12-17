import 'package:flashinfo/common/common.dart';
import 'package:flashinfo/favourites/page/cancel_group_page.dart';
import 'package:flashinfo/favourites/page/group_dialog_page.dart';
import 'package:flashinfo/login/login_router.dart';
import 'package:flashinfo/mvp/status_model.dart';
import 'package:flashinfo/res/resources.dart';
import 'package:flashinfo/routers/fluro_navigator.dart';
import 'package:flashinfo/util/other_utils.dart';
import 'package:flashinfo/widgets/icon_font.dart';
import 'package:flashinfo/widgets/login_toast_dialog.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FollowContactWidget extends StatelessWidget {
  const FollowContactWidget(
      {Key? key,
      this.onTapContact,
      this.isCollect = false,
      this.collectSuccessful,
      required this.indexType,
      required this.followId,
      this.isShowCollect = true,
      this.onTapReviews,
      this.isReviews = true})
      : super(key: key);
  final void Function()? onTapContact;
  final void Function(StatusModel)? collectSuccessful;
  final void Function()? onTapReviews;
  final bool isCollect;
  final int indexType;
  final String followId;
  final bool isShowCollect;
  final bool isReviews;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colours.material_bg,
      width: double.infinity,
      child: Row(
        children: [
          Gaps.hGap20,
          if (!isReviews) const Expanded(child: Gaps.empty),
          Gaps.hGap8,
          if (isShowCollect)
            _followItem(isCollect ? 'Followed' : 'Follow',
                isCollect ? 0xe60d : 0xe66a, isCollect,
                onTap: () => _showFavouritesDialog(context))
          else
            Gaps.empty,
          if (isReviews)
            Expanded(
                child: Row(
              children: [
                Gaps.hGap20,
                _followItem('Reviews', 0xe63f, false, onTap: onTapReviews),
                const Expanded(child: Gaps.empty),
              ],
            ))
          else
            const Expanded(child: Gaps.empty),
          GestureDetector(
            onTap: onTapContact,
            child: Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(left: 10.w, right: 10.w),
                width: 207,
                height: 44,
                decoration: BoxDecoration(
                    color: Colours.app_main,
                    borderRadius: BorderRadius.all(Radius.circular(44.h))),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconFont(
                        name: 0xe63a,
                        isNewIcon: true,
                        size: Dimens.font_sp20,
                        color: Colours.material_bg),
                    Gaps.hGap5,
                    Text(
                      'Contact',
                      style: TextStyles.textSize12
                          .copyWith(color: Colours.material_bg),
                    ),
                  ],
                )),
          ),
        ],
      ),
    );
  }

  Widget _followItem(String name, int iconName, bool isCollect,
      {Function()? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: Colours.material_bg,
        // width: 50.w,
        // margin: EdgeInsets.only(bottom: 30.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconFont(
                name: iconName,
                size: Dimens.font_sp24,
                color: isCollect ? Colours.app_main : Colours.text_gray_c),
            Gaps.vGap5,
            Text(
              name,
              maxLines: 1,
              style: TextStyles.textSize10.copyWith(color: Colours.text_gray),
            )
          ],
        ),
      ),
    );
  }

  void _showFavouritesDialog(
    BuildContext context,
  ) {
    if (!(SpUtil.getBool(Constant.isLogin, defValue: false) ?? false)) {
      showDialog<void>(
          context: context,
          barrierDismissible: true,
          builder: (_) => LoginToastDialog(onPressed: () {
                Navigator.pop(context);
                NavigatorUtils.push(context, LoginRouter.smsLoginPage);
              }));
      return;
    }
    if (isCollect) {
      showElasticDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return CancelGroupPage(
            indexType: indexType,
            relatedTd: followId,
            collectCancel: collectSuccessful,
          );
        },
      );
    } else {
      showElasticDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return GroupDialogPage(
            indexType: indexType,
            relatedTd: followId,
            collectSuccessful: collectSuccessful,
          );
        },
      );
    }
  }
}
