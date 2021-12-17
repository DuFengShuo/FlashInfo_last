import 'package:flashinfo/login/login_router.dart';
import 'package:flashinfo/login/model/user_info_model.dart';
import 'package:flashinfo/provider/user_info_provider.dart';
import 'package:flashinfo/res/resources.dart';
import 'package:flashinfo/routers/fluro_navigator.dart';
import 'package:flashinfo/util/image_utils.dart';
import 'package:flashinfo/widgets/load_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class BusinessCenterLogWidget extends StatelessWidget {
  const BusinessCenterLogWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<UserInfoProvider>(builder: (_, provider, __) {
      final UserInfoModel? model = provider.userInfoModel;
      String name = provider.userInfoModel?.name ?? '';
      name = name.isEmpty ? provider.userInfoModel?.mobile ?? '' : name;
      name = name.isEmpty ? provider.userInfoModel?.email ?? '' : name;
      return GestureDetector(
        onTap: () {
          if (model == null) {
            NavigatorUtils.push(context, LoginRouter.smsLoginPage);
          }
        },
        child: Container(
            width: double.infinity,
            height: 85.h,
            decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.fill,
                  image: ImageUtils.getAssetImage(
                    'pay/business',
                  )),
              borderRadius: BorderRadius.circular(3.0.w),
            ),
            child: Container(
              padding: EdgeInsets.symmetric(
                  horizontal: Dimens.gap_dp16, vertical: Dimens.gap_v_dp12),
              child: model != null
                  ? Row(
                      children: [
                        CircleAvatar(
                          radius: 30.0.r,
                          backgroundColor: Colors.transparent,
                          backgroundImage: ImageUtils.getImageProvider(
                              model.avatar ?? '',
                              holderImg: 'me/avatar'),
                        ),
                        Gaps.hGap10,
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    constraints:
                                        BoxConstraints(maxWidth: 150.w),
                                    child: Text(
                                      name,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyles.textBold18
                                          .copyWith(color: Colours.material_bg),
                                    ),
                                  ),
                                  Gaps.hGap10,
                                  if (model.isVip == 1)
                                    LoadAssetImage(
                                      model.vipData?.vipInfo?.skuSubtype == 11
                                          ? 'me/vip_pro'
                                          : (model.vipData?.vipInfo
                                                      ?.skuSubtype ==
                                                  12
                                              ? 'me/vip_statrer'
                                              : ''),
                                      height: 18.h,
                                      fit: BoxFit.fill,
                                    )
                                  else
                                    Gaps.empty,
                                ],
                              ),
                              if (model.isVip == 1)
                                Text(
                                  'Expiry Date: ${model.vipData?.vipInfo?.expiredAt}',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyles.textSize13
                                      .copyWith(color: Colours.material_bg),
                                )
                              else
                                Text(
                                  'Only \$1 per day can boost your business',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyles.textSize13
                                      .copyWith(color: Colours.material_bg),
                                ),
                            ],
                          ),
                        )
                      ],
                    )
                  : Center(
                      child: Text(
                        'Log in',
                        style: TextStyles.textBold18
                            .copyWith(color: Colours.material_bg),
                      ),
                    ),
            )),
      );
    });
  }
}
