import 'package:flashinfo/common/common.dart';
import 'package:flashinfo/login/model/captcha_img_model.dart';
import 'package:flashinfo/login/model/captcha_sms_model.dart';
import 'package:flashinfo/login/presenter/login_presenter.dart';
import 'package:flashinfo/login/widgets/img_input_dialog.dart';
import 'package:flashinfo/login/widgets/my_text_field.dart';
import 'package:flashinfo/mvp/base_page.dart';
import 'package:flashinfo/mvp/power_presenter.dart';
import 'package:flashinfo/net/http_api.dart';
import 'package:flashinfo/profile/presenter/personal_presenter.dart';
import 'package:flashinfo/res/colors.dart';
import 'package:flashinfo/res/resources.dart';
import 'package:flashinfo/routers/fluro_navigator.dart';
import 'package:flashinfo/routers/routers.dart';
import 'package:flashinfo/util/change_notifier_manage.dart';
import 'package:flashinfo/util/other_utils.dart';
import 'package:flashinfo/util/toast_utils.dart';
import 'package:flashinfo/widgets/my_app_bar.dart';
import 'package:flashinfo/widgets/my_button.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class GuidePhonePage extends StatefulWidget {
  const GuidePhonePage({Key? key, required this.personalParams})
      : super(key: key);
  final PersonalParams personalParams;
  @override
  _GuidePhonePageState createState() => _GuidePhonePageState();
}

class _GuidePhonePageState extends State<GuidePhonePage>
    with
        ChangeNotifierMixin<GuidePhonePage>,
        BasePageMixin<GuidePhonePage, PowerPresenter> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _vCodeController = TextEditingController();
  final FocusNode _nodeText1 = FocusNode();
  final FocusNode _nodeText2 = FocusNode();
  bool _clickable = false;
  late final PublishSubject<bool>? _smsSubject = PublishSubject<bool>();
  final MobileLoginParams mobileLoginParams = MobileLoginParams();
  late CaptchaImgModel? _captchaImgModel;
  late CaptchaSmsModel? _captchaSmsModel;
  @override
  Map<ChangeNotifier, List<VoidCallback>?>? changeNotifier() {
    final List<VoidCallback> callbacks = <VoidCallback>[_verify];
    return <ChangeNotifier, List<VoidCallback>?>{
      _phoneController: callbacks,
      _vCodeController: callbacks,
      _nodeText1: null,
      _nodeText2: null,
    };
  }

  late LoginPresenter _loginPresenter;
  late PersonalPresenter _personalPresenter;
  @override
  PowerPresenter createPresenter() {
    final PowerPresenter powerPresenter = PowerPresenter<dynamic>(this);
    _loginPresenter = LoginPresenter();
    _personalPresenter = PersonalPresenter();
    powerPresenter.requestPresenter([_loginPresenter, _personalPresenter]);
    return powerPresenter;
  }

  void _verify() {
    final String name = _phoneController.text;
    final String vCode = _vCodeController.text;
    bool clickable = true;
    if (name.isEmpty || name.length < 11) {
      clickable = false;
    }
    if (vCode.isEmpty || vCode.length < 4) {
      clickable = false;
    }
    if (clickable != _clickable) {
      setState(() {
        _clickable = clickable;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    _smsSubject!.close();
  }

  Future _login() async {
    print(widget.personalParams.toJson());
    mobileLoginParams.account = _phoneController.text;
    mobileLoginParams.code = _vCodeController.text;
    mobileLoginParams.captchakey = _captchaSmsModel?.captchaSmsKey;
    await SpUtil.putString(Constant.phone, _phoneController.text);
    print(mobileLoginParams.toJson());
    await _loginPresenter.login(
        mobileLoginParams.toJson(), HttpApi.mobileLogin);
    await _personalPresenter.updateUser(widget.personalParams.toJson(),
        success: (value) {
      NavigatorUtils.push(context, Routes.home, clearStack: true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        /// 拦截返回，关闭键盘，否则会造成上一页面短暂的组件溢出
        FocusManager.instance.primaryFocus?.unfocus();
        return Future.value(true);
      },
      child: Scaffold(
        appBar: MyAppBar(
          isBack: false,
          actionName: 'Skip',
          onPressed: () =>
              NavigatorUtils.push(context, Routes.home, clearStack: true),
          textColor: Colours.app_main,
        ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: Dimens.gap_dp16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Gaps.line,
                Gaps.vGap50,
                Text(
                  "What's your phone number？",
                  style:
                      TextStyles.textBold28.copyWith(color: Colours.app_main),
                ),
                Gaps.vGap50,
                Gaps.vGap20,
                Text('Phone', style: TextStyles.textBold15),
                MyTextField(
                  focusNode: _nodeText1,
                  controller: _phoneController,
                  maxLength: 11,
                  keyboardType: TextInputType.phone,
                  hintText: 'Phone Number',
                ),
                Gaps.vGap20,
                Gaps.vGap5,
                Text('Verification Code', style: TextStyles.textBold15),
                MyTextField(
                  focusNode: _nodeText2,
                  controller: _vCodeController,
                  maxLength: 4,
                  smsSubject: _smsSubject,
                  keyboardType: TextInputType.number,
                  hintText: 'Fill in Verification code',
                  getVCode: () async {
                    final String name = _phoneController.text;
                    if (name.isEmpty) {
                      Toast.show('Please input valid mobile phone number');
                      return Future<bool>.value(false);
                    } else {
                      await _loginPresenter.captchaImage(
                          _phoneController.text,
                          (CaptchaImgModel? model) =>
                              _showImgInputDialog(model));
                      return Future<bool>.value(false);
                    }
                  },
                ),
                const Spacer(),
                MyButton(
                  key: const Key('Next'),
                  onPressed: _login,
                  text: 'Next',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future _showImgInputDialog(CaptchaImgModel? imgModel) async {
    _captchaImgModel = imgModel;
    showElasticDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return ImageInputDialog(
          imageBase64: _captchaImgModel?.captchaImageContent ?? '',
          imageTab: (imageBaseUpdate) {
            _loginPresenter.captchaImage(_phoneController.text,
                (CaptchaImgModel? captchaImgModel) {
              _captchaImgModel = captchaImgModel;
              imageBaseUpdate(captchaImgModel?.captchaImageContent ?? '');
            });
          },
          onPressed: (String value, imageBaseUpdate) async {
            final CaptchaSmsParams captchaSmsParams = CaptchaSmsParams();
            captchaSmsParams.captchaImageKey =
                _captchaImgModel?.captchaImageKey;
            captchaSmsParams.captchaImageCode = value;
            captchaSmsParams.areaCode = mobileLoginParams.areaCode;
            await _loginPresenter.captchaSms(captchaSmsParams,
                (CaptchaSmsModel? model) {
              if (model == null) {
                _loginPresenter.captchaImage(_phoneController.text,
                    (CaptchaImgModel? captchaImgModel) {
                  _captchaImgModel = captchaImgModel;
                  imageBaseUpdate(captchaImgModel?.captchaImageContent ?? '');
                });
              } else {
                NavigatorUtils.goBack(context);
                _captchaSmsModel = model;
                _smsSubject!.add(true);
              }
            });
          },
        );
      },
    );
  }
}
