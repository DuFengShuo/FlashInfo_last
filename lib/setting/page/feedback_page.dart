import 'package:device_info/device_info.dart';
import 'package:flashinfo/mvp/base_page.dart';
import 'package:flashinfo/mvp/power_presenter.dart';
import 'package:flashinfo/res/resources.dart';
import 'package:flashinfo/routers/fluro_navigator.dart';
import 'package:flashinfo/setting/presenter/setting_presenter.dart';
import 'package:flashinfo/util/device_utils.dart';
import 'package:flashinfo/widgets/my_app_bar.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oktoast/oktoast.dart';

class FeedbackPage extends StatefulWidget {
  const FeedbackPage({Key? key}) : super(key: key);
  @override
  _FeedbackPageState createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage>
    with BasePageMixin<FeedbackPage, PowerPresenter> {
  final TextEditingController _controller = TextEditingController();

  Map<String, String> params = <String, String>{};
  late FeedbackPresenter _feedbackPresenter;

  @override
  PowerPresenter createPresenter() {
    final PowerPresenter powerPresenter = PowerPresenter<dynamic>(this);
    _feedbackPresenter = FeedbackPresenter();
    powerPresenter.requestPresenter([_feedbackPresenter]);
    return powerPresenter;
  }

  @override
  void initState() {
    super.initState();
    _getDeviceInfo();
  }

  Future _getDeviceInfo() async {
    if (Device.isIOS) {
      final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      // 苹果系统
      final IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      params['ua'] = iosInfo.name;
      final IosUtsname utsname = iosInfo.utsname;
      params['device_model'] = utsname.machine;
    } else if (Device.isAndroid) {
      final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      // 安卓系统
      final AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      params['ua'] = androidInfo.manufacturer;
      params['device_model'] = androidInfo.model;
    } else {
      params['ua'] = '';
      params['device_model'] = '';
      return;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(
        centerTitle: 'User Feedback',
      ),
      body: Column(
        children: <Widget>[
          Gaps.lineV,
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(
                horizontal: Dimens.gap_dp16, vertical: Dimens.gap_v_dp16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Problem Description',
                  style: TextStyles.textBold13,
                ),
                Gaps.vGap16,
                Container(
                  padding: EdgeInsets.only(bottom: 10.h),
                  color: Colours.bg_color,
                  child: TextField(
                      maxLength: 300,
                      maxLines: 10,
                      autofocus: true,
                      controller: _controller,
                      keyboardType: TextInputType.text,
                      style: TextStyles.text
                          .copyWith(fontSize: Dimens.font_sp10.sp),
                      decoration: InputDecoration(
                        fillColor: Colours.bg_color,
                        filled: true,
                        hintText:
                            'Please fill your user experience after using this application',
                        border: InputBorder.none,
                        hintStyle: TextStyles.textSize12
                            .copyWith(color: Colours.text_gray_c),
                        //hintStyle: TextStyles.textGrayC14
                      )),
                ),
                Gaps.vGap20,
                Gaps.vGap50,
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _DialogButton(
                        text: 'Submit',
                        textColor: Theme.of(context).primaryColor,
                        onPressed: () async {
                          if (_controller.text.isEmpty) {
                            showToast('Please input feedback');
                            return;
                          }
                          params['describe'] = _controller.text.toString();
                          await _feedbackPresenter.feedback(params);
                        },
                      ),
                      _DialogButton(
                        text: 'Quit',
                        textColor: Colours.text_gray_c,
                        onPressed: () => NavigatorUtils.goBack(context),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DialogButton extends StatelessWidget {
  const _DialogButton({
    Key? key,
    required this.text,
    required this.textColor,
    required this.onPressed,
  }) : super(key: key);

  final String text;
  final Color textColor;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        alignment: Alignment.center,
        height: 35.0.h,
        width: 110.w,
        decoration: BoxDecoration(
            color: textColor,
            borderRadius: BorderRadius.all(Radius.circular(10.w))),
        child: Text(
          text,
          style: TextStyles.textSize14.copyWith(color: Colours.material_bg),
        ),
      ),
    );
  }
}
