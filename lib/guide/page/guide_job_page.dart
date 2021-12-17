import 'package:flashinfo/common/common.dart';
import 'package:flashinfo/login/widgets/my_text_field.dart';
import 'package:flashinfo/profile/presenter/personal_presenter.dart';
import 'package:flashinfo/res/colors.dart';
import 'package:flashinfo/res/resources.dart';
import 'package:flashinfo/routers/fluro_navigator.dart';
import 'package:flashinfo/util/change_notifier_manage.dart';
import 'package:flashinfo/util/device_utils.dart';
import 'package:flashinfo/util/other_utils.dart';
import 'package:flashinfo/widgets/my_app_bar.dart';
import 'package:flashinfo/widgets/my_button.dart';
import 'package:flashinfo/widgets/my_scroll_view.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import '../guide_router.dart';
import 'package:flashinfo/guide/guide_router.dart';
import 'package:flashinfo/routers/routers.dart';
import 'package:flashinfo/util/theme_utils.dart';
import 'package:flashinfo/widgets/load_image.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sp_util/sp_util.dart';

class GuideJobPage extends StatefulWidget {
  const GuideJobPage({Key? key}) : super(key: key);

  @override
  _GuideJobPageState createState() => _GuideJobPageState();
}

class _GuideJobPageState extends State<GuideJobPage>
    with ChangeNotifierMixin<GuideJobPage> {
  late PersonalParams personalParams = PersonalParams();
  final TextEditingController _nameController = TextEditingController();
  final FocusNode _nodeText1 = FocusNode();
  bool _clickable = false;
  StreamSubscription? _subscription;
  int _status = 0;
  @override
  Map<ChangeNotifier, List<VoidCallback>?>? changeNotifier() {
    final List<VoidCallback> callbacks = <VoidCallback>[_verify];
    return <ChangeNotifier, List<VoidCallback>?>{
      _nameController: callbacks,
      _nodeText1: null,
    };
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      /// 两种初始化方案，另一种见 main.dart
      /// 两种方法各有优劣
      await SpUtil.getInstance();
      await Device.initDeviceInfo();

      _initSplash();
    });
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  void _initSplash() {
    _subscription =
        Stream.value(1).delay(const Duration(milliseconds: 1500)).listen((_) {
      if (SpUtil.getBool(Constant.keyGuide, defValue: true)! ||
          Constant.isDriverTest) {
        SpUtil.putBool(Constant.keyGuide, false);
        SpUtil.putBool(Constant.isFirstLogin, true);
        _initGuide();
      } else {
        _goLogin();
      }
    });
  }

  void _initGuide() {
    setState(() {
      _status = 1;
    });
  }

  void _goLogin() {
    NavigatorUtils.push(context, Routes.home, clearStack: true);
  }

  void _verify() {
    final String name = _nameController.text.trim();
    bool clickable = true;
    if (name.isEmpty) {
      clickable = false;
    }

    /// 状态不一样再刷新，避免不必要的setState
    if (clickable != _clickable) {
      setState(() {
        _clickable = clickable;
      });
    }
  }

  void _next() {
    personalParams.position = _nameController.text.trim();
    NavigatorUtils.push(context, GuideRouter.guideEmployerPage,
        arguments: personalParams);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        color: context.backgroundColor,
        child: _status == 0
            ? const FractionallyAlignedSizedBox(
                heightFactor: 0.3,
                widthFactor: 0.5,
                leftFactor: 0.25,
                bottomFactor: 0,
                child: LoadAssetImage(
                  'logo',
                  color: Colours.app_main,
                ))
            : WillPopScope(
                onWillPop: () {
                  /// 拦截返回，关闭键盘，否则会造成上一页面短暂的组件溢出
                  FocusManager.instance.primaryFocus?.unfocus();
                  return Future.value(true);
                },
                child: Scaffold(
                    appBar: MyAppBar(
                      isBack: false,
                      actionName: 'Skip',
                      onPressed: _next,
                      textColor: Colours.app_main,
                    ),
                    body: MyScrollView(
                      keyboardConfig: Utils.getKeyboardActionsConfig(
                          context, <FocusNode>[_nodeText1]),
                      padding:
                          EdgeInsets.symmetric(horizontal: Dimens.gap_dp16),
                      bottomButton: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: Dimens.gap_dp16),
                        child: MyButton(
                          key: const Key('Next'),
                          onPressed: _clickable ? _next : null,
                          text: 'Next',
                        ),
                      ),
                      children: [
                        Gaps.line,
                        Gaps.vGap50,
                        Text(
                          "What's your job title?",
                          style: TextStyles.textBold28
                              .copyWith(color: Colours.app_main),
                        ),
                        Gaps.vGap10,
                        Text('We are a real business platform',
                            style: TextStyles.textBold14),
                        Gaps.vGap50,
                        MyTextField(
                          focusNode: _nodeText1,
                          controller: _nameController,
                          maxLength: 50,
                          keyboardType: TextInputType.text,
                          hintText: 'Please enter your position',
                        ),
                      ],
                    )),
              ));
  }
}
