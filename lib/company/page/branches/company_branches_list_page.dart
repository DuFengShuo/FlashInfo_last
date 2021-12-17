import 'package:flashinfo/company/company_rouder.dart';
import 'package:flashinfo/company/iview/company_detail_iview.dart';
import 'package:flashinfo/company/models/company_details_bean.dart';
import 'package:flashinfo/company/presenter/company_detial_other_presenter.dart';
import 'package:flashinfo/mvp/base_page.dart';
import 'package:flashinfo/mvp/power_presenter.dart';
import 'package:flashinfo/provider/base_list_provider.dart';
import 'package:flashinfo/res/resources.dart';
import 'package:flashinfo/routers/fluro_navigator.dart';
import 'package:flashinfo/widgets/my_app_bar.dart';
import 'package:flashinfo/widgets/my_refresh_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class CompanyDetailsBranchesListPage extends StatefulWidget {
  const CompanyDetailsBranchesListPage({Key? key, required this.companyId})
      : super(key: key);
  final String? companyId;

  @override
  _CompanyDetailsBranchesListPageState createState() =>
      _CompanyDetailsBranchesListPageState();
}

class _CompanyDetailsBranchesListPageState
    extends State<CompanyDetailsBranchesListPage>
    with BasePageMixin<CompanyDetailsBranchesListPage, PowerPresenter>
    implements CompanyBranchesIMvpView {
  @override
  BaseListProvider<BranchesModel> companyBranchesListProvider =
      BaseListProvider<BranchesModel>();
  late CompanyBranchesPresenter _companyBranchesPresenter;

  @override
  PowerPresenter createPresenter() {
    final PowerPresenter powerPresenter = PowerPresenter<dynamic>(this);
    _companyBranchesPresenter = CompanyBranchesPresenter();
    _companyBranchesPresenter.companyId = widget.companyId ?? '';
    powerPresenter.requestPresenter([_companyBranchesPresenter]);
    return powerPresenter;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<BaseListProvider<BranchesModel>>(
      create: (_) => companyBranchesListProvider,
      child: Consumer<BaseListProvider<BranchesModel>>(
        builder: (_, provider, __) {
          return Scaffold(
            appBar: const MyAppBar(
              centerTitle: 'Branches',
            ),
            backgroundColor: Colours.bg_color,
            body: DeerListView(
              key: const Key('Branche_company_new'),
              itemCount: provider.list.length,
              stateType: provider.stateType,
              onRefresh: _companyBranchesPresenter.onRefresh,
              loadMore: _companyBranchesPresenter.loadMore,
              hasMore: provider.hasMore,
              totalPages: provider.metaModel?.pagination?.totalPages ?? 1,
              itemBuilder: (_, index) {
                return Padding(
                  padding: EdgeInsets.only(left: 16.w, right: 16.w),
                  child:
                      BranchesItemWidget(branchesModel: provider.list[index]),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class BranchesItemWidget extends StatelessWidget {
  const BranchesItemWidget({Key? key, this.branchesModel}) : super(key: key);
  final BranchesModel? branchesModel;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
        NavigatorUtils.push(context,
            '${CompanyRouder.companyDetailsPage}?companyId=${branchesModel?.id}');
      },
      child: Container(
        margin:
            EdgeInsets.only(bottom: Dimens.gap_v_dp5, top: Dimens.gap_v_dp5),
        child: Container(
            decoration: BoxDecoration(
                color: Colours.material_bg,
                border: Border.all(
                  color: Colours.border_grey,
                  width: 1,
                ),
                borderRadius: const BorderRadius.all(Radius.circular(12))),
            child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: Dimens.gap_dp16, vertical: Dimens.gap_v_dp12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Gaps.vGap4,
                    Text(
                      '${branchesModel?.name ?? ''}',
                      style: TextStyles.textBold12
                          .copyWith(color: Colours.app_main),
                    ),
                    Gaps.vGap16,
                    Row(
                      children: [
                        Text(
                          'Location：',
                          style: TextStyles.textGray12,
                        ),
                        Expanded(
                          child: Text(
                            '${branchesModel!.location!.isEmpty ? '-' : branchesModel?.location}',
                            style: TextStyles.textSize12
                                .copyWith(color: Colours.text),
                            textAlign: TextAlign.end,
                          ),
                        ),
                      ],
                    ),
                    Gaps.vGap16,
                    Row(
                      children: [
                        Text(
                          'Operation Status：',
                          style: TextStyles.textGray12,
                        ),
                        const Spacer(),
                        Visibility(
                          child: Container(
                            width: 6.w,
                            height: 6.w,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(6.r)),
                                color: branchesModel?.companyStatus!
                                            .toLowerCase() ==
                                        'active'
                                    ? Colours.text_043
                                    : (branchesModel?.companyStatus!
                                                .toLowerCase() ==
                                            'inactive'
                                        ? Colours.red
                                        : Colours.text)),
                          ),
                          visible: branchesModel!.companyStatus!.isNotEmpty,
                        ),
                        Gaps.hGap4,
                        Text(
                          '${(branchesModel?.companyStatus ?? '').isEmpty ? '-' : (branchesModel?.companyStatus ?? '')}',
                          style: TextStyles.textSize12
                              .copyWith(color: Colours.text),
                          textAlign: TextAlign.end,
                        )
                      ],
                    ),
                    Gaps.vGap4,
                  ],
                ))),
      ),
    );
  }
}
