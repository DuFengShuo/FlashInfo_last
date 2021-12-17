import 'package:flashinfo/common/common.dart';
import 'package:flashinfo/login/login_router.dart';
import 'package:flashinfo/login/model/user_info_model.dart';
import 'package:flashinfo/profile/page/personal/show_modal_email_page.dart';
import 'package:flashinfo/profile/profile_router.dart';
import 'package:flashinfo/profile/widget/profile/prifile_header_widget.dart';
import 'package:flashinfo/profile/widget/profile/profile_contact_widget.dart';
import 'package:flashinfo/provider/user_info_provider.dart';
import 'package:flashinfo/res/colors.dart';
import 'package:flashinfo/res/resources.dart';
import 'package:flashinfo/routers/fluro_navigator.dart';
import 'package:flashinfo/setting/setting_router.dart';
import 'package:flashinfo/util/device_utils.dart';
import 'package:flashinfo/widgets/click_item.dart';
import 'package:flashinfo/widgets/my_scroll_view.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with AutomaticKeepAliveClientMixin {
  late String _version = '';
  late String _buildCount = '';
  late String _environment = '';
  late UserInfoModel? _userInfoModel;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      if (Device.isWeb) {
      } else {
        final PackageInfo packageInfo = await PackageInfo.fromPlatform();
        _version = packageInfo.version;
        _buildCount = packageInfo.buildNumber;
        switch (Constant.baseUrl) {
          case Constant.debugUrl:
            _environment = '开发环境 build $_buildCount';
            break;
          case Constant.testUrl:
            _environment = '测试环境 build $_buildCount';
            break;
          case Constant.mastOnLineUrl:
            _environment = '预发布环境 build $_buildCount';
            break;
          default:
        }
        setState(() {});
      }
      if (SpUtil.getBool(Constant.isLogin, defValue: false) ?? false) {
        if (context.read<UserInfoProvider>().userInfoModel != null) {
          _userInfoModel = context.read<UserInfoProvider>().userInfoModel;
        }
        if (_userInfoModel!.email!.isEmpty &&
            (SpUtil.getBool(Constant.isFirstLogin, defValue: false) ?? false)) {
          await SpUtil.putBool(Constant.isFirstLogin, false);
          showBottomSheet();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      backgroundColor: Colours.bg_color,
      body: MyScrollView(
        crossAxisAlignment: CrossAxisAlignment.center,
        isSafeArea: false,
        bottomButton: Padding(
          padding: EdgeInsets.only(bottom: Dimens.gap_v_dp16),
          child: Text('Version $_version $_environment',
              style:
                  TextStyles.textSize13.copyWith(color: Colours.text_gray_c)),
        ),
        children: _buildBody(),
      ),
    );
  }

  List<Widget> _buildBody() {
    return <Widget>[
      const PrifileHeaderWidget(),
      Gaps.lineV,
      const ProfileContactWidget(),
      Gaps.lineV,
      ClickItem(
        iconName: 0xe640,
        iconColor: const Color(0xffe68575),
        title: 'Export History',
        onTap: () => _onTapCallbackItem(0),
      ),
      ClickItem(
        iconName: 0xe618,
        iconColor: const Color(0xff7BDBC9),
        title: 'User Feedback',
        onTap: () => _onTapCallbackItem(1),
      ),
      Gaps.lineV,
      ClickItem(
        iconName: 0xe619,
        iconColor: Colours.text,
        title: 'Rate in App Store',
        onTap: () async {
          if (Device.isAndroid) {
            await launch(
                'https://play.google.com/store/apps/details?id=com.kuliang.android.flashInfo',
                forceSafariVC: false);
          }
          if (Device.isIOS) {
            await launch('https://apps.apple.com/cn/app/flashinfo/id1576818769',
                forceSafariVC: false);
          }
        },
      ),
      // Gaps.lineV,
      // ClickItem(
      //   iconName: 0xe618,
      //   iconColor: const Color(0xff7BDBC9),
      //   title: 'User Feedback',
      //   onTap: () => _onTapCallbackItem(2),
      // ),
      // ClickItem(
      //   iconName: 0xe619,
      //   iconColor: Colours.text,
      //   title: 'Pay',
      //   onTap: () => NavigatorUtils.push(context, PayRouter.payCopyPage),
      // ),
      // ClickItem(
      //   iconName: 0xe619,
      //   iconColor: Colours.text,
      //   title: 'Pay',
      //   onTap: () => NavigatorUtils.push(context, PayRouter.payPage),
      // ),
    ];
  }

  void _onTapCallbackItem(int index) {
    if (!(SpUtil.getBool(Constant.isLogin, defValue: false) ?? false)) {
      NavigatorUtils.push(context, LoginRouter.smsLoginPage);
      return;
    }
    switch (index) {
      case 0:
        NavigatorUtils.push(context, ProfileRouter.exportHistoryPage);
        break;
      case 1:
        NavigatorUtils.push(context, SettingRouter.feedbackPage);
        break;
      case 2:
        break;
      default:
    }
  }

  //显示底部弹框的功能
  void showBottomSheet() {
    //用于在底部打开弹框的效果
    showModalBottomSheet<void>(
        context: context,
        builder: (BuildContext context) {
          //构建弹框中的内容
          return const ShowModalEmailPage();
        });
  }

  @override
  bool get wantKeepAlive => true;
}
