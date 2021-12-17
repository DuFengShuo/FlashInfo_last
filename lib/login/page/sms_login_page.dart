import 'package:flashinfo/common/common.dart';
import 'package:flashinfo/login/login_router.dart';
import 'package:flashinfo/login/model/captcha_img_model.dart';
import 'package:flashinfo/login/model/captcha_sms_model.dart';
import 'package:flashinfo/login/model/user_info_model.dart';
import 'package:flashinfo/login/presenter/login_presenter.dart';
import 'package:flashinfo/login/widgets/img_input_dialog.dart';
import 'package:flashinfo/login/widgets/other_login_widget.dart';
import 'package:flashinfo/login/widgets/phone_field.dart';
import 'package:flashinfo/mvp/base_page.dart';
import 'package:flashinfo/mvp/power_presenter.dart';
import 'package:flashinfo/net/net.dart';
import 'package:flashinfo/routers/fluro_navigator.dart';
import 'package:flashinfo/util/send_analytics_event.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flashinfo/util/change_notifier_manage.dart';
import 'package:flashinfo/res/resources.dart';
import 'package:flashinfo/util/toast_utils.dart';
import 'package:flashinfo/util/other_utils.dart';
import 'package:flashinfo/widgets/my_app_bar.dart';
import 'package:flashinfo/widgets/my_scroll_view.dart';
import 'package:flashinfo/login/widgets/my_text_field.dart';
import 'package:flutter/services.dart';
import 'package:rxdart/subjects.dart';

class SMSLoginPage extends StatefulWidget {
  const SMSLoginPage({Key? key}) : super(key: key);

  @override
  _SMSLoginPageState createState() => _SMSLoginPageState();
}

class _SMSLoginPageState extends State<SMSLoginPage>
    with
        ChangeNotifierMixin<SMSLoginPage>,
        BasePageMixin<SMSLoginPage, PowerPresenter> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _vCodeController = TextEditingController();
  final FocusNode _nodeText1 = FocusNode();
  final FocusNode _nodeText2 = FocusNode();
  bool _clickable = false;
  bool _checkboxSelected = false;
  final PublishSubject<bool>? _smsSubject = PublishSubject<bool>();
  final MobileLoginParams mobileLoginParams = MobileLoginParams();
  late CaptchaImgModel? _captchaImgModel;
  CaptchaSmsModel? _captchaSmsModel;
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

  void _verify() {
    final String name = _phoneController.text.trim();
    final String vCode = _vCodeController.text.trim();
    bool clickable = true;
    if (!_checkboxSelected) {
      clickable = false;
    }
    if (name.isEmpty) {
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
  void initState() {
    super.initState();
    _checkboxSelected =
        SpUtil.getBool(Constant.checkboxSelected, defValue: false)!;
    _phoneController.text = SpUtil.getString(Constant.phone).nullSafe;
    WidgetsBinding.instance!.addPostFrameCallback((_) async {});
  }

  @override
  void dispose() {
    super.dispose();
    _smsSubject!.close();
  }

  Future _login() async {
    if (_captchaSmsModel == null) {
      Toast.show('Please get the correct verification code');
      return;
    }
    AnalyticEventUtil.analyticsUtil.sendAnalyticsEvent('Login_Click');
    mobileLoginParams.account = _phoneController.text;
    mobileLoginParams.code = _vCodeController.text;
    mobileLoginParams.captchakey = _captchaSmsModel?.captchaSmsKey;
    await SpUtil.putString(Constant.phone, _phoneController.text);
    await _loginPresenter.login(mobileLoginParams.toJson(), HttpApi.mobileLogin,
        loginSuccess: (UserInfoModel? model) =>
            NavigatorUtils.goBackWithParams(context, true));
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
      appBar: const MyAppBar(),
      body: MyScrollView(
        keyboardConfig: Utils.getKeyboardActionsConfig(
            context, <FocusNode>[_nodeText1, _nodeText2]),
        padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 20.0),
        children: _buildBody(),
      ),
    );
  }

  List<Widget> _buildBody() {
    return <Widget>[
      Gaps.vGap16,
      Text(
        'Mobile Login',
        style: TextStyles.textBold28.copyWith(color: Colours.app_main),
      ),
      Gaps.vGap20,
      Gaps.vGap20,
      Text('Phone', style: TextStyles.textBold15),
      PhoneField(
          phoneController: _phoneController,
          nodeText: _nodeText1,
          areaCode: mobileLoginParams.areaCode,
          onTapAreaCode: () =>
              NavigatorUtils.pushResult(context, LoginRouter.areaCodePage, (e) {
                //     final AreaCodeModel model = e as AreaCodeModel;
                setState(() {
                  mobileLoginParams.areaCode = int.parse(e.toString());
                });
              })),
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
            // await _loginPresenter.captchaImage(_phoneController.text,
            //     (CaptchaImgModel? model) => _showImgInputDialog(model));
            await _loginPresenter.captchaNums('mobile', _phoneController.text,
                (bool value) async {
              if (value) {
                _sendCaptchaSms();
              } else {
                await _loginPresenter.captchaImage(_phoneController.text,
                    (CaptchaImgModel? model) => _showImgInputDialog(model));
              }
            }, areaCode: mobileLoginParams.areaCode.toString());
            return Future<bool>.value(false);
          }
        },
      ),
      OtherLoginWidget(
        clickable: _clickable,
        login: _login,
        checkboxSelected: _checkboxSelected,
        checkboxTap: () async {
          setState(() {
            _checkboxSelected = !_checkboxSelected;
          });
          await SpUtil.putBool(Constant.checkboxSelected, _checkboxSelected);
          _verify();
        },
        typePage: 'mobile',
        thirdPartyLogin: (int index) async {
          switch (index) {
            case 1:
              await _loginPresenter.googleLogin((UserInfoModel? model) {
                NavigatorUtils.goBackToRoot(context);
              });
              break;
            case 2:
              await _loginPresenter.lintingLogin((UserInfoModel? model) {
                NavigatorUtils.goBackToRoot(context);
              });
              break;
            case 3:
              await _loginPresenter.appleLogin((UserInfoModel? model) {
                NavigatorUtils.goBackToRoot(context);
              });
              break;
            default:
          }
        },
      ),
    ];
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
            await _sendCaptchaSms(
                value: value, imageBaseUpdate: imageBaseUpdate);
          },
        );
      },
    );
  }

  Future _sendCaptchaSms(
      {String? value, Function(String image)? imageBaseUpdate}) async {
    final CaptchaSmsParams captchaSmsParams = CaptchaSmsParams();
    if (imageBaseUpdate != null) {
      captchaSmsParams.captchaImageKey = _captchaImgModel?.captchaImageKey;
      captchaSmsParams.captchaImageCode = value;
    }

    captchaSmsParams.areaCode = mobileLoginParams.areaCode;
    captchaSmsParams.mobile = _phoneController.text;
    await _loginPresenter.captchaSms(captchaSmsParams,
        (CaptchaSmsModel? model) {
      if (model == null && imageBaseUpdate != null) {
        _loginPresenter.captchaImage(_phoneController.text,
            (CaptchaImgModel? captchaImgModel) {
          _captchaImgModel = captchaImgModel;
          imageBaseUpdate(captchaImgModel?.captchaImageContent ?? '');
        });
      } else {
        if (imageBaseUpdate != null) {
          NavigatorUtils.goBack(context);
        }
        _captchaSmsModel = model;
        if (model != null) {
          _smsSubject!.add(true);
        }
      }
    });
  }
}
