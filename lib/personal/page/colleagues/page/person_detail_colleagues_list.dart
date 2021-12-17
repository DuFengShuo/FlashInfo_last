import 'package:flashinfo/mvp/base_page.dart';
import 'package:flashinfo/mvp/power_presenter.dart';
import 'package:flashinfo/personal/iview/personal_ivew.dart';
import 'package:flashinfo/personal/model/peoples_new_bean.dart';
import 'package:flashinfo/personal/page/colleagues/widget/colleague_list_cell.dart';
import 'package:flashinfo/personal/page/experience/widget/experience_cell.dart';
import 'package:flashinfo/personal/presenter/personal_details_other_presenter.dart';
import 'package:flashinfo/provider/base_list_provider.dart';
import 'package:flashinfo/res/resources.dart';
import 'package:flashinfo/widgets/Layout/state_layout.dart';
import 'package:flashinfo/widgets/my_app_bar.dart';
import 'package:flashinfo/widgets/my_refresh_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class ColleaguesListPage extends StatefulWidget {
  final String peopleId;

  const ColleaguesListPage({Key? key, required this.peopleId})
      : super(key: key);

  @override
  _ColleaguesListPageState createState() => _ColleaguesListPageState();
}

class _ColleaguesListPageState extends State<ColleaguesListPage>
    with BasePageMixin<ColleaguesListPage, PowerPresenter>
    implements PersonalColleaguesIMvpView {
  @override
  void initState() {
    super.initState();
    // personalColleaguesProvider.setStateType(StateType.listLayout);
    // WidgetsBinding.instance!.addPostFrameCallback(
    //       (_) async {
    //
    //     _personalColleaguesPresenter.onRefresh();//请求数据
    //   },
    // );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<BaseListProvider<Colleagues>>(
        create: (_) => personalColleaguesProvider,
        child:
            Consumer<BaseListProvider<Colleagues>>(builder: (_, provider, __) {
          return Scaffold(
              backgroundColor: Colours.bg_color,
              appBar: const MyAppBar(
                centerTitle: 'Colleagues',
              ),
              body: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: Dimens.gap_dp16,
                ),
                child: DeerListView(
                  key: const Key('colleaguesList'),
                  itemCount: personalColleaguesProvider.list.length,
                  // onRefresh: () async {},
                  // loadMore: () async {},
                  hasMore: false,
                  stateType: provider.stateType,
                  itemBuilder: (_, index) {
                    Colleagues colleagues =
                        personalColleaguesProvider.list[index];
                    return Padding(
                      padding: EdgeInsets.only(top: index == 0 ? 16.h : 0),
                      child: ColleaguelistCell(
                        colleagues: colleagues,
                      ),
                    );
                  },
                ),
              ));
        }));
  }

  @override
  BaseListProvider<Colleagues> personalColleaguesProvider =
      BaseListProvider<Colleagues>();
  late PersonalColleaguesPresenter _personalColleaguesPresenter;

  @override
  PowerPresenter createPresenter() {
    final PowerPresenter powerPresenter = PowerPresenter<dynamic>(this);
    _personalColleaguesPresenter = PersonalColleaguesPresenter();
    _personalColleaguesPresenter.personnelId = widget.peopleId;
    powerPresenter.requestPresenter([_personalColleaguesPresenter]);
    return powerPresenter;
  }
}
