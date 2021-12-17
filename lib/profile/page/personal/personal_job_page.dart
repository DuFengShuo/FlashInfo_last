import 'package:flashinfo/login/model/user_info_model.dart';
import 'package:flashinfo/mvp/base_page.dart';
import 'package:flashinfo/mvp/power_presenter.dart';
import 'package:flashinfo/profile/presenter/personal_presenter.dart';
import 'package:flashinfo/profile/profile_router.dart';
import 'package:flashinfo/profile/widget/input_text_page.dart';
import 'package:flashinfo/provider/user_info_provider.dart';
import 'package:flashinfo/res/colors.dart';
import 'package:flashinfo/res/dimens.dart';
import 'package:flashinfo/res/gaps.dart';
import 'package:flashinfo/res/styles.dart';
import 'package:flashinfo/routers/fluro_navigator.dart';
import 'package:flashinfo/widgets/click_item.dart';
import 'package:flashinfo/widgets/my_app_bar.dart';
import 'package:flashinfo/widgets/my_button.dart';
import 'package:flashinfo/widgets/my_scroll_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class PersonalJobPage extends StatefulWidget {
  const PersonalJobPage({Key? key}) : super(key: key);

  @override
  _PersonalJobPageState createState() => _PersonalJobPageState();
}

class _PersonalJobPageState extends State<PersonalJobPage>
    with BasePageMixin<PersonalJobPage, PowerPresenter> {
  late PersonalParams personalParams = PersonalParams();
  bool valuea = false;

  @override
  void initState() {
    super.initState();

    if (context.read<UserInfoProvider>().userInfoModel != null) {
      final UserInfoModel? model =
          context.read<UserInfoProvider>().userInfoModel;
      valuea = model?.workStatus == 0 ? false : true;
    }
  }

  late PersonalPresenter _personalPresenter;
  @override
  PowerPresenter createPresenter() {
    final PowerPresenter powerPresenter = PowerPresenter<dynamic>(this);
    _personalPresenter = PersonalPresenter();
    powerPresenter.requestPresenter([_personalPresenter]);
    return powerPresenter;
  }

  Future _submit() async {
    await _personalPresenter.updateUser(personalParams.toJson(),
        success: (value) {
      if (value) {
        NavigatorUtils.goBack(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colours.bg_color,
      appBar: const MyAppBar(
        centerTitle: 'Personal Profile',
      ),
      body: MyScrollView(
        children: _buildBody(),
        bottomButton: Container(
          padding: EdgeInsets.symmetric(
              vertical: Dimens.gap_dp20, horizontal: Dimens.gap_dp16),
          child: MyButton(
            key: const Key('Submit'),
            minHeight: 40.h,
            onPressed: personalParams.toJson().isEmpty ? null : _submit,
            text: 'Submit',
          ),
        ),
      ),
    );
  }

  List<Widget> _buildBody() {
    return <Widget>[
      Gaps.line,
      Consumer<UserInfoProvider>(builder: (_, provider, __) {
        final String companyName = personalParams.companyName ??
            provider.userInfoModel?.companyName ??
            '';
        return ClickItem(
          title: 'Most recent employer',
          titleStyle: TextStyles.textBold13,
          content: companyName,
          onTap: () {
            NavigatorUtils.pushResult(
              context,
              '${ProfileRouter.personEmployerPage}?companyName=$companyName',
              (result) {
                if (result.toString() != provider.userInfoModel?.companyName) {
                  setState(() {
                    personalParams.companyName = result.toString();
                  });
                }
              },
            );
          },
        );
      }),
      Consumer<UserInfoProvider>(builder: (_, provider, __) {
        return ClickItem(
          title: 'Job Title',
          titleStyle: TextStyles.textBold13,
          content:
              personalParams.position ?? provider.userInfoModel?.position ?? '',
          onTap: () {
            _goInputTextPage(
              context,
              false,
              'Job Title',
              'Please fill in your Job Title',
              provider.userInfoModel?.position ?? '',
              (result) {
                if (result.toString() != provider.userInfoModel?.position) {
                  setState(() {
                    personalParams.position = result.toString();
                  });
                }
              },
            );
          },
        );
      }),
      Consumer<UserInfoProvider>(builder: (_, provider, __) {
        return Container(
          color: Colours.material_bg,
          padding: EdgeInsets.symmetric(horizontal: Dimens.gap_dp16),
          height: 48.h,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Are you still work in this company?',
                style: TextStyles.textBold13,
              ),
              CupertinoSwitch(
                value: valuea,
                activeColor: Colours.app_main,
                onChanged: (result) {
                  personalParams.workStatus = result ? 1 : 0;
                  setState(() {
                    valuea = result;
                  });
                },
              ),
            ],
          ),
        );
      }),
    ];
  }

  Future<void> onTapCallbackItem(int index) async {}
  void _goInputTextPage(BuildContext context, bool isNext, String titleText,
      String hintText, String content, Function(Object?) function,
      {TextInputType? keyboardType, String? otherText, String? title}) {
    NavigatorUtils.pushResult(context, ProfileRouter.inputTextPage, function,
        arguments: InputTextPageArgumentsData(
          isNext: isNext,
          title: title,
          titleText: titleText,
          hintText: hintText,
          content: content,
          otherText: otherText,
          keyboardType: keyboardType,
        ));
  }
}
