import 'package:flashinfo/company/iview/company_detail_iview.dart';
import 'package:flashinfo/company/models/company_details_bean.dart';
import 'package:flashinfo/company/page/officers/company_detail_officers_page.dart';
import 'package:flashinfo/company/presenter/company_detial_other_presenter.dart';
import 'package:flashinfo/mvp/base_page.dart';
import 'package:flashinfo/mvp/power_presenter.dart';
import 'package:flashinfo/provider/base_list_provider.dart';
import 'package:flashinfo/res/resources.dart';
import 'package:flashinfo/widgets/card_widget.dart';
import 'package:flashinfo/widgets/my_app_bar.dart';
import 'package:flashinfo/widgets/my_refresh_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class CompanyOfficersListPage extends StatefulWidget {
  const CompanyOfficersListPage({Key? key, required this.companyId})
      : super(key: key);
  final String? companyId;

  @override
  _CompanyOfficersListPageState createState() =>
      _CompanyOfficersListPageState();
}

class _CompanyOfficersListPageState extends State<CompanyOfficersListPage>
    with BasePageMixin<CompanyOfficersListPage, PowerPresenter>
    implements CompanyOfficerIMvpView {
  @override
  BaseListProvider<OfficersModel> companyOfficerListProvider =
      BaseListProvider<OfficersModel>();

  late CompanyOfficerPresenter _companyOfficerPresenter;
  List<int> selectIndexArr = [];
  @override
  PowerPresenter createPresenter() {
    final PowerPresenter powerPresenter = PowerPresenter<dynamic>(this);
    _companyOfficerPresenter = CompanyOfficerPresenter();
    _companyOfficerPresenter.companyId = widget.companyId ?? '';
    powerPresenter.requestPresenter([_companyOfficerPresenter]);
    return powerPresenter;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<BaseListProvider<OfficersModel>>(
      create: (_) => companyOfficerListProvider,
      child: Consumer<BaseListProvider<OfficersModel>>(
        builder: (_, provider, __) {
          return Scaffold(
            appBar: const MyAppBar(
              centerTitle: 'Officers/Directors',
            ),
            backgroundColor: Colours.bg_color,
            body: DeerListView(
              key: const Key('comapny_officersList'),
              itemCount: provider.list.length,
              stateType: provider.stateType,
              onRefresh: _companyOfficerPresenter.onRefresh,
              loadMore: _companyOfficerPresenter.loadMore,
              hasMore: provider.hasMore,
              totalPages: provider.metaModel?.pagination?.totalPages ?? 1,
              itemBuilder: (_, index) {
                final OfficersModel? officersModel = provider.list[index];
                return Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                  child: CardWidget(
                      radius: 12.r,
                      child: OfficerItemWidget(
                          officersModel: officersModel,
                          isShowMore:
                              selectIndexArr.contains(index) ? true : false,
                          onTap: () {
                            if (selectIndexArr.contains(index)) {
                              selectIndexArr.remove(index);
                            } else {
                              selectIndexArr.add(index);
                            }
                            //变为折叠状态
                            setState(() {});
                          })),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
