import 'package:flashinfo/brand/models/brand_bean.dart';
import 'package:flashinfo/brand/provider/brand_detail_provider.dart';
import 'package:flashinfo/company/company_rouder.dart';
import 'package:flashinfo/res/resources.dart';
import 'package:flashinfo/routers/fluro_navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class BrandCompanyWidget extends StatelessWidget {
  const BrandCompanyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<BrandProvider>(builder: (_, provider, __) {
      final BrandBean? brandBean = provider.brandBean;
      late String status = '';
      late String companyId = '';
      final List<String> title = [
        'Legal Name',
        'Identification Number',
        'Incorporation Date',
        'Operating Status'
      ];
      final List<String> content = [];
      if (brandBean!.summary!.companyList!.companyList!.isEmpty) {
        content.add('');
        content.add('');
        content.add('');
        content.add('');
      } else {
        final Company? company =
            brandBean.summary!.companyList!.companyList![0];
        final Company cm = brandBean.summary!.companyList!.companyList![0];
        status = cm.operatingStatus!;
        content.add(company!.legalName ?? '');
        content.add(company.identificationNumber ?? '');
        content.add(company.incorporationDate ?? '');
        content.add(company.operatingStatus ?? '');
        companyId = company.id!;
      }

      return Padding(
        padding:
            EdgeInsets.only(left: 16.w, right: 16.w, top: 12.h, bottom: 10.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Company',
              style:
                  TextStyles.textBold14.copyWith(fontWeight: FontWeight.bold),
            ),
            //  Gaps.vGap24,
            ListView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.only(top: 24.h),
                physics: const NeverScrollableScrollPhysics(),
                itemCount: title.length,
                itemBuilder: (BuildContext context, int index) {
                  if (index == title.length - 1) {
                    return Padding(
                      padding: EdgeInsets.only(bottom: 24.h),
                      child: Row(
                        children: [
                          Text(
                            '${title[index]}',
                            style: TextStyles.textGray12,
                          ),
                          const Spacer(),
                          GestureDetector(
                              onTap: () {
                                // print('点了');
                                // if (index == 0) {
                                //   print('点了');
                                //   if (content[index].isNotEmpty) {
                                //     print('点了');
                                //     //跳转到公司详情
                                //     NavigatorUtils.push(context,
                                //         '${CompanyRouder.companyDetailsPage}?companyId=${brandBean.info?.id ?? ''}');
                                //   }
                                // }
                              },
                              child: Row(
                                children: [
                                  Visibility(
                                    child: Container(
                                      width: 6.w,
                                      height: 6.w,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(6.r)),
                                          color:
                                              status.toLowerCase() == 'active'
                                                  ? Colours.text_043
                                                  : (status.toLowerCase() ==
                                                          'inactive'
                                                      ? Colours.red
                                                      : Colours.text)),
                                    ),
                                    visible: status.isNotEmpty,
                                  ),
                                  Gaps.hGap4,
                                  Text(
                                    '${content[index].isEmpty ? '-' : content[index]}',
                                    style: index == 0
                                        ? TextStyles.textSize12.copyWith(
                                            color: Colours.app_main,
                                            fontWeight: FontWeight.bold)
                                        : TextStyles.textGray12,
                                  ),
                                ],
                              ))
                        ],
                      ),
                    );
                  } else {
                    return Padding(
                      padding: EdgeInsets.only(bottom: 24.h),
                      child: Row(
                        children: [
                          Text(
                            '${title[index]}',
                            style: TextStyles.textGray12,
                          ),
                          const Spacer(),
                          GestureDetector(
                            onTap: () {
                              if (index == 0) {
                                if (content[index].isNotEmpty) {
                                  print('点了');
                                  //跳转到公司详情
                                  NavigatorUtils.push(context,
                                      '${CompanyRouder.companyDetailsPage}?companyId=$companyId');
                                }
                              }
                            },
                            child: Text(
                              '${content[index].isEmpty ? '-' : content[index]}',
                              style: index == 0
                                  ? TextStyles.textSize12.copyWith(
                                      color: Colours.app_main,
                                      fontWeight: FontWeight.bold)
                                  : TextStyles.textGray12,
                            ),
                          )
                        ],
                      ),
                    );
                  }
                }),
            // Text(
            //   'Address',
            //   overflow: TextOverflow.ellipsis,
            //   style: TextStyles.textGray12,
            // ),
            // Gaps.vGap8,
            // Text(
            //   '${content.last}',
            //   overflow: TextOverflow.ellipsis,
            //   style: TextStyles.textSize12,
            //   maxLines: 1,
            // ),
            // Gaps.vGap20,
          ],
        ),
      );
    });
  }
}
