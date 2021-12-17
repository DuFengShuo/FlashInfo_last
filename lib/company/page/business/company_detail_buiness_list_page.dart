import 'package:flashinfo/company/iview/company_detail_iview.dart';
import 'package:flashinfo/company/models/company_details_bean.dart';
import 'package:flashinfo/company/presenter/company_detial_other_presenter.dart';
import 'package:flashinfo/company/widget/details/company_business_cell.dart';
import 'package:flashinfo/mvp/base_page.dart';
import 'package:flashinfo/mvp/power_presenter.dart';
import 'package:flashinfo/provider/base_list_provider.dart';
import 'package:flashinfo/res/resources.dart';
import 'package:flashinfo/widgets/my_app_bar.dart';
import 'package:flashinfo/widgets/my_refresh_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CompanyBusinessListPage extends StatefulWidget {
  const CompanyBusinessListPage({Key? key, required this.companyId})
      : super(key: key);
  final String? companyId;

  @override
  _CompanyBusinessListPageState createState() =>
      _CompanyBusinessListPageState();
}

class _CompanyBusinessListPageState extends State<CompanyBusinessListPage>
    with BasePageMixin<CompanyBusinessListPage, PowerPresenter>
    implements CompanyBusinessIMvpView {
  @override
  BaseListProvider<BusinessModel> companyBusinessListProvider =
      BaseListProvider<BusinessModel>();

  late CompanyBusinessPresenter _companyBusinessPresenter;

  @override
  PowerPresenter createPresenter() {
    final PowerPresenter powerPresenter = PowerPresenter<dynamic>(this);
    _companyBusinessPresenter = CompanyBusinessPresenter();
    _companyBusinessPresenter.companyId = widget.companyId ?? '';
    powerPresenter.requestPresenter([_companyBusinessPresenter]);
    return powerPresenter;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<BaseListProvider<BusinessModel>>(
      create: (_) => companyBusinessListProvider,
      child: Consumer<BaseListProvider<BusinessModel>>(
        builder: (_, provider, __) {
          return Scaffold(
            appBar: const MyAppBar(
              centerTitle: 'Business',
            ),
            backgroundColor: Colours.bg_color,
            body: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: Dimens.gap_dp16, vertical: Dimens.gap_v_dp16),
              child: DeerListView(
                key: const Key('company_businesses'),
                itemCount: provider.list.length,
                stateType: provider.stateType,
                onRefresh: _companyBusinessPresenter.onRefresh,
                loadMore: _companyBusinessPresenter.loadMore,
                hasMore: provider.hasMore,
                totalPages: provider.metaModel?.pagination?.totalPages ?? 1,
                itemBuilder: (_, index) {
                  final BusinessModel? businessModel = provider.list[index];
                  int lengString = 0;
                  businessModel?.tags!.forEach((String text) {
                    lengString = text.length + lengString;
                  });
                  return BusinessCell(
                    businessModel: provider.list[index],
                    isList: true,
                    lengString: lengString,
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
