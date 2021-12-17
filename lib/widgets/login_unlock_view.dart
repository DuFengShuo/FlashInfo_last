import 'package:flashinfo/login/login_router.dart';
import 'package:flashinfo/profile/profile_router.dart';
import 'package:flashinfo/provider/user_info_provider.dart';
import 'package:flashinfo/res/resources.dart';
import 'package:flashinfo/routers/fluro_navigator.dart';
import 'package:flashinfo/util/image_utils.dart';
import 'package:flashinfo/util/send_analytics_event.dart';
import 'package:flashinfo/widgets/icon_font.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class LoginUnlockView extends StatelessWidget {
  const LoginUnlockView({
    Key? key,
    this.onTap,
    this.maxHeight,
    required this.loginName,
    required this.vipName,
    this.fuzzyImg = '',
  }) : super(key: key);
  final void Function()? onTap;
  final double? maxHeight;
  final String loginName;
  final String vipName;
  final String fuzzyImg;
  @override
  Widget build(BuildContext context) {
    return Consumer<UserInfoProvider>(builder: (_, userInfoProvider, __) {
      bool _isVip = false;
      if (userInfoProvider.userInfoModel != null) {
        _isVip = userInfoProvider.userInfoModel?.isVip == 0 ? true : false;
      }
      return Container(
        height: maxHeight ?? 200.h,
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: Dimens.gap_dp32),
        decoration: fuzzyImg.isEmpty
            ? const BoxDecoration(
                gradient: LinearGradient(
                //渐变位置
                begin: Alignment.topCenter, //右上
                end: Alignment.bottomCenter, //左下
                colors: [Color(0xffFBFBFC), Color(0xfff5f5f7)],
              ))
            : BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: ImageUtils.getAssetImage(
                      fuzzyImg,
                    ))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _isVip ? vipName : loginName,
              textAlign: TextAlign.center,
              style: TextStyles.textBold20,
            ),
            Gaps.vGap15,
            GestureDetector(
              onTap: () {
                if (_isVip) {
                  if (vipName == 'Upgrade  Plan for unlimited search results') {
                    AnalyticEventUtil.analyticsUtil
                        .sendAnalyticsEvent('SearchResult_Unlock');
                  }

                  NavigatorUtils.pushResult(context,
                      '${ProfileRouter.businessCenterPage}?isShowLog=true',
                      (value) {
                    onTap!();
                  });
                } else {
                  if (vipName == 'Upgrade  Plan for unlimited search results') {
                    AnalyticEventUtil.analyticsUtil.sendAnalyticsEvent(
                      'SearchResult_GoLogin',
                    );
                  }

                  NavigatorUtils.pushResult(context, LoginRouter.smsLoginPage,
                      (value) {
                    onTap!();
                  });
                }
              },
              child: Container(
                width: 110.w,
                height: 35.h,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  border: new Border.all(color: Colours.app_main, width: 1),
                  //设置四周圆角 角度
                  borderRadius: BorderRadius.all(Radius.circular(5.0.w)),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconFont(
                        name: 0xe650,
                        size: Dimens.font_sp20,
                        color: Colours.app_main),
                    Gaps.hGap10,
                    Text(
                      _isVip ? 'Unlock' : 'Log in',
                      style: TextStyles.textSize15
                          .copyWith(color: Colours.app_main),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      );
    });
  }
}
