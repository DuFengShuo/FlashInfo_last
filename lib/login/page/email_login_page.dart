import 'package:flashinfo/common/common.dart';
import 'package:flashinfo/login/model/user_info_model.dart';
import 'package:flashinfo/login/presenter/login_presenter.dart';
import 'package:flashinfo/login/widgets/other_login_widget.dart';
import 'package:flashinfo/mvp/base_page.dart';
import 'package:flashinfo/mvp/power_presenter.dart';
import 'package:flashinfo/net/net.dart';
import 'package:flashinfo/routers/fluro_navigator.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flashinfo/util/change_notifier_manage.dart';
import 'package:flashinfo/res/resources.dart';
import 'package:flashinfo/util/other_utils.dart';
import 'package:flashinfo/widgets/my_app_bar.dart';
import 'package:flashinfo/widgets/my_scroll_view.dart';
import 'package:flashinfo/login/widgets/my_text_field.dart';

/// design/1注册登录/index.html#artboard4
class EmailLoginPage extends StatefulWidget {
  const EmailLoginPage({Key? key}) : super(key: key);

  @override
  _EmailLoginPageState createState() => _EmailLoginPageState();
}

class _EmailLoginPageState extends State<EmailLoginPage>
    with
        ChangeNotifierMixin<EmailLoginPage>,
        BasePageMixin<EmailLoginPage, PowerPresenter> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _nodeText1 = FocusNode();
  final FocusNode _nodeText2 = FocusNode();
  bool _clickable = false;
  bool _checkboxSelected = false;
  @override
  Map<ChangeNotifier, List<VoidCallback>?>? changeNotifier() {
    final List<VoidCallback> callbacks = <VoidCallback>[_verify];
    return <ChangeNotifier, List<VoidCallback>?>{
      _emailController: callbacks,
      _passwordController: callbacks,
      _nodeText1: null,
      _nodeText2: null,
    };
  }

  late LoginPresenter _loginPresenter;
  @override
  PowerPresenter createPresenter() {
    final PowerPresenter powerPresenter = PowerPresenter<dynamic>(this);
    _loginPresenter = LoginPresenter();
    powerPresenter.requestPresenter([_loginPresenter]);
    return powerPresenter;
  }

  void _verify() {
    final String email = _emailController.text;
    final String password = _passwordController.text;
    bool clickable = true;
    if (!_checkboxSelected) {
      clickable = false;
    }
    if (email.isEmpty) {
      clickable = false;
    }
    if (password.isEmpty || password.length < 6) {
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

  Future _login() async {
    if (!Utils.isEmail(_emailController.text)) {
      showToast('Please enter the correct email address');
      return;
    }
    final Map<String, dynamic> params = <String, dynamic>{};
    params['account'] = _emailController.text;
    params['password'] = _passwordController.text;
    await SpUtil.putString(Constant.email, _emailController.text);
    await _loginPresenter.login(params, HttpApi.login,
        loginSuccess: (UserInfoModel? model) {
      NavigatorUtils.goBack(context);
      NavigatorUtils.goBackWithParams(context, true);
    });
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
        'Email Login',
        style: TextStyles.textBold28.copyWith(color: Colours.app_main),
      ),
      Gaps.vGap20,
      Gaps.vGap20,
      Text('Email', style: TextStyles.textBold15),
      MyTextField(
        focusNode: _nodeText1,
        controller: _emailController,
        maxLength: 30,
        hintText: 'Email Address',
        keyboardType: TextInputType.visiblePassword,
      ),
      Gaps.vGap20,
      Gaps.vGap5,
      Text('Psaawprd', style: TextStyles.textBold15),
      MyTextField(
        key: const Key('password'),
        keyName: 'password',
        focusNode: _nodeText2,
        isInputPwd: true,
        controller: _passwordController,
        keyboardType: TextInputType.visiblePassword,
        maxLength: 16,
        hintText: 'Please fill in the password',
      ),
      OtherLoginWidget(
        clickable: _clickable,
        login: _login,
        typePage: 'email',
        checkboxSelected: _checkboxSelected,
        checkboxTap: () async {
          setState(() {
            _checkboxSelected = !_checkboxSelected;
          });
          await SpUtil.putBool(Constant.checkboxSelected, _checkboxSelected);
          _verify();
        },
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

  void backTo(String pageName) {
    Navigator.of(context).popUntil((route) => route.settings.name == pageName);
  }
}
