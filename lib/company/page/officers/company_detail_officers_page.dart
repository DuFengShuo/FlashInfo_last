import 'package:flashinfo/common/common.dart';
import 'package:flashinfo/company/company_rouder.dart';
import 'package:flashinfo/company/models/company_details_bean.dart';
import 'package:flashinfo/company/presenter/company_detial_presenter.dart';
import 'package:flashinfo/company/provider/company_provider.dart';
import 'package:flashinfo/company/widget/details/company_details_item_header.dart';
import 'package:flashinfo/login/login_router.dart';
import 'package:flashinfo/profile/profile_router.dart';
import 'package:flashinfo/provider/user_info_provider.dart';
import 'package:flashinfo/res/colors.dart';
import 'package:flashinfo/res/resources.dart';
import 'package:flashinfo/routers/fluro_navigator.dart';
import 'package:flashinfo/util/image_utils.dart';
import 'package:flashinfo/widgets/card_widget.dart';
import 'package:flashinfo/widgets/login_toast_dialog.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class CompanyDetailsOfficersPage extends StatefulWidget {
  final CompanyDetailPresenter companyDetailPresenter;
  const CompanyDetailsOfficersPage(
      {Key? key, required this.companyDetailPresenter})
      : super(key: key);

  @override
  _CompanyDetailsOfficersPageState createState() =>
      _CompanyDetailsOfficersPageState();
}

class _CompanyDetailsOfficersPageState
    extends State<CompanyDetailsOfficersPage> {
  List<int> selectIndexArr = [];
  @override
  Widget build(BuildContext context) {
    return Consumer2<CompanyProvider, UserInfoProvider>(
        builder: (_, companyProvider, userInfoProvider, __) {
      final Officers? officers = companyProvider.companyDetailsBean?.officers;
      final String? companyId = companyProvider.companyDetailsBean?.info?.id;
      return Padding(
          padding:
              EdgeInsets.only(left: 16.w, right: 16.w, bottom: 8.h, top: 8.h),
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
                          iconName: 0xe655,
                          name: 'Officers/Directors',
                          count: officers?.total ?? 0,
                          showLine: false,
                          isNewIcon: true,
                          onTap: (officers?.total ?? 0) > 5
                              ? () {
                                  if (!(SpUtil.getBool(Constant.isLogin,
                                          defValue: false) ??
                                      false)) {
                                    showDialog<void>(
                                        context: context,
                                        barrierDismissible: true,
                                        builder: (_) =>
                                            LoginToastDialog(onPressed: () {
                                              Navigator.pop(context);
                                              NavigatorUtils.pushResult(
                                                  context,
                                                  LoginRouter.smsLoginPage,
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
                                      '${CompanyRouder.companyOfficersList}?companyId=$companyId');
                                }
                              : null,
                        )),
                    Container(
                        margin: EdgeInsets.only(bottom: 10.h),
                        width: double.infinity,
                        child: officers == null || (officers.total ?? 0) == 0
                            ? Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 16.w, vertical: 12.h),
                                child: Text(
                                  'There are no Officers/Directors for this company.',
                                  style: TextStyles.textGray12,
                                ),
                              )
                            : ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: officers.data!.length,
                                itemBuilder: (BuildContext context, int index) {
                                  final OfficersModel? officersModel =
                                      officers.data![index];
                                  return OfficerItemWidget(
                                      officersModel: officersModel,
                                      isShowMore: selectIndexArr.contains(index)
                                          ? true
                                          : false,
                                      onTap: () {
                                        if (!(SpUtil.getBool(Constant.isLogin,
                                                defValue: false) ??
                                            false)) {
                                          showDialog<void>(
                                              context: context,
                                              barrierDismissible: true,
                                              builder: (_) => LoginToastDialog(
                                                      onPressed: () {
                                                    Navigator.pop(context);
                                                    NavigatorUtils.pushResult(
                                                        context,
                                                        LoginRouter
                                                            .smsLoginPage,
                                                        (value) {
                                                      widget
                                                          .companyDetailPresenter
                                                          .getCompanyDetail(
                                                              companyId ?? '');
                                                    });
                                                  }));
                                          return;
                                        }
                                        if (!userInfoProvider.isVip) {
                                          NavigatorUtils.pushResult(context,
                                              '${ProfileRouter.businessCenterPage}?isShowLog=true',
                                              (value) {
                                            widget.companyDetailPresenter
                                                .getCompanyDetail(
                                                    companyId ?? '');
                                          });
                                          return;
                                        }
                                        if (selectIndexArr.contains(index)) {
                                          selectIndexArr.remove(index);
                                        } else {
                                          selectIndexArr.add(index);
                                        }
                                        //变为折叠状态
                                        setState(() {});
                                      });
                                })),
                  ],
                ),
              )));
    });
  }
}

class OfficerItemWidget extends StatelessWidget {
  final OfficersModel? officersModel;
  final bool isShowMore;
  final void Function()? onTap;
  const OfficerItemWidget(
      {Key? key, this.officersModel, this.isShowMore = false, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<String> officeTitle = [
      'Type',
      'Position',
      'Start Date',
      'End Date',
      'Update Date',
      'Occupation',
      'Date of Birth',
      'Nationality',
      'Country of Residence',
      'Jurisdiction',
      'Address',
    ];
    final List<String> officeContent = [
      officersModel!.type!,
      officersModel?.position ?? '-',
      officersModel?.startDate ?? '-',
      officersModel?.endDate ?? '-',
      officersModel!.updateDate ?? '-',
      officersModel?.occupation ?? '-',
      officersModel?.dateOfBirth ?? '-',
      officersModel?.nationality ?? '-',
      officersModel?.countryOfResidence ?? '-',
      officersModel?.jurisdiction ?? '-',
      officersModel?.address ?? '-'
    ];

    return Consumer<UserInfoProvider>(builder: (_, userInfoProvider, __) {
      return Container(
        decoration: BoxDecoration(
            color: Colours.material_bg,
            borderRadius: BorderRadius.all(Radius.circular(12.r))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Gaps.line,
            Gaps.vGap12,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Text(
                '${officersModel!.name ?? ''}',
                style: TextStyles.textSize14,
              ),
            ),
            Gaps.vGap12,
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16.w),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8.r)),
                  border: Border.all(color: Colours.line, width: 1)),
              child: Container(
                  margin: EdgeInsets.only(bottom: 10.h),
                  width: double.infinity,
                  child: Column(
                    children: [
                      ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.only(top: 6.h),
                          itemCount: isShowMore ? 11 : 4,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16.w, vertical: 12.h),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${officeTitle[index]}',
                                    style: TextStyles.textGray12,
                                  ),
                                  Gaps.hGap8,
                                  Expanded(
                                    child: Text(
                                      '${officeContent[index].isNotEmpty ? officeContent[index] : '-'}',
                                      style: TextStyles.textSize12,
                                      textAlign: TextAlign.end,
                                    ),
                                  )
                                ],
                              ),
                            );
                          }),
                      Gaps.vGap12,
                      OfficeMenuBtn(
                        isShowMore: isShowMore,
                        onTap: onTap,
                      )
                    ],
                  )),
            ),
            Gaps.vGap17,
          ],
        ),
      );
    });
  }
}

class OfficeMenuBtn extends StatelessWidget {
  final bool isShowMore;
  final void Function()? onTap;
  const OfficeMenuBtn({Key? key, this.isShowMore = false, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 165.w,
        height: 44.h,
        decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colours.line),
            borderRadius: BorderRadius.all(Radius.circular(44.r))),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                width: 20.w,
                height: 20.w,
                image: ImageUtils.getAssetImage(
                    '${isShowMore ? 'company/office_up' : 'company/office_down'}'),
              ),
              Gaps.hGap4,
              Text(
                ' ${isShowMore ? 'View Less' : 'View More'} ',
                style: TextStyles.textSize12.copyWith(color: Colours.app_main),
              )
            ],
          ),
        ),
      ),
    );
  }
}
