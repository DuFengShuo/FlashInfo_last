import 'package:flashinfo/common/common.dart';
import 'package:flashinfo/login/model/captcha_email_model.dart';
import 'package:flashinfo/login/model/captcha_img_model.dart';
import 'package:flashinfo/login/model/captcha_sms_model.dart';
import 'package:flashinfo/login/model/user_info_model.dart';
import 'package:flashinfo/mvp/base_page_presenter.dart';
import 'package:flashinfo/mvp/mvps.dart';
import 'package:flashinfo/net/net.dart';
import 'package:flashinfo/provider/user_info_provider.dart';
import 'package:flashinfo/routers/fluro_navigator.dart';
import 'package:flashinfo/util/device_utils.dart';
import 'package:flashinfo/util/toast_utils.dart';
import 'package:flashinfo/widgets/my_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:linkedin_login/linkedin_login.dart';
import 'package:provider/provider.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class MobileLoginParams {
  String? code;
  String? captchakey;
  String? account;
  int? areaCode;
  MobileLoginParams({
    this.areaCode = 86,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = <String, dynamic>{};
    map['code'] = code;
    map['captcha_key'] = captchakey;
    map['account'] = account;
    map['area_code'] = areaCode;
    return map;
  }
}

class CaptchaSmsParams {
  String? captchaImageKey;
  String? captchaImageCode;
  int? areaCode;
  String? isCheckExists;
  String? mobile;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = <String, dynamic>{};
    if (captchaImageKey != null) {
      map['captcha_image_key'] = captchaImageKey;
    }
    if (captchaImageCode != null) {
      map['captcha_image_code'] = captchaImageCode;
    }
    if (areaCode != null) {
      map['area_code'] = areaCode;
    }
    if (mobile != null) {
      map['mobile'] = mobile;
    }

    if (isCheckExists != null) {
      map['is_check_exists'] = isCheckExists;
    }
    return map;
  }
}

class CaptchaEmailParams {
  String? captchaImageKey;
  String? captchaImageCode;
  String? email;
  String? isCheckExists;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = <String, dynamic>{};
    map['captcha_image_key'] = captchaImageKey;
    map['captcha_image_code'] = captchaImageCode;
    map['email'] = email;
    if (isCheckExists != null) {
      map['is_check_exists'] = isCheckExists;
    }
    return map;
  }
}

class EmailRegisterParams {
  String? name;
  String? email;
  String? newpwd;
  String? captchaEmailKey;
  String? code;
  String? lastName;
  String? firstName;

  String? bingEmail = 'email';

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = <String, dynamic>{};
    map['email'] = email;
    map['newpwd'] = newpwd;
    map['captcha_email_key'] = captchaEmailKey;
    map['code'] = code;
    if (name != null) {
      map['name'] = name;
    }
    if (lastName != null) {
      map['last_name'] = lastName;
    }
    if (firstName != null) {
      map['first_name'] = firstName;
    }
    return map;
  }
}

class LoginPresenter extends BasePagePresenter<IMvpView> {
  void Function(UserInfoModel? model)? _loginSuccess;

  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: <String>[
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      //googleLogin监听
      _googleSignIn.onCurrentUserChanged
          .listen((GoogleSignInAccount? account) async {
        final GoogleSignInAuthentication authentication =
            await account!.authentication;
        final String idToken = authentication.idToken ?? '';
        // print(authentication.accessToken);
        if (idToken != null || idToken.isNotEmpty) {
          final Map<String, String> params = <String, String>{};
          params['id_token'] = idToken;
          if (Device.isIOS) {
            params['client_id'] =
                '669029328980-npqu7crvah85rhf11pisotku81qgfprn.apps.googleusercontent.com';
          } else {
            params['client_id'] =
                '669029328980-ke877jop5um6seg2hltn9u4qnla397cg.apps.googleusercontent.com';
          }
          await login(params, HttpApi.googleLogin, loginSuccess: _loginSuccess);
        } else {
          Toast.show('登录失败！');
        }
      });
    });
  }

  Future<void> _useGoogleSignIn() async {
    try {
      await _googleSignIn.signOut();
    } catch (error) {
      print(error);
    }
  }

  ///登录
  Future login(Map<String, dynamic> params, String url,
      {Function(UserInfoModel? model)? loginSuccess}) {
    return requestNetwork<UserInfoModel>(Method.post,
        url: url,
        params: params,
        isShow: true, onSuccess: (UserInfoModel? model) async {
      if (url == HttpApi.googleLogin) {
        await _useGoogleSignIn();
      }
      if (model != null) {
        await view
            .getContext()
            .read<UserInfoProvider>()
            .setUserInfoModel(model);
        loginSuccess!(model);
      }
    }, onError: (_, __) async {
      if (url == HttpApi.googleLogin) {
        await _useGoogleSignIn();
      }
    });
  }

  ///邮箱注册
  Future emailRegister(EmailRegisterParams? emailRegisterModel,
      Function(UserInfoModel? model) loginSuccess) {
    return requestNetwork<UserInfoModel>(Method.post,
        url: HttpApi.emailRegister,
        params: emailRegisterModel?.toJson(),
        isShow: true, onSuccess: (UserInfoModel? model) async {
      if (model != null) {
        await view
            .getContext()
            .read<UserInfoProvider>()
            .setUserInfoModel(model);
        loginSuccess(model);
      } else {
        loginSuccess(null);
      }
    }, onError: (_, __) {
      loginSuccess(null);
    });
  }

  ///获取图片验证码
  Future captchaImage(
      String phone, Function(CaptchaImgModel? model) imageDate) {
    final Map<String, String> params = <String, String>{};
    params['account'] = phone;
    return requestNetwork<CaptchaImgModel>(Method.post,
        url: HttpApi.captchaImage,
        params: params,
        isShow: true, onSuccess: (CaptchaImgModel? model) {
      if (model != null) {
        if (model.message!.isNotEmpty) {
          view.showToast(model.message!);
        }
        if (model.captchaImageContent!.isNotEmpty) {
          model.captchaImageContent = model.captchaImageContent
              ?.replaceAll('data:image/jpeg;base64,', '');
          imageDate(model);
        }
      }
    }, onError: (_, __) {});
  }

  ///根据当天验证码发送次数，判断是否需要弹出图形验证码
  Future captchaNums(String type, String val, Function(bool) success,
      {String? areaCode}) {
    final Map<String, String> params = <String, String>{};
    params['type'] = type;
    params['val'] = val;
    if (areaCode != null) {
      params['area_code'] = areaCode;
    }
    return requestNetwork<CaptchaNumsModel>(Method.post,
        url: HttpApi.captchaNums,
        params: params,
        isShow: true, onSuccess: (CaptchaNumsModel? model) {
      if (model != null) {
        success(model.isNeedCaptcha == 0);
      }
    }, onError: (_, __) {});
  }

  ///发送短信验证码
  Future captchaSms(CaptchaSmsParams? captchaSmsParams,
      Function(CaptchaSmsModel? model) semSuccess) {
    return requestNetwork<CaptchaSmsModel>(Method.post,
        url: HttpApi.captchaSms,
        params: captchaSmsParams?.toJson(),
        isShow: true, onSuccess: (CaptchaSmsModel? model) {
      if (model!.message!.isNotEmpty) {
        view.showToast(model.message!);
      }
      semSuccess(model);
    }, onError: (_, __) {
      semSuccess(null);
    });
  }

  ///发送邮箱验证码
  Future captchaEmail(CaptchaImgModel? imgModel, String account,
      Function(CaptchaEmailModel? model) semSuccess) {
    final CaptchaEmailParams captchaEmailParams = CaptchaEmailParams();
    if (imgModel != null) {
      captchaEmailParams.captchaImageKey = imgModel.captchaImageKey;
      captchaEmailParams.captchaImageCode = imgModel.captchaImageCode;
    }
    captchaEmailParams.email = account;
    captchaEmailParams.isCheckExists = '1';
    return requestNetwork<CaptchaEmailModel>(Method.post,
        url: HttpApi.captchaEmail,
        params: captchaEmailParams.toJson(),
        isShow: true, onSuccess: (CaptchaEmailModel? model) {
      if (model != null) {
        if (model.message.isNotEmpty) {
          view.showToast(model.message);
        }
        semSuccess(model);
      } else {
        semSuccess(null);
      }
    }, onError: (_, __) {
      semSuccess(null);
    });
  }

  ///检查验证码
  Future verificationCode(
      Map<String, String>? params, Function(bool) codeSuccess) {
    return requestNetwork<Map<dynamic, dynamic>>(Method.post,
        url: HttpApi.verificationCode,
        params: params,
        isShow: true, onSuccess: (Map<dynamic, dynamic>? model) {
      if (model != null) {
        if (model['message'].toString().isNotEmpty) {
          view.showToast(model['message'].toString());
        }
        codeSuccess(true);
      } else {
        codeSuccess(false);
      }
    }, onError: (_, __) {
      codeSuccess(false);
    });
  }

  ///绑定手机号
  Future bindMobile(MobileLoginParams? mobileLoginParams,
      Function(UserInfoModel? model) bindSuccess) {
    return requestNetwork<UserInfoModel>(Method.post,
        url: HttpApi.bindMobile,
        params: mobileLoginParams?.toJson(),
        isShow: true, onSuccess: (UserInfoModel? model) {
      if (model != null) {
        if (model.message!.isNotEmpty) {
          view.showToast(model.message!);
        }
        view.getContext().read<UserInfoProvider>().setUserInfoModel(model);
        bindSuccess(model);
      } else {}
    }, onError: (_, __) {});
  }

  ///绑定邮箱
  Future bindEmail(EmailRegisterParams? emailRegisterParams,
      Function(UserInfoModel? model) bindSuccess) {
    return requestNetwork<UserInfoModel>(Method.post,
        url: HttpApi.bindEmail,
        params: emailRegisterParams?.toJson(),
        isShow: true, onSuccess: (UserInfoModel? model) {
      if (model != null) {
        if (model.message!.isNotEmpty) {
          view.showToast(model.message!);
        }
        view.getContext().read<UserInfoProvider>().setUserInfoModel(model);
        bindSuccess(model);
      } else {}
    }, onError: (_, __) {});
  }

  // 获取用户信息
  Future getUserInfo() async {
    return requestNetwork<UserInfoModel>(Method.get,
        url: HttpApi.userInfo,
        isShow: false, onSuccess: (UserInfoModel? model) {
      if (model != null) {
        view.getContext().read<UserInfoProvider>().setUserInfoModel(model);
      }
    });
  }

  // 苹果登录
  Future appleLogin(Function(UserInfoModel? model)? loginSuccess) async {
    _loginSuccess = loginSuccess;
    final credential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
    );
    final Map<String, String> params = <String, String>{};
    params['apple_user_id'] = credential.userIdentifier ?? '';
    params['identity_token'] = credential.identityToken ?? '';
    if (credential.givenName != null && credential.familyName != null) {
      params['full_name'] =
          (credential.givenName ?? '') + (credential.familyName ?? '');
    }
    await login(params, HttpApi.appleLogin, loginSuccess: _loginSuccess);
  }

  // 领英登录
  Future lintingLogin(Function(UserInfoModel? model)? loginSuccess) async {
    _loginSuccess = loginSuccess;
    await Navigator.push<void>(
      view.getContext(),
      MaterialPageRoute(
        builder: (BuildContext context) => LinkedInUserWidget(
          appBar: const MyAppBar(
            centerTitle: 'OAuth User',
          ),
          destroySession: true,
          redirectUrl: Constant.linkedInRedirectUrl,
          clientId: Constant.linkedInClientId,
          clientSecret: Constant.linkedInClientSecret,
          projection: const [
            ProjectionParameters.id,
            ProjectionParameters.localizedFirstName,
            ProjectionParameters.localizedLastName,
            ProjectionParameters.firstName,
            ProjectionParameters.lastName,
            ProjectionParameters.profilePicture,
          ],
          onError: (UserFailedAction e) {
            print('Error: ${e.toString()}');
          },
          onGetUserProfile: (UserSucceededAction linkedInUser) async {
            NavigatorUtils.goBack(context);
            if (linkedInUser.user.token.accessToken == null ||
                linkedInUser.user.token.accessToken!.isEmpty) {
              Toast.show('Login failed！');
              return;
            }
            final Map<String, String> params = <String, String>{};
            params['access_token'] = linkedInUser.user.token.accessToken ?? '';
            await login(params, HttpApi.linkedinLogin,
                loginSuccess: _loginSuccess);
          },
        ),
        fullscreenDialog: true,
      ),
    );
  }

  // 谷歌登录
  Future googleLogin(Function(UserInfoModel? model)? loginSuccess) async {
    _loginSuccess = loginSuccess;
    try {
      await _googleSignIn.signIn();
    } catch (e) {
      Toast.show('Auth error !');
    }
  }
}
