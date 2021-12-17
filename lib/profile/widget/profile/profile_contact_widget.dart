import 'package:flashinfo/common/common.dart';
import 'package:flashinfo/login/login_router.dart';
import 'package:flashinfo/pay/pay_router.dart';
import 'package:flashinfo/profile/profile_router.dart';
import 'package:flashinfo/provider/user_info_provider.dart';
import 'package:flashinfo/res/colors.dart';
import 'package:flashinfo/res/resources.dart';
import 'package:flashinfo/routers/fluro_navigator.dart';
import 'package:flashinfo/widgets/icon_font.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class ProfileContactWidget extends StatelessWidget {
  const ProfileContactWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 90.h,
      padding: EdgeInsets.symmetric(vertical: Dimens.gap_v_dp12),
      decoration: BoxDecoration(
        color: Colours.material_bg,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16.w), topRight: Radius.circular(16.w)),
      ),
      child: Row(
        children: [
          Expanded(
              child: GestureDetector(
            onTap: () => _onTapCallbackItem(0, context),
            child: SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconFont(
                      name: 0xe64f,
                      size: 38.sp,
                      color: const Color(0xffFF817B)),
                  Consumer<UserInfoProvider>(builder: (_, provider, __) {
                    return Text(
                      'Contact（${provider.userInfoModel?.unlockContacts ?? 0})',
                      style: TextStyles.textSize13,
                    );
                  })
                ],
              ),
            ),
          )),
          Expanded(
              child: GestureDetector(
            onTap: () => _onTapCallbackItem(1, context),
            child: SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconFont(
                      name: 0xe64e,
                      size: 38.sp,
                      color: const Color(0xffFB478F)),
                  Text(
                    'Usage detail',
                    style: TextStyles.textSize13,
                  )
                ],
              ),
            ),
          )),
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
        NavigatorUtils.push(context, ProfileRouter.contactListPage);
        break;
      case 1:
        NavigatorUtils.push(context, PayRouter.payListPage);
        break;

      default:
    }
  }
}
