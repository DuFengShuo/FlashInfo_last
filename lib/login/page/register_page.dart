import 'package:flashinfo/common/common.dart';
import 'package:flashinfo/login/login_router.dart';
import 'package:flashinfo/login/model/captcha_email_model.dart';
import 'package:flashinfo/login/model/captcha_img_model.dart';
import 'package:flashinfo/login/model/user_info_model.dart';
import 'package:flashinfo/login/page/email_verify_page.dart';
import 'package:flashinfo/login/presenter/login_presenter.dart';
import 'package:flashinfo/login/widgets/img_input_dialog.dart';
import 'package:flashinfo/login/widgets/other_login_widget.dart';
import 'package:flashinfo/mvp/base_page.dart';
import 'package:flashinfo/mvp/power_presenter.dart';
import 'package:flashinfo/routers/fluro_navigator.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flashinfo/util/change_notifier_manage.dart';
import 'package:flashinfo/res/resources.dart';
import 'package:flashinfo/util/other_utils.dart';
import 'package:flashinfo/widgets/my_app_bar.dart';
import 'package:flashinfo/widgets/my_scroll_view.dart';
import 'package:flashinfo/login/widgets/my_text_field.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage>
    with
        ChangeNotifierMixin<RegisterPage>,
        BasePageMixin<RegisterPage, PowerPresenter> {
  final TextEditingController _emailController = TextEditingController();
  final FocusNode _nodeText1 = FocusNode();
  bool _clickable = false;
  bool _checkboxSelected = false;
  late CaptchaImgModel? _captchaImgModel;
  @override
  Map<ChangeNotifier, List<VoidCallback>?>? changeNotifier() {
    final List<VoidCallback> callbacks = <VoidCallback>[_verify];
    return <ChangeNotifier, List<VoidCallback>?>{
      _emailController: callbacks,
      _nodeText1: null,
    };
  }

  void _verify() {
    final String name = _emailController.text;
    bool clickable = true;
    if (name.isEmpty) {
      clickable = false;
    }
    if (!_checkboxSelected) {
      clickable = false;
    }

    /// 状态不一样再刷新，避免不必要的setState
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
    _emailController.text = SpUtil.getString(Constant.email).nullSafe;
    WidgetsBinding.instance!.addPostFrameCallback((_) async {});
  }

  late LoginPresenter _loginPresenter;

  @override
  PowerPresenter createPresenter() {
    final PowerPresenter powerPresenter = PowerPresenter<dynamic>(this);
    _loginPresenter = LoginPresenter();
    powerPresenter.requestPresenter([_loginPresenter]);
    return powerPresenter;
  }

  Future _login() async {
    if (!Utils.isEmail(_emailController.text.trim())) {
      showToast('Please enter the correct email address');
      return;
    }
    await _loginPresenter.captchaNums('email', _emailController.text.trim(),
        (bool value) async {
      if (value) {
        await _loginPresenter.captchaEmail(null, _emailController.text,
            (CaptchaEmailModel? model) {
          if (model != null) {
            final EmailVerifyParams params = EmailVerifyParams();
            params.account = _emailController.text.trim();
            params.captchaEmailModel = model;
            params.pageType = 'email';
            NavigatorUtils.pushResult(context, LoginRouter.emailVerifyPage,
                (value) {
              print(value);
            }, arguments: params);
          }
        });
      } else {
        await _loginPresenter.captchaImage(_emailController.text,
            (CaptchaImgModel? model) => _showImgInputDialog(model, context));
      }
    });

    await SpUtil.putString(Constant.email, _emailController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(),
      body: MyScrollView(
        keyboardConfig:
            Utils.getKeyboardActionsConfig(context, <FocusNode>[_nodeText1]),
        padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 20.0),
        children: _buildBody(),
      ),
    );
  }

  List<Widget> _buildBody() {
    return <Widget>[
      Gaps.vGap16,
      Text(
        'Sign Up',
        style: TextStyles.textBold28.copyWith(color: Colours.app_main),
      ),
      Gaps.vGap20,
      Gaps.vGap20,
      Text('Enter email address', style: TextStyles.textBold15),
      MyTextField(
        focusNode: _nodeText1,
        controller: _emailController,
        maxLength: 30,
        keyboardType: TextInputType.visiblePassword,
        hintText: 'Email',
      ),
      Gaps.vGap10,
      Text(
        'The system will send an email containing a verification code to the filled mailbox',
        style: TextStyles.textSize12.copyWith(color: Colours.text_gray_c),
      ),
      Gaps.vGap20,
      Gaps.vGap20,
      Gaps.vGap5,
      OtherLoginWidget(
        loginTitle: 'Sign up',
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
        typePage: 'register',
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

  Future _showImgInputDialog(
      CaptchaImgModel? imgModel, BuildContext _context) async {
    _captchaImgModel = imgModel;
    showElasticDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return ImageInputDialog(
          imageBase64: _captchaImgModel?.captchaImageContent ?? '',
          imageTab: (imageBaseUpdate) {
            _loginPresenter.captchaImage(_emailController.text,
                (CaptchaImgModel? captchaImgModel) {
              _captchaImgModel = captchaImgModel;
              imageBaseUpdate(captchaImgModel?.captchaImageContent ?? '');
            });
          },
          onPressed: (String value, imageBaseUpdate) async {
            _captchaImgModel?.captchaImageCode = value;
            await _loginPresenter
                .captchaEmail(_captchaImgModel, _emailController.text,
                    (CaptchaEmailModel? model) {
              final EmailVerifyParams params = EmailVerifyParams();
              params.account = _emailController.text;
              params.captchaEmailModel = model;
              params.captchaImgModel = _captchaImgModel;
              params.pageType = 'email';
              if (model == null) {
                _loginPresenter.captchaImage(_emailController.text,
                    (CaptchaImgModel? captchaImgModel) {
                  _captchaImgModel = captchaImgModel;
                  imageBaseUpdate(captchaImgModel?.captchaImageContent ?? '');
                });
              } else {
                NavigatorUtils.goBack(context);
                NavigatorUtils.pushResult(_context, LoginRouter.emailVerifyPage,
                    (value) {
                  print(value);
                }, arguments: params);
              }
            });
          },
        );
      },
    );
  }
}
