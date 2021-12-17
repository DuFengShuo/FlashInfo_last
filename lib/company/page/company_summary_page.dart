import 'package:flashinfo/company/models/company_details_bean.dart';
import 'package:flashinfo/company/widget/details/company_details_item_header.dart';
import 'package:flashinfo/res/colors.dart';
import 'package:flashinfo/res/resources.dart';
import 'package:flashinfo/routers/fluro_navigator.dart';
import 'package:flashinfo/util/other_utils.dart';
import 'package:flashinfo/widgets/card_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flashinfo/util/screen_utils.dart';

class CompanyDetailsSummaryPage extends StatelessWidget {
  final RegistrationInfo? registrationInfo;
  final IndustryClassification? industryClassification;
  const CompanyDetailsSummaryPage(
      {Key? key,
      required this.registrationInfo,
      required this.industryClassification})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<String> title = [
      'Identification Number',
      'Founded Year',
      'Previous Name',
      'Operation Status',
      'Nonprofit',
      'Company Type',
      'Jurisdiction',
      'Branch',
      'Phone Number',
      'Email Number',
      'Website',
      'Address',
    ];
    final List<String> datas = [];
    datas.add((registrationInfo?.identificationNumber ?? '').isEmpty
        ? '-'
        : (registrationInfo?.identificationNumber ?? ''));
    datas.add((registrationInfo?.incorporationDate ?? '-').isEmpty
        ? '-'
        : (registrationInfo?.incorporationDate ?? ''));
    datas.add(registrationInfo?.previousName?.join(',').toString() ?? '-');
    datas.add((registrationInfo?.operationStatus ?? '').isEmpty
        ? '-'
        : (registrationInfo?.operationStatus ?? ''));
    datas.add((registrationInfo?.nonprofit ?? '').isEmpty
        ? '-'
        : (registrationInfo?.nonprofit ?? ''));
    datas.add((registrationInfo?.companyType ?? '').isEmpty
        ? '-'
        : (registrationInfo?.companyType ?? ''));
    datas.add((registrationInfo?.jurisdiction ?? '').isEmpty
        ? '-'
        : (registrationInfo?.jurisdiction ?? ''));
    datas.add(registrationInfo?.branch?.nums != 0 &&
            registrationInfo?.branch?.nums != null
        ? '${registrationInfo?.branch?.nums.toString()} Branches in ${registrationInfo?.branch?.country}'
        : '-');
    datas.add((registrationInfo?.phoneNumber ?? '').isEmpty
        ? '-'
        : (registrationInfo?.phoneNumber ?? ''));
    datas.add((registrationInfo?.email ?? '').isEmpty
        ? '-'
        : (registrationInfo?.email ?? ''));
    datas.add((registrationInfo?.website ?? '').isEmpty
        ? '-'
        : (registrationInfo?.website ?? ''));
    datas.add((registrationInfo?.address ?? '').isEmpty
        ? '-'
        : (registrationInfo?.address ?? ''));
    final List<String> classTitle = [
      'Offical Industry',
      'SIC Code',
      'NAICS Code',
    ];
    final List<String> classDatas = [];
    classDatas.add((industryClassification?.officalIndustry ?? '-').isEmpty
        ? '-'
        : (industryClassification?.officalIndustry ?? '-'));
    classDatas
        .add(industryClassification?.sicCode?.join(',').toString() ?? '-');
    classDatas
        .add(industryClassification?.naicsCode?.join(',').toString() ?? '-');

    return Padding(
      padding: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 8.h, top: 16.h),
      child: CardWidget(
          radius: 12.0.r,
          child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(12.r)),
                color: Colours.material_bg,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: Dimens.gap_dp16),
                    child: const CompanyDetailsItemHeader(
                      name: 'Summary',
                      iconName: 0xe672,
                    ),
                  ),
                  Gaps.line,
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: Dimens.gap_dp16),
                    child: const CompanyDetailsItemHeader(
                      name: 'Registration Info',
                    ),
                  ),
                  ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: title.length,
                      padding: EdgeInsets.only(bottom: 0.h),
                      itemBuilder: (BuildContext context, int index) {
                        if (index == title.length - 1) {
                          return SummaryTwoRow(
                            title: title[index],
                            content: datas[index],
                          );
                        } else {
                          return SummaryDefaultRow(
                            title: title[index],
                            content: datas[index],
                            index: index,
                          );
                        }
                      }),
                  Gaps.vGap4,
                  Gaps.line,
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: Dimens.gap_dp16),
                    child: const CompanyDetailsItemHeader(
                      name: 'Industry Classification',
                    ),
                  ),
                  ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: classTitle.length,
                      padding: EdgeInsets.only(bottom: 0.h),
                      itemBuilder: (BuildContext context, int index) {
                        if (index == 0) {
                          return SummaryTwoRow(
                            title: classTitle[index],
                            content: classDatas[index],
                          );
                        } else {
                          return SummaryDefaultRow(
                            title: classTitle[index],
                            content: classDatas[index],
                            index: index,
                          );
                        }
                      }),
                ],
              ))),
    );
  }
}

class SummaryDefaultRow extends StatelessWidget {
  final String? title;
  final String? content;
  final int index;
  const SummaryDefaultRow(
      {Key? key, this.title, this.content, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$title',
            style: TextStyles.textGray12,
            overflow: TextOverflow.ellipsis,
          ),
          Gaps.hGap20,
          Expanded(
              child: Row(
            children: [
              const Spacer(),
              Visibility(
                visible: index == 3 && content!.isNotEmpty && content != '-',
                child: Container(
                  margin: EdgeInsets.only(right: Dimens.gap_dp5),
                  decoration: BoxDecoration(
                    color: content!.toLowerCase() == 'inactive'
                        ? Colours.red
                        : (content!.toLowerCase() == 'active'
                            ? Colours.app_main
                            : Colours.text),
                    shape: BoxShape.circle,
                  ),
                  width: 6.w,
                  height: 6.h,
                ),
              ),
              GestureDetector(
                onTap: () {
                  if (content!.isEmpty) {
                    return;
                  }
                  if (content.toString().trim() == '-') {
                    return;
                  }
                  if (index == 8) {
                    Utils.launchTelURL('$content');
                  }
                  if (index == 10) {
                    NavigatorUtils.goWebViewPage(context, '', '$content');
                  }
                },
                child: Container(
                  constraints: BoxConstraints(maxWidth: context.width - 210.w),
                  child: Text(
                    '${content!.isEmpty ? '-' : content}',
                    style: index == 8 || index == 10
                        ? TextStyles.textBold12.copyWith(
                            color: Colours.app_main,
                          )
                        : TextStyles.textSize12,
                    textAlign: TextAlign.end,
                  ),
                ),
              ),
            ],
          )),
        ],
      ),
    );
  }
}

class SummaryTwoRow extends StatelessWidget {
  final String? title;
  final String? content;
  const SummaryTwoRow({Key? key, this.title, this.content}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$title',
            style: TextStyles.textGray12,
            overflow: TextOverflow.ellipsis,
          ),
          Gaps.vGap8,
          Text(
            '$content',
            style: TextStyles.textSize12,
            textAlign: TextAlign.start,
          ),
        ],
      ),
    );
  }
}
