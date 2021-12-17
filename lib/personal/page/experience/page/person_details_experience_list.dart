import 'package:flashinfo/mvp/base_page.dart';
import 'package:flashinfo/mvp/power_presenter.dart';
import 'package:flashinfo/personal/iview/personal_ivew.dart';
import 'package:flashinfo/personal/model/person_work_bean.dart';
import 'package:flashinfo/personal/page/experience/widget/experience_cell.dart';
import 'package:flashinfo/personal/presenter/personal_details_other_presenter.dart';
import 'package:flashinfo/personal/page/experience/widget/personal_experience_toast_widget.dart';
import 'package:flashinfo/personal/provider/personal_provider.dart';
import 'package:flashinfo/personal/widget/personal_info_toast.dart';
import 'package:flashinfo/provider/base_list_provider.dart';
import 'package:flashinfo/res/resources.dart';
import 'package:flashinfo/widgets/Layout/state_layout.dart';
import 'package:flashinfo/widgets/my_app_bar.dart';
import 'package:flashinfo/widgets/my_refresh_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class ExperienceListPage extends StatefulWidget {
  final String? personalId;

  const ExperienceListPage({Key? key, this.personalId}) : super(key: key);

  @override
  _ExperienceListPageState createState() => _ExperienceListPageState();
}

class _ExperienceListPageState extends State<ExperienceListPage>
    with BasePageMixin<ExperienceListPage, PowerPresenter>
    implements PersonalExperienceIMvpView {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<BaseListProvider<WorkData>>(
        create: (_) => personalExperienceProvider,
        child: Consumer<BaseListProvider<WorkData>>(builder: (_, provider, __) {
          return Scaffold(
              backgroundColor: Colours.bg_color,
              appBar: const MyAppBar(
                centerTitle: 'Experience',
              ),
              body: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: Dimens.gap_dp16,
                ),
                child: DeerListView(
                  key: const Key('experience'),
                  itemCount: personalExperienceProvider.list.length,
                  onRefresh: () => _personalExperiencePresenter.onRefresh(),
                  loadMore: () => _personalExperiencePresenter.loadMore(),
                  hasMore: personalExperienceProvider.hasMore,
                  stateType: personalExperienceProvider.stateType,
                  pageSize: 1,
                  itemBuilder: (_, index) {
                    WorkData workData = personalExperienceProvider.list[index];
                    return Padding(
                      padding: EdgeInsets.only(top: index == 0 ? 16.h : 0),
                      child: ExperienceCell(
                        workData: workData,
                      ),
                    );
                  },
                ),
              ));
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
    _personalExperiencePresenter.personnelId = widget.personalId!;
    powerPresenter.requestPresenter([_personalExperiencePresenter]);
    return powerPresenter;
  }

  void onTapIcon(BuildContext context, WorkData workData) {
    showModalBottomSheet<void>(
        // 权限提示弹框
        backgroundColor: Colors.transparent, //重点
        context: context,
        builder: (BuildContext context) {
          return PersonalExperienceDes(
            workData: workData,
          );
        });
  }

  @override
  PersonalExperienceCountProvider  personalExperienceCountProvider = PersonalExperienceCountProvider();
}
