import 'package:flashinfo/common/common.dart';
import 'package:flashinfo/login/login_router.dart';
import 'package:flashinfo/net/net.dart';
import 'package:flashinfo/res/resources.dart';
import 'package:flashinfo/routers/fluro_navigator.dart';
import 'package:flashinfo/util/device_utils.dart';
import 'package:flashinfo/util/other_utils.dart';
import 'package:flashinfo/widgets/icon_font.dart';
import 'package:flashinfo/widgets/load_image.dart';
import 'package:flashinfo/widgets/my_button.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OtherLoginWidget extends StatelessWidget {
  const OtherLoginWidget(
      {Key? key,
      this.clickable = false,
      this.login,
      this.typePage = 'mobile',
      this.checkboxSelected = false,
      this.checkboxTap,
      this.thirdPartyLogin,
      this.loginTitle = 'Log in'})
      : super(key: key);
  final bool clickable;
  final void Function()? login;
  final String typePage;
  final bool checkboxSelected;
  final void Function()? checkboxTap;
  final void Function(int)? thirdPartyLogin;
  final String loginTitle;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Gaps.vGap20,
        Gaps.vGap20,
        MyButton(onPressed: clickable ? login : null, text: loginTitle),
        Gaps.vGap10,
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: checkboxTap,
              child: SizedBox(
                width: Dimens.gap_dp20,
                height: Dimens.gap_v_dp20,
                child: IconFont(
                    name: checkboxSelected ? 0xe61b : 0xe61c,
                    size: Dimens.font_sp10,
                    color: checkboxSelected
                        ? Colours.app_main
                        : Colours.text_gray_c),
              ),
            ),
            Expanded(
                child: Padding(
              padding: EdgeInsets.only(top: Dimens.gap_v_dp2),
              child: RichText(
                maxLines: 2,
                text: TextSpan(
                  text: 'Sign in and agree',
                  style: Theme.of(context).textTheme.subtitle2,
                  children: <TextSpan>[
                    TextSpan(
                      text: '《User Use Agreement》',
                      style: TextStyle(
                          color: Theme.of(context).errorColor,
                          fontSize: Dimens.font_sp10),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => _launchWebURL(
                            context, 'User Use Agreement', HttpApi.treatyTerms),
                    ),
                    const TextSpan(text: 'and'),
                    TextSpan(
                      text: '《Privacy policy》',
                      style: TextStyle(
                          color: Theme.of(context).errorColor,
                          fontSize: Dimens.font_sp10),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => _launchWebURL(
                            context, 'Privacy policy', HttpApi.privacyPolicy),
                    ),
                    TextSpan(text: Utils.getCurrLocale() == 'zh' ? '。' : '.'),
                  ],
                ),
              ),
            ))
          ],
        ),
        Gaps.vGap20,
        if (typePage != 'register')
          Row(
            children: [
              TextButton(
                onPressed: () {
                  if (typePage == 'mobile') {
                    NavigatorUtils.push(context, LoginRouter.emailLoginPage);
                  }
                  if (typePage == 'email') {
                    NavigatorUtils.goBack(context);
                  }
                },
                child: Text(
                  typePage == 'mobile' ? 'Email Login' : 'Mobile Login',
                  style:
                      TextStyles.textGray10.copyWith(color: Colours.app_main),
                ),
              ),
              const Spacer(),
              RichText(
                maxLines: 2,
                text: TextSpan(
                  text: "Don't have an account？",
                  style: TextStyles.textGray10,
                  children: <TextSpan>[
                    TextSpan(
                      text: 'SIGN UP',
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: Dimens.font_sp10),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          NavigatorUtils.push(
                              context, LoginRouter.registerPage);
                        },
                    ),
                  ],
                ),
              )
            ],
          )
        else
          Center(
            child: RichText(
              maxLines: 2,
              text: TextSpan(
                text: 'already have a account？',
                style: TextStyles.textGray10,
                children: <TextSpan>[
                  TextSpan(
                    text: 'Log In',
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: Dimens.font_sp10),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        NavigatorUtils.goBack(context);
                      },
                  ),
                ],
              ),
            ),
          ),
        Gaps.vGap20,
        Gaps.vGap20,
        Row(
          children: [
            Expanded(child: Gaps.line),
            Gaps.hGap12,
            Text(
              'Or log in with',
              style: TextStyles.textGray10,
            ),
            Gaps.hGap12,
            Expanded(child: Gaps.line),
          ],
        ),
        Gaps.vGap20,
        Gaps.vGap20,
        Container(
          padding: EdgeInsets.symmetric(horizontal: 80.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              otherLogin('google_icon', () => thirdPartyLogin!(1)),
              otherLogin('linked', () => thirdPartyLogin!(2)),
              if (Device.isIOS) otherLogin('apple', () => thirdPartyLogin!(3)),
            ],
          ),
        ),
      ],
    );
  }

  Widget otherLogin(String logIcon, Function()? onTap) {
    return GestureDetector(
      onTap: onTap,
      child: LoadAssetImage('login/$logIcon', width: 35.w),
    );
  }

  void _launchWebURL(BuildContext context, String title, String url) {
    final String uels = Constant.baseUrl.replaceAll('api/', '') + url;
    if (Device.isMobile) {
      NavigatorUtils.goWebViewPage(context, title, uels);
    } else {
      Utils.launchWebURL(url);
    }
  }
}
