import 'package:flashinfo/login/model/user_info_model.dart';
import 'package:flashinfo/login/presenter/login_presenter.dart';
import 'package:flashinfo/mvp/base_page.dart';
import 'package:flashinfo/mvp/power_presenter.dart';
import 'package:flashinfo/profile/widget/input_text_page.dart';
import 'package:flashinfo/provider/user_info_provider.dart';
import 'package:flashinfo/res/colors.dart';
import 'package:flashinfo/res/dimens.dart';
import 'package:flashinfo/res/gaps.dart';
import 'package:flashinfo/res/styles.dart';
import 'package:flashinfo/routers/fluro_navigator.dart';
import 'package:flashinfo/util/device_utils.dart';
import 'package:flashinfo/util/toast_utils.dart';
import 'package:flashinfo/widgets/click_item.dart';
import 'package:flashinfo/widgets/my_app_bar.dart';
import 'package:flashinfo/widgets/my_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../profile_router.dart';

class PersonalPage extends StatefulWidget {
  const PersonalPage({Key? key}) : super(key: key);

  @override
  _PersonalPageState createState() => _PersonalPageState();
}

class _PersonalPageState extends State<PersonalPage>
    with BasePageMixin<PersonalPage, PowerPresenter> {
  @override
  void initState() {
    super.initState();
  }

  late LoginPresenter _loginPresenter;
  @override
  PowerPresenter createPresenter() {
    final PowerPresenter powerPresenter = PowerPresenter<dynamic>(this);
    _loginPresenter = LoginPresenter();
    powerPresenter.requestPresenter([_loginPresenter]);
    return powerPresenter;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colours.bg_color,
      appBar: const MyAppBar(
        centerTitle: 'Personal Profile',
      ),
      body: MyScrollView(
        children: _buildBody(),
        // bottomButton: Container(
        //   padding: EdgeInsets.symmetric(
        //       vertical: Dimens.gap_dp20, horizontal: Dimens.gap_dp16),
        //   child: MyButton(
        //     key: const Key('Submit'),
        //     minHeight: 40.h,
        //     onPressed: _submit,
        //     text: 'Submit',
        //   ),
        // ),
      ),
    );
  }

  List<Widget> _buildBody() {
    return <Widget>[
      Gaps.line,
      Container(
        width: double.infinity,
        color: Colours.material_bg,
        padding: EdgeInsets.symmetric(
            horizontal: Dimens.gap_dp16, vertical: Dimens.gap_v_dp16),
        child: Text(
          'Basic  information',
          style: TextStyles.textBold15,
        ),
      ),
      Consumer<UserInfoProvider>(builder: (_, provider, __) {
        return ClickItem(
          title: 'Full Name',
          titleStyle: TextStyles.textBold13,
          content: (provider.userInfoModel?.firstName ?? '') +
              ' ' +
              (provider.userInfoModel?.lastName ?? ''),
          onTap: () =>
              NavigatorUtils.push(context, ProfileRouter.personalNamePage),
        );
      }),
      ClickItem(
          title: 'Job experience',
          titleStyle: TextStyles.textBold13,
          onTap: () =>
              NavigatorUtils.push(context, ProfileRouter.personalJobPage)),
      Gaps.lineV,
      Container(
        width: double.infinity,
        color: Colours.material_bg,
        padding: EdgeInsets.symmetric(
            horizontal: Dimens.gap_dp16, vertical: Dimens.gap_v_dp16),
        child: Text(
          'Binding information',
          style: TextStyles.textBold15,
        ),
      ),
      Consumer<UserInfoProvider>(builder: (_, provider, __) {
        return ClickItem(
          title: 'Phone number',
          titleStyle: TextStyles.textBold13,
          content: provider.userInfoModel?.mobile ?? '',
          onTap: () => _goInputTextPage(
            context,
            true,
            'Enter mobile number',
            'mobile number',
            provider.userInfoModel?.mobile ?? '',
            (result) {
              Toast.show(result.toString());
            },
            otherText:
                'The system will send the verification code to the entered mobile phone number',
            title: 'Mobile binding',
            pageType: 'phone',
            areaCode: provider.userInfoModel!.areaCode!.isEmpty
                ? 86
                : int.parse(provider.userInfoModel!.areaCode ?? '86'),
          ),
        );
      }),
      Consumer<UserInfoProvider>(builder: (_, provider, __) {
        return ClickItem(
          title: 'Personal Email',
          titleStyle: TextStyles.textBold13,
          content: provider.userInfoModel?.email ?? '',
          onTap: () => _goInputTextPage(
            context,
            true,
            'Enter email address',
            'Email',
            provider.userInfoModel?.email ?? '',
            (result) {
              Toast.show(result.toString());
            },
            otherText:
                'The system will send an email containing a verification code to the filled mailbox',
            title: 'Mailbox binding',
            pageType: 'bindEmail',
          ),
        );
      }),
      Consumer<UserInfoProvider>(builder: (_, provider, __) {
        final BindData? linkedinbindData = _getSocials(
            provider.userInfoModel?.socials?.bindList ?? [], 'linkedin');
        final BindData? applebindData = _getSocials(
            provider.userInfoModel?.socials?.bindList ?? [], 'apple');
        final BindData? googlebindData = _getSocials(
            provider.userInfoModel?.socials?.bindList ?? [], 'google');

        String appleName = '-';
        if (applebindData != null) {
          appleName = applebindData.name!.isEmpty
              ? appleName
              : (applebindData.name ?? '');
          appleName = appleName.isNotEmpty && applebindData.nickName!.isEmpty
              ? appleName
              : (applebindData.nickName ?? '');
        }
        String googleName = '-';
        if (googlebindData != null) {
          googleName = googlebindData.name!.isEmpty
              ? googleName
              : (googlebindData.name ?? '');
          googleName = googleName.isNotEmpty && googlebindData.nickName!.isEmpty
              ? googleName
              : (googlebindData.nickName ?? '');
        }
        String linkedinName = '-';
        if (linkedinbindData != null) {
          linkedinName = linkedinbindData.name!.isEmpty
              ? linkedinName
              : (linkedinbindData.name ?? '');
          linkedinName =
              linkedinName.isNotEmpty && linkedinbindData.nickName!.isEmpty
                  ? linkedinName
                  : (linkedinbindData.nickName ?? '');
        }
        return Column(
          children: [
            ClickItem(
              onTap:
                  linkedinbindData == null ? () => _thirdPartyLogin(2) : null,
              title: 'LinkedIn account',
              titleStyle: TextStyles.textBold13,
              content: linkedinbindData == null ? 'Connect' : linkedinName,
              contentStyle:
                  TextStyles.textGray10.copyWith(color: Colours.app_main),
            ),
            if (Device.isIOS)
              ClickItem(
                onTap: applebindData == null ? () => _thirdPartyLogin(3) : null,
                title: 'Apple Acount',
                titleStyle: TextStyles.textBold13,
                content: applebindData == null ? 'Connect' : appleName,
                contentStyle:
                    TextStyles.textGray10.copyWith(color: Colours.app_main),
              ),
            ClickItem(
              onTap: googlebindData == null ? () => _thirdPartyLogin(1) : null,
              title: 'Google account',
              titleStyle: TextStyles.textBold13,
              content: googlebindData == null ? 'Connect' : googleName,
              contentStyle: TextStyles.textGray10.copyWith(
                  color: googlebindData == null
                      ? Colours.app_main
                      : Colours.text_gray_c),
            ),
          ],
        );
      }),
    ];
  }

  Future _thirdPartyLogin(int index) async {
    switch (index) {
      case 1:
        await _loginPresenter.googleLogin((UserInfoModel? model) {});
        break;
      case 2:
        await _loginPresenter.lintingLogin((UserInfoModel? model) {});
        break;
      case 3:
        await _loginPresenter.appleLogin((UserInfoModel? model) {});
        break;
      default:
    }
  }

  BindData? _getSocials(List<BindData>? list, String type) {
    BindData? bindData;
    if (list != null && list.isNotEmpty) {
      list.forEach((BindData item) {
        if (item.type == type) {
          bindData = item;
        }
      });
    }

    return bindData;
  }

  Future<void> onTapCallbackItem(int index) async {}
  void _goInputTextPage(
    BuildContext context,
    bool isNext,
    String titleText,
    String hintText,
    String content,
    Function(Object?) function, {
    TextInputType? keyboardType,
    String? otherText,
    String? title,
    String? pageType,
    int? areaCode,
  }) {
    NavigatorUtils.pushResult(context, ProfileRouter.inputTextPage, function,
        arguments: InputTextPageArgumentsData(
          isNext: isNext,
          title: title,
          titleText: titleText,
          hintText: hintText,
          content: content,
          otherText: otherText,
          keyboardType: keyboardType,
          pageType: pageType,
          areaCode: areaCode,
        ));
  }
}
