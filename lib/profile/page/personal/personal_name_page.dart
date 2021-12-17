import 'package:flashinfo/login/model/user_info_model.dart';
import 'package:flashinfo/login/widgets/my_text_field.dart';
import 'package:flashinfo/mvp/base_page.dart';
import 'package:flashinfo/mvp/power_presenter.dart';
import 'package:flashinfo/profile/presenter/personal_presenter.dart';
import 'package:flashinfo/provider/user_info_provider.dart';
import 'package:flashinfo/res/resources.dart';
import 'package:flashinfo/routers/fluro_navigator.dart';
import 'package:flashinfo/util/change_notifier_manage.dart';
import 'package:flashinfo/widgets/my_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PersonalNamePage extends StatefulWidget {
  const PersonalNamePage({Key? key, this.personalParams}) : super(key: key);
  final PersonalParams? personalParams;
  @override
  _PersonalNamePageState createState() => _PersonalNamePageState();
}

class _PersonalNamePageState extends State<PersonalNamePage>
    with
        ChangeNotifierMixin<PersonalNamePage>,
        BasePageMixin<PersonalNamePage, PowerPresenter> {
  final TextEditingController _firstController = TextEditingController();
  final TextEditingController _lastController = TextEditingController();
  final FocusNode _nodeText1 = FocusNode();
  final FocusNode _nodeText2 = FocusNode();
  bool _clickable = false;
  late PersonalPresenter _personalPresenter;
  @override
  PowerPresenter createPresenter() {
    final PowerPresenter powerPresenter = PowerPresenter<dynamic>(this);
    _personalPresenter = PersonalPresenter();
    powerPresenter.requestPresenter([_personalPresenter]);
    return powerPresenter;
  }

  @override
  Map<ChangeNotifier, List<VoidCallback>?>? changeNotifier() {
    final List<VoidCallback> callbacks = <VoidCallback>[_verify];
    return <ChangeNotifier, List<VoidCallback>?>{
      _firstController: callbacks,
      _lastController: callbacks,
      _nodeText1: null,
      _nodeText2: null,
    };
  }

  void _verify() {
    final String first = _firstController.text;
    final String last = _lastController.text;
    bool clickable = true;
    if (first.trim().isEmpty) {
      clickable = false;
    }
    if (last.trim().isEmpty) {
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

    if (context.read<UserInfoProvider>().userInfoModel != null) {
      final UserInfoModel? model =
          context.read<UserInfoProvider>().userInfoModel;
      _firstController.text = model?.firstName ?? '';
      _lastController.text = model?.lastName ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colours.bg_color,
      appBar: MyAppBar(
        actionName: 'Save',
        textColor: _clickable ? Colours.app_main : Colours.text_gray_c,
        onPressed: () async {
          if (_clickable) {
            final Map<String, dynamic> params = <String, dynamic>{};
            params['first_name'] = _firstController.text.toString();
            params['last_name'] = _lastController.text.toString();
            await _personalPresenter.updateUser(params, success: (value) {
              if (value) {
                NavigatorUtils.goBack(context);
              }
            });
          }
        },
      ),
      body: Column(
        children: [
          Gaps.line,
          Row(
            children: [
              Expanded(
                child: Container(
                  color: Colours.material_bg,
                  padding: EdgeInsets.only(
                      left: Dimens.gap_dp16,
                      top: Dimens.gap_v_dp20,
                      bottom: Dimens.gap_v_dp20,
                      right: Dimens.gap_dp4),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'First Name',
                        style: TextStyles.textBold15,
                      ),
                      Gaps.vGap15,
                      MyTextField(
                        focusNode: _nodeText1,
                        controller: _firstController,
                        maxLength: 10,
                        keyboardType: TextInputType.text,
                        hintText: 'First Name',
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  color: Colours.material_bg,
                  padding: EdgeInsets.only(
                      left: Dimens.gap_dp16,
                      top: Dimens.gap_v_dp20,
                      bottom: Dimens.gap_v_dp20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Last Name',
                        style: TextStyles.textBold15,
                      ),
                      Gaps.vGap15,
                      MyTextField(
                        focusNode: _nodeText2,
                        controller: _lastController,
                        maxLength: 10,
                        keyboardType: TextInputType.text,
                        hintText: 'Last Name',
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
