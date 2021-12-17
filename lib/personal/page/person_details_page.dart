import 'package:flashinfo/common/common.dart';
import 'package:flashinfo/company/company_rouder.dart';
import 'package:flashinfo/company/widget/details/company_details_topbar.dart';
import 'package:flashinfo/company/widget/details/follow_contact_widget.dart';
import 'package:flashinfo/login/login_router.dart';
import 'package:flashinfo/mvp/base_page.dart';
import 'package:flashinfo/mvp/power_presenter.dart';
import 'package:flashinfo/personal/iview/personal_ivew.dart';
import 'package:flashinfo/personal/model/peoples_bean.dart';
import 'package:flashinfo/personal/model/peoples_new_bean.dart';
import 'package:flashinfo/personal/model/personal_details_bean.dart';
import 'package:flashinfo/personal/page/colleagues/page/person_detail_colleagues.dart';
import 'package:flashinfo/personal/page/education/page/person_details_education.dart';
import 'package:flashinfo/personal/page/experience/page/person_details_experience.dart';
import 'package:flashinfo/personal/page/languages/page/person_detail_language.dart';
import 'package:flashinfo/personal/page/licenses/page/person_detail_licenses.dart';
import 'package:flashinfo/personal/page/skills/page/person_details_skill.dart';
import 'package:flashinfo/personal/presenter/personal_details_presenter.dart';
import 'package:flashinfo/personal/provider/personal_provider.dart';
import 'package:flashinfo/personal/widget/bottomSheet/people_contact.dart';
import 'package:flashinfo/personal/widget/details/person_details_achievements.dart';
import 'package:flashinfo/personal/widget/details/person_details_education.dart';
import 'package:flashinfo/personal/widget/details/person_details_header.dart';
import 'package:flashinfo/personal/widget/details/person_details_job.dart';
import 'package:flashinfo/personal/widget/details/person_details_top.dart';
import 'package:flashinfo/res/colors.dart';
import 'package:flashinfo/res/resources.dart';
import 'package:flashinfo/routers/fluro_navigator.dart';
import 'package:flashinfo/util/device_utils.dart';
import 'package:flashinfo/util/image_utils.dart';
import 'package:flashinfo/util/send_analytics_event.dart';
import 'package:flashinfo/widgets/Layout/state_layout.dart';
import 'package:flashinfo/widgets/detail_position_page.dart';
import 'package:flashinfo/widgets/login_toast_dialog.dart';
import 'package:flashinfo/widgets/my_scroll_view.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class PersonDetailsPage extends StatefulWidget {
  const PersonDetailsPage({Key? key, required this.personalId, this.model,})
      : super(key: key);
  final String personalId;
   final PeoplesModel? model;

  @override
  _PersonDetailsPageState createState() => _PersonDetailsPageState();
}

class _PersonDetailsPageState extends State<PersonDetailsPage>
    with BasePageMixin<PersonDetailsPage, PowerPresenter>
    implements PersonalDetialIMvpView {
  late ScrollController _scrollController;
  int showSearch = 0;

  late List<Widget> contentWidgets = [];
  late List<String> tabs = [];

  @override
  PersonalProvider personalProvider = PersonalProvider();
  late PersonalDetailPresenter _personalDetailPresenter;

  @override
  PowerPresenter createPresenter() {
    final PowerPresenter powerPresenter = PowerPresenter<dynamic>(this);
    _personalDetailPresenter = PersonalDetailPresenter();
    powerPresenter.requestPresenter([_personalDetailPresenter]);
    return powerPresenter;
  }

  @override
  void initState() {
    super.initState();
    personalProvider.setStateType(StateType.detailLayout);
    tabs = [
      'Summary',
      'Experience',
      'Colleagues',
      'Education',
      'Licenses',
      'Skills',
      'Languages'
    ];
    contentWidgets.add( PersonalExperience(personalId: widget.personalId,));
    contentWidgets.add(const PersonColleagues());
    contentWidgets.add(const PersonalEducation());
    contentWidgets.add(const PersonalLicenses());
    contentWidgets.add(const PersonSkill());
    contentWidgets.add(const PersonDetailLanguage());

    _scrollController = new ScrollController();
    _scrollController.addListener(() {
      if ((_scrollController.offset > 80.h && showSearch == 1) ||
          (_scrollController.offset < 80.h && showSearch == 0)) {
        return;
      }
      setState(() {
        showSearch = _scrollController.offset > 80.h ? 1 : 0;
      });
    });

    WidgetsBinding.instance!.addPostFrameCallback(
          (_) async {
        await _personalDetailPresenter.getPersonalDetail(widget.personalId);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<PersonalProvider>(
      create: (_) => personalProvider,
      child: Scaffold(
          backgroundColor: Colours.bg_color,
          body: Consumer<PersonalProvider>(builder: (_, provider, __) {
            final PeoplesNewBean? model = provider.personalDetailsBean;
            return model == null
                ? StateLayout(
                    type: provider.stateType,
                  )
                : DetailPositionPage(
                    contentPages: contentWidgets,
                    tabTitles: tabs,
                    title: 'Personal Details',
              callBack: (){
                      _personalDetailPresenter.getPersonalDetail(widget.personalId);
              },
                  );
          })),
    );
  }

  //显示底部弹框的功能
  void showBottomSheet(BuildContext context, PersonalDetailsBean? model) {
    if (!(SpUtil.getBool(Constant.isLogin, defValue: false) ?? false)) {
      showDialog<void>(
          context: context,
          barrierDismissible: true,
          builder: (_) => LoginToastDialog(onPressed: () {
                Navigator.pop(context);
                NavigatorUtils.push(context, LoginRouter.smsLoginPage);
              }));
      return;
    }

  }
}
