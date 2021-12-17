import 'package:flashinfo/login/presenter/login_presenter.dart';
import 'package:fluro/fluro.dart';
import 'package:flashinfo/routers/i_router.dart';

import 'page/area_code_page.dart';
import 'page/email_login_page.dart';
import 'page/email_verify_page.dart';
import 'page/register_page.dart';
import 'page/reset_password_page.dart';
import 'page/sms_login_page.dart';

class LoginRouter implements IRouterProvider {
  static String loginPage = '/login';
  static String emailLoginPage = '/login/email';
  static String registerPage = '/login/register';
  static String emailVerifyPage = '/login/emailVerify';
  static String smsLoginPage = '/login/smsLogin';
  static String resetPasswordPage = '/login/resetPassword';
  static String areaCodePage = '/login/areaCode';

  @override
  void initRouter(FluroRouter router) {
    router.define(emailLoginPage,
        handler: Handler(handlerFunc: (_, __) => const EmailLoginPage()));
    router.define(registerPage,
        handler: Handler(handlerFunc: (_, __) => const RegisterPage()));
    router.define(emailVerifyPage,
        handler: Handler(handlerFunc: (context, params) {
      final args = context?.settings?.arguments == null
          ? null
          : context!.settings!.arguments! as EmailVerifyParams;
      return EmailVerifyPage(emailVerifyParams: args);
    }));

    router.define(smsLoginPage,
        handler: Handler(handlerFunc: (_, __) => const SMSLoginPage()));

    router.define(resetPasswordPage,
        handler: Handler(handlerFunc: (context, params) {
      final args = context?.settings?.arguments == null
          ? null
          : context!.settings!.arguments! as EmailRegisterParams;
      return ResetPasswordPage(emailRegisterModel: args);
    }));
    router.define(areaCodePage,
        handler: Handler(handlerFunc: (_, __) => const AreaCodePage()));
  }
}
