import 'package:flashinfo/brand/models/brand_bean.dart';
import 'package:flashinfo/company/company_rouder.dart';
import 'package:flashinfo/company/iview/company_detail_iview.dart';
import 'package:flashinfo/company/models/investments_bean.dart';
import 'package:flashinfo/company/page/finance/company_finance_no_data.dart';
import 'package:flashinfo/company/page/finance/company_finance_rounds.dart';
import 'package:flashinfo/company/page/finance/company_finance_sheet.dart';
import 'package:flashinfo/company/presenter/company_detial_other_presenter.dart';
import 'package:flashinfo/mvp/base_page.dart';
import 'package:flashinfo/mvp/power_presenter.dart';
import 'package:flashinfo/provider/base_list_provider.dart';
import 'package:flashinfo/provider/user_info_provider.dart';
import 'package:flashinfo/res/dimens.dart';
import 'package:flashinfo/res/gaps.dart';
import 'package:flashinfo/res/resources.dart';
import 'package:flashinfo/res/styles.dart';
import 'package:flashinfo/routers/fluro_navigator.dart';
import 'package:flashinfo/widgets/load_image.dart';
import 'package:flashinfo/widgets/login_unlock_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CompanyInvestment extends StatefulWidget {
  const CompanyInvestment(
      {Key? key, this.financials, this.companyId, this.list})
      : super(key: key);
  final Financials? financials;
  final String? companyId;
  final List<InvestmentsModel>? list;

  @override
  _CompanyInvestmentState createState() => _CompanyInvestmentState();
}

class _CompanyInvestmentState extends State<CompanyInvestment>
    with BasePageMixin<CompanyInvestment, PowerPresenter>
    implements CompanyInvestmentsIMvpView {
  @override
  BaseListProvider<InvestmentsModel> companyInvestmentsProvider =
      BaseListProvider<InvestmentsModel>();

  late CompanyInvestmentsPresenter _companyInvestmentsPresenter;
  late int countNum = 3;

  @override
  PowerPresenter createPresenter() {
    final PowerPresenter powerPresenter = PowerPresenter<dynamic>(this);
    _companyInvestmentsPresenter = CompanyInvestmentsPresenter();
    _companyInvestmentsPresenter.companyId = widget.companyId ?? '';
    powerPresenter.requestPresenter([_companyInvestmentsPresenter]);
    return powerPresenter;
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback(
      (_) async {
        _companyInvestmentsPresenter.onRefresh();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<BaseListProvider<InvestmentsModel>>(
      create: (_) => companyInvestmentsProvider,
      child: Consumer2<BaseListProvider<InvestmentsModel>, UserInfoProvider>(
        builder: (_, provider, userInfoProvider, __) {
          String subTitleData = '';
          if (widget.financials!.numberOfInvestments!.isNotEmpty) {
            subTitleData =
                '${companyInvestmentsProvider.metaModel?.investmentsText ?? ''}';
          }
          return CompanyFinanceSheet(
            title: 'Investment',
            subTitle: '$subTitleData',
            firstLeft: 'Number of Investments',
            firstRight:
                '${widget.financials!.numberOfInvestments!.isEmpty ? '0' : widget.financials!.numberOfInvestments}',
            lastLeft: 'Number of Lead investments',
            lastRight:
                '${widget.financials!.numberOfLeadInvestments!.isEmpty ? '0' : widget.financials!.numberOfLeadInvestments}',
            child: SizedBox(
                width: double.infinity,
                // height: 270.h,
                child: widget.financials!.numberOfInvestments!.isEmpty &&
                        widget.financials!.numberOfLeadInvestments!.isEmpty
                    ? Column(
                        children: [
                          Gaps.vGap50,
                          const LoadAssetImage(
                            'state/company',
                            width: 120,
                          ),
                          Gaps.vGap15,
                          const Text('No data')
                        ],
                      )
                    : userInfoProvider.isVip == false
                        ? LoginUnlockView(
                            fuzzyImg: 'company/funding_fuzzy',
                            loginName: 'View more details',
                            vipName:
                                'You can view it after you upgrade your membership',
                            onTap: () async {
                              await _companyInvestmentsPresenter.onRefresh();
                            },
                          )
                        : provider.list.isEmpty
                            ? Column(
                                children: [
                                  Gaps.vGap50,
                                  const LoadAssetImage(
                                    'state/company',
                                    width: 120,
                                  ),
                                  Gaps.vGap15,
                                  const Text('No data')
                                ],
                              )
                            : Column(
                                children: [
                                  ListView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: provider.list.length < 3
                                        ? provider.list.length
                                        : countNum,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return FinanceRoundsItem(
                                          model: provider.list[index]);
                                    },
                                  ),
                                  Visibility(
                                    visible: provider.list.length <= 3
                                        ? false
                                        : true,
                                    child: Gaps.vGap16,
                                  ),
                                  Visibility(
                                      visible: provider.list.length <= 3
                                          ? false
                                          : true,
                                      child: FundingRoundsMenuBtn(
                                        callBack: (bool isHasMore) {
                                          if (isHasMore == true) {
                                            setState(() {
                                              countNum = provider.list.length;
                                            });
                                          } else {
                                            setState(() {
                                              countNum = 3;
                                            });
                                          }
                                        },
                                      ))
                                ],
                              )),
          );
        },
      ),
    );
  }
}

class FinanceRoundsItem extends StatelessWidget {
  const FinanceRoundsItem({Key? key, this.model}) : super(key: key);
  final InvestmentsModel? model;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(bottom: 8.h),
        decoration: BoxDecoration(
            color: Colours.material_bg,
            border: Border.all(width: 1, color: Colours.border_grey),
            borderRadius: BorderRadius.all(Radius.circular(12.r))),
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: Dimens.gap_dp16, vertical: Dimens.gap_v_dp16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                  onTap: () {
                    NavigatorUtils.push(context,
                        '${CompanyRouder.companyDetailsPage}?companyId=${model!.organizationId}');
                  },
                  child: Text(
                    (model!.organizationName?.trim().isEmpty ?? true)
                        ? '-'
                        : '${model!.organizationName}',
                    style:
                        TextStyles.textBold12.copyWith(color: Colours.app_main),
                  )),
              Gaps.vGap16,
              Row(
                children: [
                  Text(
                    'Announced Date',
                    style: TextStyles.textGray13,
                  ),
                  const Spacer(),
                  Text(
                    (model!.announcedDate?.trim().isEmpty ?? true)
                        ? '-'
                        : '${model!.announcedDate}',
                    style: TextStyles.textSize14,
                  ),
                ],
              ),
              Gaps.vGap16,
              Padding(
                padding: EdgeInsets.only(
                  bottom: 16.h,
                ),
                child: Row(
                  children: [
                    Text(
                      'Lead Investor',
                      style: TextStyles.textGray13,
                    ),
                    const Spacer(),
                    Text(
                      model?.isLeadInvestor == 1 ? 'Yes' : 'No',
                      style: TextStyles.textSize14.copyWith(
                        color: model?.isLeadInvestor == 1
                            ? Colours.text_043
                            : Colours.red,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Fund Rounds',
                    style: TextStyles.textGray13,
                  ),
                  Gaps.hGap8,
                  Expanded(
                      child: Text(
                    (model!.fundingRoundName?.trim().isEmpty ?? true)
                        ? '-'
                        : '${model!.fundingRoundName}',
                    style: TextStyles.textSize14,
                    textAlign: TextAlign.end,
                  ))
                ],
              ),
              Gaps.vGap16,
              Row(
                children: [
                  Text(
                    'Money Raised',
                    style: TextStyles.textGray13,
                  ),
                  const Spacer(),
                  Text(
                    (model!.moneyRaised?.trim().isEmpty ?? true)
                        ? '-'
                        : '${model!.moneyRaised}',
                    style: TextStyles.textSize14,
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
