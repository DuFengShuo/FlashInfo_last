import 'dart:async';

import 'package:flashinfo/common/common.dart';
import 'package:flashinfo/login/login_router.dart';
import 'package:flashinfo/login/model/captcha_email_model.dart';
import 'package:flashinfo/login/model/captcha_img_model.dart';
import 'package:flashinfo/login/model/captcha_sms_model.dart';
import 'package:flashinfo/login/model/user_info_model.dart';
import 'package:flashinfo/login/presenter/login_presenter.dart';
import 'package:flashinfo/mvp/base_page.dart';
import 'package:flashinfo/mvp/power_presenter.dart';
import 'package:flashinfo/res/resources.dart';
import 'package:flashinfo/res/styles.dart';
import 'package:flashinfo/routers/fluro_navigator.dart';
import 'package:flashinfo/util/other_utils.dart';
import 'package:flashinfo/widgets/my_app_bar.dart';
import 'package:flashinfo/widgets/my_button.dart';
import 'package:flashinfo/widgets/my_scroll_view.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EmailVerifyPage extends StatefulWidget {
  const EmailVerifyPage({Key? key, this.emailVerifyParams}) : super(key: key);
  // final CaptchaImgModel? captchaImgModel;
  final EmailVerifyParams? emailVerifyParams;
  @override
  _EmailVerifyPageState createState() => _EmailVerifyPageState();
}

class _EmailVerifyPageState extends State<EmailVerifyPage>
    with BasePageMixin<EmailVerifyPage, PowerPresenter> {
  final FocusNode _focusNode = FocusNode();
  final TextEditingController _controller = TextEditingController();
  final List<String> _codeList = ['', '', '', ''];

  /// 倒计时秒数
  final int _second = 60;

  /// 当前秒数
  late int _currentSecond = 0;
  StreamSubscription? _subscription;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      _countdown();
    });
  }

  void _countdown() {
    _subscription = Stream.periodic(const Duration(seconds: 1), (int i) => i)
        .take(_second)
        .listen((int i) {
      setState(() {
        _currentSecond = _second - i - 1;
      });
    });
  }

  Future _postCaptchaSms() async {
    await _loginPresenter.captchaSms(widget.emailVerifyParams?.captchaSmsParams,
        (CaptchaSmsModel? model) {
      widget.emailVerifyParams?.captchaSmsModel = model;
      _countdown();
    });
  }

  Future _postCaptchaEmail() async {
    await _loginPresenter.captchaEmail(
        widget.emailVerifyParams?.captchaImgModel,
        widget.emailVerifyParams?.account ?? '', (CaptchaEmailModel? model) {
      if (model != null) {
        widget.emailVerifyParams?.captchaEmailModel = model;
        _countdown();
      }
    });
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
  void dispose() {
    _subscription?.cancel();
    _focusNode.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(),
      body: MyScrollView(
        crossAxisAlignment: CrossAxisAlignment.center,
        keyboardConfig: Utils.getKeyboardActionsConfig(context, <FocusNode>[]),
        padding: EdgeInsets.symmetric(horizontal: Dimens.gap_dp16),
        children: _buildBody(),
        bottomButton: Container(
          decoration: BoxDecoration(
            border: Border(
              top: Divider.createBorderSide(context, width: 5.h),
            ),
          ),
          padding: EdgeInsets.only(
              left: Dimens.gap_dp16,
              right: Dimens.gap_dp16,
              top: Dimens.gap_dp16),
          child: MyButton(
            key: const Key('Submit'),
            minHeight: 45.h,
            onPressed: () async {
              if (_controller.text.length != 4) {
                showToast('Please enter the correct verification code');
                return;
              }
              final Map<String, String> params = <String, String>{};
              params['code'] = _controller.text;
              switch (widget.emailVerifyParams?.pageType) {
                case 'phone':
                  params['captcha_key'] = widget
                          .emailVerifyParams?.captchaSmsModel?.captchaSmsKey ??
                      '';
                  break;
                case 'email':
                case 'bindEmail':
                  params['captcha_key'] = widget.emailVerifyParams
                          ?.captchaEmailModel?.captchaEmailKey ??
                      '';

                  break;
                default:
              }
              await _loginPresenter.verificationCode(params, (value) async {
                if (value) {
                  switch (widget.emailVerifyParams?.pageType) {
                    case 'phone':
                      final MobileLoginParams mobileLoginParams =
                          MobileLoginParams();
                      mobileLoginParams.captchakey = widget
                          .emailVerifyParams?.captchaSmsModel?.captchaSmsKey;
                      mobileLoginParams.account =
                          widget.emailVerifyParams?.account;
                      mobileLoginParams.code = _controller.text;
                      mobileLoginParams.areaCode =
                          widget.emailVerifyParams?.captchaSmsParams?.areaCode;
                      _loginPresenter.bindMobile(mobileLoginParams,
                          (UserInfoModel? model) {
                        if (model != null) {
                          NavigatorUtils.goBackToRoot(context);
                        }
                      });
                      break;
                    case 'email':
                    case 'bindEmail':
                      final EmailRegisterParams params = EmailRegisterParams();
                      params.email = widget.emailVerifyParams?.account;
                      params.captchaEmailKey = widget.emailVerifyParams
                          ?.captchaEmailModel?.captchaEmailKey;
                      params.code = _controller.text;
                      params.bingEmail = widget.emailVerifyParams?.pageType;
                      await SpUtil.putString(
                          Constant.email, params.email ?? '');
                      NavigatorUtils.pushResult(
                          context, LoginRouter.resetPasswordPage, (value) {
                        print(value);
                      }, arguments: params);
                      break;
                    default:
                  }
                }
              });
            },
            text: 'Submit',
          ),
        ),
      ),
    );
  }

  List<Widget> _buildBody() {
    final Color textColor = Theme.of(context).primaryColor;
    return <Widget>[
      Gaps.line,
      Gaps.vGap20,
      Gaps.vGap20,
      Text(
        'We sent you a code to verify your',
        style: TextStyles.textBold16,
      ),
      Text(
        'eamil address',
        style: TextStyles.textBold16,
      ),
      Gaps.vGap20,
      Text(
        'Sent to ${widget.emailVerifyParams?.account ?? ''} ',
        style: TextStyles.textGray14,
      ),
      Gaps.vGap20,
      Gaps.vGap10,
      Stack(
        children: <Widget>[
          EditableText(
            controller: _controller,
            focusNode: _focusNode,
            keyboardType: TextInputType.number,

            /// 指定键盘外观，仅iOS有效
            keyboardAppearance: Brightness.dark,

            /// 只能为数字、6位
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(4)
            ],
            // 隐藏光标与字体颜色，达到隐藏输入框的目的
            cursorColor: Colors.transparent,
            cursorWidth: 0,
            textAlign: TextAlign.center,
            backgroundCursorColor: Colors.transparent,
            style: TextStyle(
                color: Colors.transparent, fontSize: Dimens.font_sp18),
            onChanged: (v) {
              for (var i = 0; i < _codeList.length; i++) {
                if (i < v.length) {
                  _codeList[i] = v.substring(i, i + 1);
                } else {
                  _codeList[i] = '';
                }
              }
              setState(() {});
            },
          ),
          GestureDetector(
            onTap: () {
              /// 一直怼，会有概率造成键盘抖动，加一个键盘时候弹出判断
              if (MediaQuery.of(context).viewInsets.bottom < 10) {
                final focusScope = FocusScope.of(context);
                focusScope.unfocus();
                Future.delayed(
                    Duration.zero, () => focusScope.requestFocus(_focusNode));
              }
            },
            child: Container(
              key: const Key('vcode'),
              color: Colors.transparent,
              padding: EdgeInsets.symmetric(horizontal: 40.0.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(
                    _codeList.length, (i) => _buildInputWidget(i, textColor)),
              ),
            ),
          ),
        ],
      ),
      Gaps.vGap50,
      Gaps.vGap10,
      Text(
        'I didn‘t receive a code',
        style: TextStyles.textSize15,
      ),
      Gaps.vGap10,
      TextButton(
        onPressed: () {
          if (_currentSecond == 0) {
            switch (widget.emailVerifyParams?.pageType) {
              case 'phone':
                _postCaptchaSms();
                break;
              case 'email':
              case 'bindEmail':
                _postCaptchaEmail();
                break;
              default:
            }
          }
        },
        child: Text(
          _currentSecond > 0 ? '$_currentSecond' : 'Resend',
          style: TextStyles.textSize15.copyWith(color: Colours.app_main),
        ),
      ),
    ];
  }

  Widget _buildInputWidget(int p, Color textColor) {
    return Container(
        height: 50.0.h,
        width: 50.0.w,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(
              width: 0.6.w,
              color: _codeList[p].isNotEmpty ? textColor : Colours.text_gray_c),
          borderRadius: BorderRadius.circular(4.0.w),
        ),
        child: Text(
          _codeList[p],
          style: TextStyle(fontSize: Dimens.font_sp18),
        ));
  }
}

class EmailVerifyParams {
  EmailVerifyParams({
    this.pageType,
    this.account,
    this.captchaImgModel,
    this.captchaSmsModel,
  });
  late String? pageType;
  late String? account;
  CaptchaImgModel? captchaImgModel;
  CaptchaSmsModel? captchaSmsModel;
  CaptchaEmailModel? captchaEmailModel;
  CaptchaSmsParams? captchaSmsParams;
}
