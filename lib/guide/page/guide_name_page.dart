import 'package:flashinfo/login/widgets/my_text_field.dart';
import 'package:flashinfo/profile/presenter/personal_presenter.dart';
import 'package:flashinfo/res/colors.dart';
import 'package:flashinfo/res/resources.dart';
import 'package:flashinfo/routers/fluro_navigator.dart';
import 'package:flashinfo/util/change_notifier_manage.dart';
import 'package:flashinfo/util/other_utils.dart';
import 'package:flashinfo/widgets/my_app_bar.dart';
import 'package:flashinfo/widgets/my_button.dart';
import 'package:flashinfo/widgets/my_scroll_view.dart';
import 'package:flutter/material.dart';

import '../guide_router.dart';

class GuideNamePage extends StatefulWidget {
  const GuideNamePage({Key? key, required this.personalParams})
      : super(key: key);
  final PersonalParams personalParams;
  @override
  _GuideNamePageState createState() => _GuideNamePageState();
}

class _GuideNamePageState extends State<GuideNamePage>
    with ChangeNotifierMixin<GuideNamePage> {
  final TextEditingController _fistController = TextEditingController();
  final TextEditingController _lastController = TextEditingController();
  final FocusNode _nodeText1 = FocusNode();
  final FocusNode _nodeText2 = FocusNode();
  bool _clickable = false;

  @override
  Map<ChangeNotifier, List<VoidCallback>?>? changeNotifier() {
    final List<VoidCallback> callbacks = <VoidCallback>[_verify];
    return <ChangeNotifier, List<VoidCallback>?>{
      _fistController: callbacks,
      _lastController: callbacks,
      _nodeText1: null,
      _nodeText2: null,
    };
  }

  void _verify() {
    final String fistName = _fistController.text.trim();
    final String lastName = _lastController.text.trim();
    bool clickable = true;
    if (fistName.isEmpty && lastName.isEmpty) {
      clickable = false;
    }
    if (clickable != _clickable) {
      setState(() {
        _clickable = clickable;
      });
    }
  }

  void _next() {
    widget.personalParams.firstName = _fistController.text.trim();
    widget.personalParams.lastName = _lastController.text.trim();
    NavigatorUtils.push(context, GuideRouter.guidePhonePage,
        arguments: widget.personalParams);
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
          onPressed: _next,
          textColor: Colours.app_main,
        ),
        body: MyScrollView(
          keyboardConfig: Utils.getKeyboardActionsConfig(
              context, <FocusNode>[_nodeText1, _nodeText2]),
          padding: EdgeInsets.symmetric(horizontal: Dimens.gap_dp16),
          bottomButton: Padding(
            padding: EdgeInsets.symmetric(horizontal: Dimens.gap_dp16),
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
              "What's your name？",
              style: TextStyles.textBold28.copyWith(color: Colours.app_main),
            ),
            Gaps.vGap50,
            Gaps.vGap20,
            Row(
              children: [
                Expanded(
                  child: MyTextField(
                    focusNode: _nodeText1,
                    controller: _fistController,
                    maxLength: 20,
                    keyboardType: TextInputType.text,
                    hintText: 'First Name',
                  ),
                ),
                Gaps.hGap20,
                Expanded(
                  child: MyTextField(
                    focusNode: _nodeText2,
                    controller: _lastController,
                    maxLength: 20,
                    keyboardType: TextInputType.text,
                    hintText: 'Last Name',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
