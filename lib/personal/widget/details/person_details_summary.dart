import 'package:flashinfo/brand/brand_rouder.dart';
import 'package:flashinfo/company/company_rouder.dart';
import 'package:flashinfo/company/widget/details/company_details_item_header.dart';
import 'package:flashinfo/personal/model/peoples_new_bean.dart';
import 'package:flashinfo/personal/provider/personal_provider.dart';
import 'package:flashinfo/res/colors.dart';
import 'package:flashinfo/res/resources.dart';
import 'package:flashinfo/routers/fluro_navigator.dart';
import 'package:flashinfo/widgets/card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class PersonalSummaryWidget extends StatelessWidget {
  const PersonalSummaryWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<PersonalProvider>(builder: (_, provider, __) {
      final PeoplesNewBean? model = provider.personalDetailsBean;
      return Padding(
          padding: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 8.h),
          child: CardWidget(
              radius: 12.0.r,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(12.r)),
                  color: Colours.material_bg,
                ),
                margin: EdgeInsets.only(bottom: 12.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: const CompanyDetailsItemHeader(
                        isNewIcon: true,
                        iconName: 0xe651,
                        name: 'Summary',
                        fontSize: 16,
                      ),
                    ),
                    Gaps.line,
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: const CompanyDetailsItemHeader(name: 'Overview'),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 16.w, vertical: 10.h),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Recent Experience',
                            style: TextStyles.textGray12,
                          ),
                          Gaps.hGap10,
                         const Spacer(),
                         GestureDetector(
                            onTap: () {
                              if(model?.summary?.overview?.recentExperience?.entityType=='2') {
                                NavigatorUtils.push(
                                    context, '${BrandRouder.brandDetailPage}?brandId=${model?.summary?.overview?.recentExperience?.companyId}&&isToIndex=${'true'}');

                              }
                              if(model?.summary?.overview?.recentExperience?.entityType=='1'){
                                NavigatorUtils.push(
                                    context, '${CompanyRouder.companyDetailsPage}?companyId=${model?.summary?.overview?.recentExperience?.companyId}&&isToIndex=${'true'}');
                              }


                              // NavigatorUtils.push(context,
                              //     '${CompanyRouder.companyDetailsPage}?companyId=${model?.summary?.overview?.recentExperience?.companyId}');
                            },
                            child: Text(
                              '${model?.summary?.overview?.recentExperience?.companyName ?? '-'}',

                              style: TextStyles.textBold12
                                  .copyWith(color: Colours.app_main),
                              textAlign: TextAlign.end,
                              // overflow: TextOverflow.ellipsis,
                              // maxLines: 1,
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 16.w, vertical: 10.h),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Recent Education',
                            style: TextStyles.textGray12,
                          ),
                          Gaps.hGap10,
                          Expanded(
                              child: Text(
                            '${model?.summary?.overview?.recentEducation?.eduName ?? '-'}',
                            style: TextStyles.textSize12,
                            textAlign: TextAlign.end,
                            // overflow: TextOverflow.ellipsis,
                            // maxLines: 1,
                          ))
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 16.w, vertical: 10.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Location',
                            style: TextStyles.textGray12,
                          ),
                          Gaps.vGap8,
                          Text(
                            '${model!.summary!.overview!.location!.isEmpty ? '-' : model.summary?.overview?.location}',
                            style: TextStyles.textSize12,
                            textAlign: TextAlign.end,
                            // overflow: TextOverflow.ellipsis,
                            // maxLines: 1,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              )));
    });
  }
}
