import 'package:flashinfo/common/common.dart';
import 'package:flashinfo/favourites/page/cancel_group_page.dart';
import 'package:flashinfo/favourites/page/group_dialog_page.dart';
import 'package:flashinfo/login/login_router.dart';
import 'package:flashinfo/mvp/status_model.dart';
import 'package:flashinfo/res/resources.dart';
import 'package:flashinfo/routers/fluro_navigator.dart';
import 'package:flashinfo/util/other_utils.dart';
import 'package:flashinfo/util/screen_utils.dart';
import 'package:flashinfo/util/toast_utils.dart';
import 'package:flashinfo/widgets/icon_font.dart';
import 'package:flashinfo/widgets/login_toast_dialog.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BrandBottomBarWidget extends StatelessWidget {
  const BrandBottomBarWidget(
      {Key? key,
      this.onTapContact,
      this.isCollect = false,
      this.collectSuccessful,
      required this.indexType,
      required this.followId,
      this.isShowCollect = true,
      this.onTapReviews, this.isShowFollow = true})
      : super(key: key);
  final void Function()? onTapContact;
  final void Function(StatusModel)? collectSuccessful;
  final void Function()? onTapReviews;
  final bool isCollect;
  final int indexType;
  final String followId;
  final bool isShowCollect;
  final bool isShowFollow;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(top: 8.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Gaps.hGap20,
          if (isShowCollect)
            _followItem(isCollect ? 'Followed' : 'Follow',
                isCollect ? 0xe60d : 0xe66a, isCollect,
                onTap: (){
                  if(isShowFollow == false){
                    Toast.show('This feature is under development...');
                  } else {
                    _showFavouritesDialog(context);
                  }
                
                } ),
          GestureDetector(
            onTap: onTapContact,
            child: Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(right: 10.w),
                width: (Screen.width(context) - 40.w) / 2,
                height: 44,
                decoration: BoxDecoration(
                    color: Colours.app_main,
                    borderRadius: BorderRadius.all(Radius.circular(44.r))),
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
        height: 44,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
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
    if (isCollect == true) {
      showElasticDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return CancelGroupPage(
            indexType: 1,
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
            indexType: 1,
            relatedTd: followId,
            collectSuccessful: collectSuccessful,
          );
        },
      );
    }
  }
}
