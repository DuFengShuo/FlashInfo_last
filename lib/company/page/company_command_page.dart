import 'package:flashinfo/company/company_rouder.dart';
import 'package:flashinfo/company/iview/company_detail_iview.dart';
import 'package:flashinfo/company/models/company_bean.dart';
import 'package:flashinfo/company/presenter/company_detial_other_presenter.dart';
import 'package:flashinfo/company/widget/company_cell_widget.dart';
import 'package:flashinfo/mvp/base_page.dart';
import 'package:flashinfo/mvp/power_presenter.dart';
import 'package:flashinfo/mvp/status_model.dart';
import 'package:flashinfo/provider/base_list_provider.dart';
import 'package:flashinfo/res/resources.dart';
import 'package:flashinfo/routers/fluro_navigator.dart';
import 'package:flashinfo/widgets/my_app_bar.dart';
import 'package:flashinfo/widgets/my_refresh_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CompanyCommandPage extends StatefulWidget {
  const CompanyCommandPage({Key? key, required this.companyId})
      : super(key: key);
  final String? companyId;
  @override
  _CompanyCommandPageState createState() => _CompanyCommandPageState();
}

class _CompanyCommandPageState extends State<CompanyCommandPage>
    with BasePageMixin<CompanyCommandPage, PowerPresenter>
    implements CompanyCommandIMvpView {
  @override
  BaseListProvider<CompanyModel> companyCommandProvider =
      BaseListProvider<CompanyModel>();

  late CompanyCommandPresenter _companyCommandPresenter;
  @override
  PowerPresenter createPresenter() {
    final PowerPresenter powerPresenter = PowerPresenter<dynamic>(this);
    _companyCommandPresenter = CompanyCommandPresenter();
    _companyCommandPresenter.companyId = widget.companyId ?? '';
    powerPresenter.requestPresenter([_companyCommandPresenter]);
    return powerPresenter;
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<BaseListProvider<CompanyModel>>(
            create: (_) => companyCommandProvider),
      ],
      child: Scaffold(
        backgroundColor: Colours.bg_color,
        appBar: const MyAppBar(
          centerTitle: 'Recommand',
        ),
        body: Consumer<BaseListProvider<CompanyModel>>(
          builder: (_, provider, __) {
            return Padding(
              padding: EdgeInsets.only(top: Dimens.gap_v_dp16),
              child: DeerListView(
                key: const Key('Recommand_list'),
                itemCount: provider.list.length,
                stateType: provider.stateType,
                onRefresh: _companyCommandPresenter.onRefresh,
                loadMore: _companyCommandPresenter.loadMore,
                hasMore: provider.hasMore,
                totalPages: provider.metaModel?.pagination?.totalPages ?? 1,
                itemBuilder: (_, index) {
                  final CompanyModel model = provider.list[index];
                  return CompanyCellWidget(
                    collectSuccessful: (StatusModel statusModel) {
                      model.isCollect = !(model.isCollect ?? false);
                    },
                    isLead: true,
                    companyModel: model,
                    onTap: () => NavigatorUtils.pushResult(context,
                        '${CompanyRouder.companyDetailsPage}?companyId=${model.id}',
                        (value) {
                      print(value);
                    }, arguments: model),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
