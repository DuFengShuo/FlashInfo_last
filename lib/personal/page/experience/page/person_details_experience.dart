import 'package:flashinfo/company/widget/details/company_details_item_header.dart';
import 'package:flashinfo/mvp/base_page.dart';
import 'package:flashinfo/mvp/power_presenter.dart';
import 'package:flashinfo/personal/iview/personal_ivew.dart';
import 'package:flashinfo/personal/model/person_work_bean.dart';
import 'package:flashinfo/personal/page/experience/widget/experience_cell.dart';
import 'package:flashinfo/personal/personal_router.dart';
import 'package:flashinfo/personal/presenter/personal_details_other_presenter.dart';
import 'package:flashinfo/personal/provider/personal_provider.dart';
import 'package:flashinfo/provider/base_list_provider.dart';
import 'package:flashinfo/res/resources.dart';
import 'package:flashinfo/routers/fluro_navigator.dart';
import 'package:flashinfo/widgets/card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class PersonalExperience extends StatefulWidget {
  final String? personalId;
  const PersonalExperience({Key? key, this.personalId}) : super(key: key);

  @override
  _PersonalExperienceState createState() => _PersonalExperienceState();
}

class _PersonalExperienceState extends State<PersonalExperience>
    with BasePageMixin<PersonalExperience, PowerPresenter>
    implements PersonalExperienceIMvpView {
  late int totals = 0;

  //  @override
  // void initState() {
  //   super.initState();
  //    // WidgetsBinding.instance!.addPostFrameCallback((_) {
  //    //   _personalExperiencePresenter.personnelId = widget.personalId??'';
  //    // _personalExperiencePresenter.getPersonalExperienceList();
  //    // });
  // }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<BaseListProvider<WorkData>>(
            create: (_) => personalExperienceProvider,
          ),
          ChangeNotifierProvider<PersonalExperienceCountProvider>(
            create: (_) => personalExperienceCountProvider,
          ),
        ],
        child: Consumer2<BaseListProvider<WorkData>,
                PersonalExperienceCountProvider>(
            builder: (_, provider, personalExperienceCountProvider, __) {
          return Padding(
              padding: EdgeInsets.only(
                  left: 16.w, right: 16.w, bottom: 8.h, top: 8.h),
              child: CardWidget(
                  radius: 12.0.r,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(12.r)),
                      color: Colours.material_bg,
                    ),
                    padding: EdgeInsets.symmetric(horizontal: Dimens.gap_dp16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CompanyDetailsItemHeader(
                            isNewIcon: true,
                            iconName: 0xe677,
                            name: 'Experience',
                            count: personalExperienceCountProvider.count,
                            onTap: personalExperienceCountProvider.count > 3
                                ? () {
                                    NavigatorUtils.push(context,
                                        '${PersonalRouter.personalExperienceList}?personalId=${widget.personalId}');
                                  }
                                : null),
                        if (personalExperienceProvider.list.isEmpty)
                          Padding(
                            padding: EdgeInsets.only(
                                bottom: 16.h,
                                left: 16.w,
                                right: 16.w,
                                top: 10.h),
                            child: SizedBox(
                              width: double.infinity,
                              height: 20.h,
                              child: const Text(
                                  'There are no experience for this people.'),
                            ),
                          )
                        else
                          ListView.builder(
                            padding: EdgeInsets.only(
                              bottom: 8.h,
                            ),
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: personalExperienceProvider.list.length > 3
                                ? 3
                                : personalExperienceProvider.list.length,
                            itemBuilder: (BuildContext context, int index) {
                              // final EventModel models = list[index];
                              WorkData workData = personalExperienceProvider.list[index];
                              return ExperienceCell(
                                workData: workData,
                              );
                            },
                          )
                      ],
                    ),
                  )));
        }));
  }

  @override
  BaseListProvider<WorkData> personalExperienceProvider =
      BaseListProvider<WorkData>();

  late PersonalExperiencePresenter _personalExperiencePresenter;

  @override
  PowerPresenter createPresenter() {
    final PowerPresenter powerPresenter = PowerPresenter<dynamic>(this);
    _personalExperiencePresenter = PersonalExperiencePresenter();
    _personalExperiencePresenter.personnelId = widget.personalId??'';
    powerPresenter.requestPresenter([_personalExperiencePresenter]);
    return powerPresenter;
  }

  @override
  PersonalExperienceCountProvider personalExperienceCountProvider =
      PersonalExperienceCountProvider();
}
