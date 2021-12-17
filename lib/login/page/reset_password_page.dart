import 'package:flashinfo/login/model/user_info_model.dart';
import 'package:flashinfo/login/presenter/login_presenter.dart';
import 'package:flashinfo/mvp/base_page.dart';
import 'package:flashinfo/mvp/power_presenter.dart';
import 'package:flashinfo/routers/fluro_navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flashinfo/util/change_notifier_manage.dart';
import 'package:flashinfo/res/resources.dart';
import 'package:flashinfo/util/toast_utils.dart';
import 'package:flashinfo/util/other_utils.dart';
import 'package:flashinfo/widgets/my_app_bar.dart';
import 'package:flashinfo/widgets/my_button.dart';
import 'package:flashinfo/widgets/my_scroll_view.dart';
import 'package:flashinfo/login/widgets/my_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({Key? key, this.emailRegisterModel})
      : super(key: key);
  final EmailRegisterParams? emailRegisterModel;
  @override
  _ResetPasswordPageState createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage>
    with
        ChangeNotifierMixin<ResetPasswordPage>,
        BasePageMixin<ResetPasswordPage, PowerPresenter> {
  //定义一个controller
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _nodeText1 = FocusNode();
  final FocusNode _nodeText2 = FocusNode();
  bool _clickable = false;
  late EmailRegisterParams? emailRegisterModel;
  @override
  Map<ChangeNotifier, List<VoidCallback>?>? changeNotifier() {
    final List<VoidCallback> callbacks = <VoidCallback>[_verify];
    return <ChangeNotifier, List<VoidCallback>?>{
      _nameController: callbacks,
      _passwordController: callbacks,
      _nodeText1: null,
      _nodeText2: null,
    };
  }

  void _verify() {
    final String name = _nameController.text;
    final String password = _passwordController.text;
    bool clickable = true;
    if (name.isEmpty || name.length < 6) {
      clickable = false;
    }

    if (password.isEmpty || password.length < 6) {
      clickable = false;
    }
    if (clickable != _clickable) {
      setState(() {
        _clickable = clickable;
      });
    }
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
  void initState() {
    super.initState();
    emailRegisterModel = widget.emailRegisterModel;
  }

  void _reset() {
    final String name = _nameController.text;
    final String password = _passwordController.text;
    if (name != password) {
      Toast.show('The password is different');
      return;
    }
    emailRegisterModel?.newpwd = password;
    switch (emailRegisterModel?.bingEmail) {
      case 'email':
        _loginPresenter.emailRegister(emailRegisterModel,
            (UserInfoModel? model) {
          NavigatorUtils.goBackToRoot(context);
        });
        break;
      case 'bindEmail':
        _loginPresenter.bindEmail(emailRegisterModel, (UserInfoModel? model) {
          NavigatorUtils.goBackToRoot(context);
        });
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(),
      body: MyScrollView(
        keyboardConfig: Utils.getKeyboardActionsConfig(
            context, <FocusNode>[_nodeText1, _nodeText2]),
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
            onPressed: _clickable ? _reset : null,
            text: 'Submit',
          ),
        ),
      ),
    );
  }

  List<Widget> _buildBody() {
    return <Widget>[
      Gaps.line,
      Gaps.vGap32,
      Text(
        'Password',
        style: TextStyles.textBold15,
      ),
      MyTextField(
        focusNode: _nodeText1,
        isInputPwd: true,
        controller: _nameController,
        maxLength: 16,
        keyboardType: TextInputType.visiblePassword,
        hintText: 'Please enter more than 6 digits password',
      ),
      Gaps.vGap20,
      Text(
        'Confirmed Password',
        style: TextStyles.textBold15,
      ),
      MyTextField(
        focusNode: _nodeText2,
        isInputPwd: true,
        controller: _passwordController,
        maxLength: 16,
        keyboardType: TextInputType.visiblePassword,
        hintText: 'Please confirm the password',
      ),
      Gaps.vGap24,
    ];
  }
}
