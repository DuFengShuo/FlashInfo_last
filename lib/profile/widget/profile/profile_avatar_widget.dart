import 'package:flashinfo/provider/user_info_provider.dart';
import 'package:flashinfo/res/resources.dart';
import 'package:flashinfo/util/image_utils.dart';
import 'package:flashinfo/widgets/icon_font.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileAvatarWidget extends StatelessWidget {
  const ProfileAvatarWidget({Key? key, this.onTap}) : super(key: key);
  final void Function(int, BuildContext)? onTap;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Gaps.hGap16,
        InkWell(
          onTap: () => onTap!(1, context),
          child: Consumer<UserInfoProvider>(builder: (_, provider, __) {
            return CircleAvatar(
              radius: 30.0.r,
              backgroundColor: Colors.transparent,
              backgroundImage: ImageUtils.getImageProvider(
                  provider.userInfoModel?.avatar ?? '',
                  holderImg: 'me/avatar'),
            );
          }),
        ),
        Gaps.hGap20,
        Expanded(
          child: Consumer<UserInfoProvider>(builder: (_, provider, __) {
            String name = '';
            if ((provider.userInfoModel?.firstName ?? '').isNotEmpty ||
                (provider.userInfoModel?.lastName ?? '').isNotEmpty) {
              name = (provider.userInfoModel?.firstName ?? '') +
                  ' ' +
                  (provider.userInfoModel?.lastName ?? '');
            }
            name = name.isEmpty ? provider.userInfoModel?.name ?? '' : name;
            name = name.isEmpty ? provider.userInfoModel?.mobile ?? '' : name;
            name = name.isEmpty ? provider.userInfoModel?.email ?? '' : name;
            return GestureDetector(
              onTap: () => onTap!(2, context),
              child: Container(
                alignment: Alignment.centerLeft,
                width: double.infinity,
                height: 60.h,
                child: provider.userInfoModel != null
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Consumer<UserInfoProvider>(
                              builder: (_, provider, __) {
                            return Text(
                              name,
                              style: TextStyles.textBold18
                                  .copyWith(color: Colours.material_bg),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            );
                          }),
                          Row(
                            children: [
                              Text(
                                'Personal Profile',
                                style: TextStyles.textSize14
                                    .copyWith(color: Colours.material_bg),
                              ),
                              Gaps.hGap4,
                              IconFont(
                                  name: 0xe63f,
                                  size: Dimens.font_sp13,
                                  color: Colours.material_bg),
                            ],
                          ),
                        ],
                      )
                    : Text(
                        'Not logged in',
                        style: TextStyles.textBold18
                            .copyWith(color: Colours.material_bg),
                      ),
              ),
            );
          }),
        ),
      ],
    );
  }
}
