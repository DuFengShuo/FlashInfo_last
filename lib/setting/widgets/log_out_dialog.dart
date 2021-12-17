import 'package:flashinfo/login/login_router.dart';
import 'package:flashinfo/provider/group_provider.dart';
import 'package:flashinfo/provider/user_info_provider.dart';
import 'package:flashinfo/res/resources.dart';
import 'package:flashinfo/routers/fluro_navigator.dart';
import 'package:flashinfo/widgets/base_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class LogOutDialog extends StatelessWidget {
  const LogOutDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseDialog(
      title: 'prompt',
      textAlign: TextAlign.center,
      rightTitle: 'Log Out',
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 8.0.h),
        child: Text('Are you sure you want to log out?',
            style: TextStyles.textSize16),
      ),
      onPressed: () {
        if (context.read<GroupProvider>().groupCompanyListProvider != null) {
          context.read<GroupProvider>().groupCompanyListProvider!.clear();
        }
        if (context.read<GroupProvider>().groupPersonnelListProvider != null) {
          context.read<GroupProvider>().groupPersonnelListProvider!.clear();
        }
        if (context.read<GroupProvider>().groupProductListProvider != null) {
          context.read<GroupProvider>().groupProductListProvider!.clear();
        }
        if (context.read<GroupProvider>().groupBrandListProvider != null) {
          context.read<GroupProvider>().groupBrandListProvider!.clear();
        }
        context.read<UserInfoProvider>().logOut();
        NavigatorUtils.goBack(context);
        NavigatorUtils.goBackWithParams(context, '');
        NavigatorUtils.push(context, LoginRouter.smsLoginPage);
      },
    );
  }
}
