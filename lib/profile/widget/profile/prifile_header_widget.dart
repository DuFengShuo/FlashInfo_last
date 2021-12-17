import 'package:flashinfo/common/common.dart';
import 'package:flashinfo/favourites/favourites_router.dart';
import 'package:flashinfo/login/login_router.dart';
import 'package:flashinfo/profile/profile_router.dart';
import 'package:flashinfo/profile/widget/profile/profile_avatar_widget.dart';
import 'package:flashinfo/profile/widget/profile/profile_record_widget.dart';
import 'package:flashinfo/profile/widget/profile/profile_vip_widget.dart';
import 'package:flashinfo/res/colors.dart';
import 'package:flashinfo/res/resources.dart';
import 'package:flashinfo/routers/fluro_navigator.dart';
import 'package:flashinfo/setting/setting_router.dart';
import 'package:flashinfo/util/image_utils.dart';
import 'package:flashinfo/widgets/icon_font.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PrifileHeaderWidget extends StatelessWidget {
  const PrifileHeaderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 280.h,
      decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.cover,
              image: ImageUtils.getAssetImage(
                'dashboard/dashboard_top_bg',
              ))),
      child: Column(
        children: [
          SafeArea(
            child: Row(
              children: [
                const Spacer(),
                GestureDetector(
                  onTap: () => _onTapCallbackItem(0, context),
                  child: IconFont(
                      name: 0xe607,
                      size: Dimens.font_sp20,
                      color: Colours.material_bg),
                ),
                Gaps.hGap16,
              ],
            ),
          ),
          ProfileAvatarWidget(onTap: _onTapCallbackItem),
          Gaps.vGap17,
          ProfileRecordWidget(onTap: _onTapCallbackItem),
          Gaps.vGap17,
          const ProfileVipWidget(),
        ],
      ),
    );
  }

  void _onTapCallbackItem(int index, BuildContext context) {
    if (!(SpUtil.getBool(Constant.isLogin, defValue: false) ?? false)) {
      NavigatorUtils.push(context, LoginRouter.smsLoginPage);
      return;
    }
    switch (index) {
      case 0:
        NavigatorUtils.push(context, SettingRouter.settingPage);
        break;
      case 1:
        NavigatorUtils.push(context, ProfileRouter.personalPage);
        break;
      case 2:
        NavigatorUtils.push(context, ProfileRouter.personalPage);
        break;
      case 3:
        NavigatorUtils.push(context, FavouritesRouter.favouritesPage);
        break;
      case 4:
        NavigatorUtils.push(context, ProfileRouter.browsingPage);
        break;
      case 5:
        break;
      default:
    }
  }
}
