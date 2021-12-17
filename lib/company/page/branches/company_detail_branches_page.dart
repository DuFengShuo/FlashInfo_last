import 'package:flashinfo/common/common.dart';
import 'package:flashinfo/company/company_rouder.dart';
import 'package:flashinfo/company/models/company_details_bean.dart';
import 'package:flashinfo/company/provider/company_provider.dart';
import 'package:flashinfo/company/widget/details/company_details_item_header.dart';
import 'package:flashinfo/login/login_router.dart';
import 'package:flashinfo/profile/profile_router.dart';
import 'package:flashinfo/provider/user_info_provider.dart';
import 'package:flashinfo/res/resources.dart';
import 'package:flashinfo/routers/fluro_navigator.dart';
import 'package:flashinfo/widgets/card_widget.dart';
import 'package:flashinfo/widgets/login_toast_dialog.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class CompanyDetailsBranchesPage extends StatelessWidget {
  const CompanyDetailsBranchesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer2<CompanyProvider, UserInfoProvider>(
      builder: (_, provider, userInfoProvider, __) {
        final Branches? branch = provider.companyDetailsBean?.branches;
        final String? companyId = provider.companyDetailsBean?.info?.id;
        return Visibility(
            visible: true,
            child: Padding(
                padding: EdgeInsets.only(
                    left: 16.w, right: 16.w, bottom: 8.h, top: 8.h),
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
                                  iconName: 0xe63f,
                                  isNewIcon: true,
                                  name: 'Branches',
                                  count: branch?.total ?? 0,
                                  onTap: (branch?.total ?? 0) > 5
                                      ? () {
                                          if (!(SpUtil.getBool(Constant.isLogin,
                                                  defValue: false) ??
                                              false)) {
                                            showDialog<void>(
                                                context: context,
                                                barrierDismissible: true,
                                                builder: (_) =>
                                                    LoginToastDialog(
                                                        onPressed: () {
                                                      Navigator.pop(context);
                                                      NavigatorUtils.pushResult(
                                                          context,
                                                          LoginRouter
                                                              .smsLoginPage,
                                                          (value) {});
                                                    }));
                                            return;
                                          }
                                          if (!userInfoProvider.isVip) {
                                            NavigatorUtils.pushResult(
                                                context,
                                                '${ProfileRouter.businessCenterPage}?isShowLog=true',
                                                (value) {});
                                            return;
                                          }
                                          NavigatorUtils.push(context,
                                              '${CompanyRouder.companyBranchesList}?companyId=$companyId');
                                        }
                                      : null)),
                          Container(
                              margin: EdgeInsets.only(
                                  left: 16.w, right: 16.w, bottom: 10.h),
                              width: double.infinity,
                              child: branch == null || branch.data!.isEmpty
                                  ? Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 12.h),
                                      child: Text(
                                        'There are no Branches for this company.',
                                        style: TextStyles.textGray12,
                                      ),
                                    )
                                  : ListView.builder(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount: branch.data!.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        final BranchesModel branchesModel =
                                            branch.data![index];
                                        return BranchesItemWidget(
                                          branchesModel: branchesModel,
                                        );
                                      })),
                        ],
                      ),
                    ))));
      },
    );
  }
}

class BranchesItemWidget extends StatelessWidget {
  final BranchesModel? branchesModel;
  const BranchesItemWidget({Key? key, this.branchesModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        NavigatorUtils.push(context,
            '${CompanyRouder.companyDetailsPage}?companyId=${branchesModel?.id}');
      },
      child: Container(
        margin:
            EdgeInsets.only(bottom: Dimens.gap_v_dp5, top: Dimens.gap_v_dp5),
        child: Container(
            decoration: BoxDecoration(
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
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Text(
                            '${branchesModel?.name ?? ''}',
                            style: TextStyles.textBold12
                                .copyWith(color: Colours.app_main),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        )
                      ],
                    ),
                    Gaps.vGap16,
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Location',
                          style: TextStyles.textGray12,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
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
                          'Operation Status',
                          style: TextStyles.textGray12,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
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
                          maxLines: 1,
                          textAlign: TextAlign.end,
                          overflow: TextOverflow.ellipsis,
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
