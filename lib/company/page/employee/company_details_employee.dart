import 'package:flashinfo/company/company_rouder.dart';
import 'package:flashinfo/company/models/company_detail_model.dart';
import 'package:flashinfo/company/page/finance/company_finance_employee.dart';
import 'package:flashinfo/company/provider/company_provider.dart';
import 'package:flashinfo/personal/model/peoples_bean.dart';
import 'package:flashinfo/res/resources.dart';
import 'package:flashinfo/routers/fluro_navigator.dart';
import 'package:flashinfo/widgets/card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../widget/details/company_details_item_header.dart';

class CompanyDetailsEmployee extends StatelessWidget {
  const CompanyDetailsEmployee({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<CompanyProvider>(
      builder: (_, provider, __) {
        final CompanyDetailModel? companyDetailModel =
            provider.companyDetailModel;
        final List<PeoplesModel> list =
            provider.companyDetailModel?.personnel?.personnelModel ?? [];
        int count = 0;
        if (list.isNotEmpty) {
          count = list.length <= 5 ? list.length : 5;
        }
        return Visibility(
            visible: count != 0,
            child: Padding(
                padding: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 16.h),
                child: CardWidget(
                    radius: 12.0.r,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(12.r)),
                        color: Colours.material_bg,
                      ),
                      child: Column(
                        children: [
                          Padding(
                              padding: EdgeInsets.only(
                                left: 16.w,
                                right: 16.w,
                              ),
                              child: CompanyDetailsItemHeader(
                                  iconName: 0xe677,
                                  name: 'Employee',
                                  count: list.length,
                                  onTap: () => NavigatorUtils.push(context,
                                      '${CompanyRouder.companyEmployeePage}?companyId=${companyDetailModel?.id}'))),
                          Container(
                              margin: EdgeInsets.only(left: 28.w, right: 28.w),
                              width: double.infinity,
                              height: list.length > 3 ? 300.h : 150.h,
                              child: FinanceEmployee(
                                listData: list,
                              )),
                        ],
                      ),
                    ))));
      },
    );
  }
}
