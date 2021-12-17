import 'package:flashinfo/provider/user_info_provider.dart';
import 'package:flashinfo/res/resources.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileRecordWidget extends StatelessWidget {
  const ProfileRecordWidget({Key? key, this.onTap}) : super(key: key);
  final void Function(int, BuildContext)? onTap;
  @override
  Widget build(BuildContext context) {
    return Consumer<UserInfoProvider>(builder: (_, provider, __) {
      return Row(
        children: [
          _headerItem(provider.userInfoModel?.favoriteCount ?? 0, 'Follow List',
              () => onTap!(3, context)),
          _headerItem(provider.userInfoModel?.browsingCount ?? 0,
              'Browsing History', () => onTap!(4, context)),
        ],
      );
    });
  }

  Widget _headerItem(int title, String text, Function onTap) {
    return Expanded(
      child: InkWell(
        onTap: () => onTap(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('$title',
                style: TextStyles.textBold20.copyWith(
                    color: Colours.material_bg, fontWeight: FontWeight.bold)),
            Gaps.vGap4,
            Text(
              text,
              style: TextStyles.textGray12.copyWith(color: Colours.material_bg),
            ),
          ],
        ),
      ),
    );
  }
}
