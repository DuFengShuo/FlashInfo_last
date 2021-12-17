import 'package:flashinfo/common/common.dart';
import 'package:flashinfo/company/company_rouder.dart';
import 'package:flashinfo/company/models/company_details_bean.dart';
import 'package:flashinfo/company/provider/company_provider.dart';
import 'package:flashinfo/company/widget/details/company_business_cell.dart';
import 'package:flashinfo/company/widget/details/company_details_item_header.dart';
import 'package:flashinfo/login/login_router.dart';
import 'package:flashinfo/res/resources.dart';
import 'package:flashinfo/routers/fluro_navigator.dart';
import 'package:flashinfo/util/screen_utils.dart';
import 'package:flashinfo/widgets/card_widget.dart';
import 'package:flashinfo/widgets/login_toast_dialog.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class CompanyBusinessPage extends StatefulWidget {
  const CompanyBusinessPage({Key? key}) : super(key: key);

  @override
  _CompanyBusinessPageState createState() => _CompanyBusinessPageState();
}

class _CompanyBusinessPageState extends State<CompanyBusinessPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<CompanyProvider>(builder: (_, provider, __) {
      final BusinessDatas? business = provider.companyDetailsBean!.business;
      return Padding(
          padding:
              EdgeInsets.only(left: 16.w, right: 16.w, bottom: 8.h, top: 8.h),
          child: CardWidget(
              radius: 12.0.r,
              child: Container(
                width: Screen.width(context),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(12.r)),
                  color: Colours.material_bg,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: Dimens.gap_dp16,
                      ),
                      child: CompanyDetailsItemHeader(
                          iconName: 0xe64c,
                          name: 'Business',
                          isNewIcon: true,
                          count: business?.total ?? 0,
                          onTap: (business?.total ?? 0) <= 5
                              ? null
                              : () {
                                  if (!(SpUtil.getBool(Constant.isLogin,
                                          defValue: false) ??
                                      false)) {
                                    showDialog<void>(
                                        context: context,
                                        barrierDismissible: true,
                                        builder: (_) =>
                                            LoginToastDialog(onPressed: () {
                                              Navigator.pop(context);
                                              NavigatorUtils.push(context,
                                                  LoginRouter.smsLoginPage);
                                            }));
                                    return;
                                  }
                                  NavigatorUtils.push(context,
                                      '${CompanyRouder.companyBusinessList}?companyId=${provider.companyDetailsBean?.info?.id}');
                                }),
                    ),
                    Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(12.r)),
                          color: Colours.material_bg,
                        ),
                        height: (business?.total ?? 0) > 0 ? 145.h : 50.h,
                        child: NotificationListener<ScrollNotification>(
                          onNotification: (ScrollNotification notification) {
                            return true; //放开此行注释后，进度条将失效
                          },
                          child: (business?.total ?? 0) == 0
                              ? Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 12.h, horizontal: 16.w),
                                  child: Text(
                                    'There are no Business for this company.',
                                    style: TextStyles.textGray12,
                                  ),
                                )
                              : ListView.builder(
                                  shrinkWrap: true,
                                  physics: const BouncingScrollPhysics(),
                                  padding:
                                      EdgeInsets.only(left: 12.w, bottom: 16.h),
                                  scrollDirection: Axis.horizontal,
                                  itemCount: business?.data?.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    final BusinessModel? businessModel =
                                        business?.data![index];
                                    return Padding(
                                      padding: EdgeInsets.only(right: 16.w),
                                      child: BusinessCell(
                                        isList: false,
                                        businessModel: businessModel,
                                      ),
                                    );
                                  }),
                        )),
                    // Gaps.vGap16,
                  ],
                ),
              )));
    });
  }
}
