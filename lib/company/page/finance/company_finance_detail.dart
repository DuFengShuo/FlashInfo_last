import 'package:flashinfo/brand/models/brand_bean.dart';
import 'package:flashinfo/company/page/finance/company_finance_rounds.dart';
import 'package:flashinfo/company/page/finance/company_investment.dart';
import 'package:flashinfo/company/page/finance/company_investors.dart';

import 'package:flashinfo/res/resources.dart';
import 'package:flashinfo/widgets/my_app_bar.dart';
import 'package:flutter/material.dart';

class CompanyFinanceDetailWidget extends StatefulWidget {
  final int? index;
  final String? companyId;
  // final CompanyDetailModel? companyDetailModel;
  // final CompanySubsidiaryModel? companySubsidiaryModel;
  final Financials? financials;

  const CompanyFinanceDetailWidget(
      {Key? key, this.index, this.companyId, this.financials})
      : super(key: key);

  @override
  _CompanyFinanceDetailWidgetState createState() =>
      _CompanyFinanceDetailWidgetState();
}

class _CompanyFinanceDetailWidgetState
    extends State<CompanyFinanceDetailWidget> {
  late Widget myContent;
  late String title;
  @override
  void initState() {
    super.initState();

    if (widget.index == 0) {
      title = 'Funding Rounds';
      //构建弹框中的内容
      myContent = CompanyFinanceRounds(
          companyId: widget.companyId, financials: widget.financials);
    } else if (widget.index == 1) {
      title = 'Investors';
      //构建弹框中的内容
      myContent = CompanyInvestors(
          companyId: widget.companyId, financials: widget.financials);
    } else {
      title = 'Investment';
      //构建弹框中的内容
      myContent = CompanyInvestment(
          // list: widget.companySubsidiaryModel?.investments?.list ?? [],
          companyId: widget.companyId,
          financials: widget.financials);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colours.bg_color,
        appBar: MyAppBar(
          centerTitle: title,
        ),
        body: Container(
          child: myContent,
        )
        );
  }
}
