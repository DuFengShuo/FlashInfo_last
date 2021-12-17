import 'package:flashinfo/login/login_router.dart';
import 'package:flashinfo/login/model/area_code_model.dart';
import 'package:flashinfo/login/model/captcha_email_model.dart';
import 'package:flashinfo/login/model/captcha_img_model.dart';
import 'package:flashinfo/login/model/captcha_sms_model.dart';
import 'package:flashinfo/login/page/email_verify_page.dart';
import 'package:flashinfo/login/presenter/login_presenter.dart';
import 'package:flashinfo/login/widgets/img_input_dialog.dart';
import 'package:flashinfo/login/widgets/phone_field.dart';
import 'package:flashinfo/mvp/base_page.dart';
import 'package:flashinfo/mvp/power_presenter.dart';
import 'package:flashinfo/res/colors.dart';
import 'package:flashinfo/res/dimens.dart';
import 'package:flashinfo/res/gaps.dart';
import 'package:flashinfo/res/styles.dart';
import 'package:flashinfo/routers/fluro_navigator.dart';
import 'package:flashinfo/util/other_utils.dart';
import 'package:flashinfo/util/toast_utils.dart';
import 'package:flashinfo/widgets/my_app_bar.dart';
import 'package:flashinfo/widgets/my_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputTextPage extends StatefulWidget {
  const InputTextPage({
    Key? key,
    this.inputTextPageArguments,
  }) : super(key: key);

  final InputTextPageArgumentsData? inputTextPageArguments;
  @override
  _InputTextPageState createState() => _InputTextPageState();
}

class _InputTextPageState extends State<InputTextPage>
    with BasePageMixin<InputTextPage, PowerPresenter> {
  final TextEditingController _controller = TextEditingController();
  List<TextInputFormatter>? _inputFormatters;
  late int _maxLength;
  late int _areaCode = 86;
  CaptchaImgModel? _captchaImgModel;
  @override
  void initState() {
    super.initState();
    _controller.text = widget.inputTextPageArguments?.content ?? '';
    _areaCode = widget.inputTextPageArguments?.areaCode ?? 86;
    _maxLength =
        widget.inputTextPageArguments?.keyboardType == TextInputType.phone
            ? 11
            : 300;
    _inputFormatters =
        widget.inputTextPageArguments?.keyboardType == TextInputType.phone
            ? [FilteringTextInputFormatter.allow(RegExp('[0-9]'))]
            : null;
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
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colours.bg_color,
      appBar: MyAppBar(
        centerTitle: widget.inputTextPageArguments?.title ?? '',
        actionName: widget.inputTextPageArguments!.isNext ? '' : 'Save',
        textColor: Colours.app_main,
        onPressed: widget.inputTextPageArguments!.isNext
            ? null
            : () {
                if (_controller.text.trim().isEmpty) {
                  Toast.show(widget.inputTextPageArguments?.hintText ?? '');
                  return;
                }
                NavigatorUtils.goBackWithParams(context, _controller.text);
              },
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Gaps.vGap15,
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Dimens.gap_dp16),
            child: Text(
              widget.inputTextPageArguments?.titleText ?? '',
              style: TextStyles.textBold15,
            ),
          ),
          Gaps.vGap15,
          if (widget.inputTextPageArguments?.pageType == 'phone')
            Container(
              color: Colours.material_bg,
              padding: EdgeInsets.symmetric(horizontal: Dimens.gap_dp16),
              child: PhoneField(
                  phoneController: _controller,
                  areaCode: _areaCode,
                  onTapAreaCode: () {
                    NavigatorUtils.pushResult(context, LoginRouter.areaCodePage,
                        (e) {
                      final AreaCodeModel model = e as AreaCodeModel;
                      setState(() {
                        _areaCode = int.parse(model.code.toString());
                      });
                    });
                  }),
            )
          else
            TextField(
              maxLength: _maxLength,
              maxLines: 1,
              autofocus: true,
              controller: _controller,
              keyboardType: widget.inputTextPageArguments?.keyboardType,
              inputFormatters: _inputFormatters,
              style: TextStyles.textSize15,
              decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(horizontal: Dimens.gap_dp16),
                fillColor: Colours.material_bg,
                filled: true,
                hintText: widget.inputTextPageArguments?.hintText,
                border: InputBorder.none,
                counterText: '',
              ),
            ),
          Gaps.vGap15,
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Dimens.gap_dp16),
            child: Text(
              widget.inputTextPageArguments?.otherText ?? '',
              style: TextStyles.textSize12.copyWith(color: Colours.text_gray_c),
            ),
          ),
          const Spacer(),
          if (widget.inputTextPageArguments!.isNext)
            SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: Dimens.gap_dp16),
                child: MyButton(
                  onPressed: () async {
                    if (_controller.text.trim().isEmpty) {
                      Toast.show(widget.inputTextPageArguments?.hintText ?? '');
                      return;
                    }
                    switch (widget.inputTextPageArguments?.pageType) {
                      case 'phone':
                        await _loginPresenter.captchaNums(
                            'mobile', _controller.text, (bool value) async {
                          if (value) {
                            _sendCaptchaSms(context);
                          } else {
                            await _loginPresenter.captchaImage(
                                _controller.text,
                                (CaptchaImgModel? model) =>
                                    _showImgInputDialog(model, context));
                          }
                        }, areaCode: _areaCode.toString());
                        break;
                      case 'bindEmail':
                        await _loginPresenter.captchaNums(
                          'email',
                          _controller.text,
                          (bool value) async {
                            if (value) {
                              _sendCaptchaEmail(context);
                            } else {
                              await _loginPresenter.captchaImage(
                                  _controller.text,
                                  (CaptchaImgModel? model) =>
                                      _showImgInputDialog(model, context));
                            }
                          },
                        );

                        break;
                      default:
                        NavigatorUtils.goBackWithParams(
                            context, _controller.text);
                        break;
                    }
                  },
                  text: 'Send code',
                ),
              ),
            )
          else
            Gaps.empty,
        ],
      ),
    );
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
            _loginPresenter.captchaImage(_controller.text,
                (CaptchaImgModel? captchaImgModel) {
              _captchaImgModel = captchaImgModel;
              imageBaseUpdate(captchaImgModel?.captchaImageContent ?? '');
            });
          },
          onPressed: (String value, imageBaseUpdate) async {
            _captchaImgModel?.captchaImageCode = value;
            switch (widget.inputTextPageArguments?.pageType) {
              case 'phone':
                _sendCaptchaSms(_context,
                    value: value, imageBaseUpdate: imageBaseUpdate);
                break;
              case 'bindEmail':
                _sendCaptchaEmail(_context, imageBaseUpdate: imageBaseUpdate);
                break;
              default:
            }
          },
        );
      },
    );
  }

  Future _sendCaptchaEmail(
    BuildContext _context, {
    Function(String image)? imageBaseUpdate,
  }) async {
    await _loginPresenter.captchaEmail(_captchaImgModel, _controller.text,
        (CaptchaEmailModel? model) {
      final EmailVerifyParams params = EmailVerifyParams();
      params.account = _controller.text;
      params.captchaEmailModel = model;
      if (imageBaseUpdate != null) {
        params.captchaImgModel = _captchaImgModel;
      }

      params.pageType = widget.inputTextPageArguments?.pageType;
      if (model == null && imageBaseUpdate != null) {
        _loginPresenter.captchaImage(_controller.text,
            (CaptchaImgModel? captchaImgModel) {
          _captchaImgModel = captchaImgModel;
          imageBaseUpdate(captchaImgModel?.captchaImageContent ?? '');
        });
      } else {
        if (imageBaseUpdate != null) {
          NavigatorUtils.goBack(context);
        }
        NavigatorUtils.pushResult(_context, LoginRouter.emailVerifyPage,
            (value) {
          print(value);
        }, arguments: params);
      }
    });
  }

  Future _sendCaptchaSms(
    BuildContext _context, {
    String? value,
    Function(String image)? imageBaseUpdate,
  }) async {
    final CaptchaSmsParams captchaSmsParams = CaptchaSmsParams();
    if (imageBaseUpdate != null) {
      captchaSmsParams.captchaImageKey = _captchaImgModel?.captchaImageKey;
      captchaSmsParams.captchaImageCode = value;
    }
    captchaSmsParams.areaCode = _areaCode;
    captchaSmsParams.mobile = _controller.text.trim();
    await _loginPresenter.captchaSms(captchaSmsParams,
        (CaptchaSmsModel? model) {
      final EmailVerifyParams params = EmailVerifyParams();
      params.captchaSmsModel = model;
      params.pageType = widget.inputTextPageArguments?.pageType;
      params.captchaSmsParams = captchaSmsParams;
      if (imageBaseUpdate != null) {
        params.captchaImgModel = _captchaImgModel;
      }

      params.account = _controller.text;
      if (model == null && imageBaseUpdate != null) {
        _loginPresenter.captchaImage(_controller.text,
            (CaptchaImgModel? captchaImgModel) {
          _captchaImgModel = captchaImgModel;
          imageBaseUpdate(captchaImgModel?.captchaImageContent ?? '');
        });
      } else {
        if (imageBaseUpdate != null) {
          NavigatorUtils.goBack(context);
        }
        NavigatorUtils.pushResult(_context, LoginRouter.emailVerifyPage,
            (value) {
          print(value);
        }, arguments: params);
      }
    });
  }
}

class InputTextPageArgumentsData {
  InputTextPageArgumentsData({
    required this.isNext,
    this.title,
    this.titleText,
    this.content,
    this.hintText,
    this.otherText,
    this.keyboardType,
    this.pageType,
    this.areaCode,
  });

  late String? title;
  late String? titleText;
  late String? content;
  late String? hintText;
  late String? otherText;
  late String? pageType = 'other';
  late bool isNext;
  late int? areaCode;
  late TextInputType? keyboardType = TextInputType.text;
}
