import 'package:flashinfo/login/model/user_info_model.dart';
import 'package:flashinfo/profile/profile_router.dart';
import 'package:flashinfo/provider/user_info_provider.dart';
import 'package:flashinfo/res/resources.dart';
import 'package:flashinfo/routers/fluro_navigator.dart';
import 'package:flashinfo/util/image_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileVipWidget extends StatelessWidget {
  const ProfileVipWidget({Key? key, this.onTap}) : super(key: key);
  final void Function(int, BuildContext)? onTap;
  @override
  Widget build(BuildContext context) {
    return Consumer<UserInfoProvider>(builder: (_, provider, __) {
      final UserInfoModel? _userInfoModel = provider.userInfoModel;
      return Expanded(
          child: Stack(
        alignment: AlignmentDirectional.bottomEnd,
        children: [
          Container(
            color: Colours.bg_color,
            width: double.infinity,
            height: 35.h,
            child: Gaps.empty,
          ),
          GestureDetector(
            onTap: () =>
                NavigatorUtils.push(context, ProfileRouter.businessCenterPage),
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: Dimens.gap_dp16),
              decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: ImageUtils.getAssetImage(
                      'me/vip_bak',
                    )),
                borderRadius: BorderRadius.circular(5.0.w),
              ),
              width: double.infinity,
              height: double.infinity,
              padding: EdgeInsets.only(
                  left: Dimens.gap_dp16,
                  right: Dimens.gap_dp10,
                  top: Dimens.gap_v_dp16,
                  bottom: Dimens.gap_v_dp16),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          !provider.isVip || _userInfoModel == null
                              ? 'Business Center'
                              : 'Vip type：${_userInfoModel.vipData?.vipInfo?.vipName ?? ''}',
                          style: TextStyles.textBold17,
                        ),
                        Text(
                          !provider.isVip || _userInfoModel == null
                              ? 'Only \$1 per day can boost your business'
                              : 'Expiry Date:  ${_userInfoModel.vipData?.vipInfo?.expiredAt ?? ''}',
                          style: TextStyles.textSize12,
                        ),
                      ],
                    ),
                  ),
                  Visibility(
                      visible: !provider.isVip || _userInfoModel == null,
                      child: GestureDetector(
                        child: Container(
                          width: 75.w,
                          height: 30.h,
                          decoration: BoxDecoration(
                            color: const Color(0xff131313),
                            borderRadius: BorderRadius.circular(5.0.w),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            'VIP',
                            style: TextStyles.textBold14
                                .copyWith(color: const Color(0xffF9DCBF)),
                          ),
                        ),
                      ))
                ],
              ),
            ),
          ),
        ],
      ));
    });
  }
}
