import 'package:flashinfo/company/company_rouder.dart';
import 'package:flashinfo/company/models/company_detail_model.dart';
import 'package:flashinfo/company/models/company_subsidiary_model.dart';
import 'package:flashinfo/company/provider/company_provider.dart';
import 'package:flashinfo/res/resources.dart';
import 'package:flashinfo/routers/fluro_navigator.dart';
import 'package:flashinfo/widgets/card_widget.dart';
import 'package:flashinfo/widgets/load_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'company_details_item_header.dart';

class CompanyDetailsMand extends StatelessWidget {
  const CompanyDetailsMand({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<CompanyProvider>(builder: (_, provider, __) {
      final CompanyDetailModel? companyDetailModel =
          provider.companyDetailModel;
      // final SimilarCompanies? similarCompanies =
      //     provider.companySubsidiaryModel?.similarCompanies;
      final List<SimilarCompaniesModel> list =
          provider.companySubsidiaryModel?.similarCompanies?.list ?? [];
      return Visibility(
          visible: list.isNotEmpty,
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Gaps.lineV,
                        Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: Dimens.gap_dp16),
                          child: CompanyDetailsItemHeader(
                            iconName: 0xe673,
                            name: 'Recommands',
                            count: provider.companySubsidiaryModel!.similarCompanies!.total??0,
                            onTap:list.length >= 3
                                ? () => NavigatorUtils.push(context,
                                '${CompanyRouder.companyCommandPage}?companyId=${companyDetailModel?.id}'):null,
                          ),
                        ),
                        NotificationListener<ScrollNotification>(
                          onNotification:
                              (ScrollNotification notification) {
                            //返回值true表示消费掉当前通知不再向上一级NotificationListener传递通知
                            return true;
                          },
                          child: MediaQuery.removePadding(
                              context: context,
                              removeTop: true,
                              child: ListView.builder(
                                padding:  EdgeInsets.only(bottom: 16.h),
                                // scrollDirection: Axis.horvizontal,
                                physics:
                                const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: list.length,
                                itemBuilder:
                                    (BuildContext context, int index) {
                                  return recommandItem(
                                      list[index], context);
                                },
                              )),
                        ),
                      ],
                    ),
                  ))));
    });
  }

  Widget recommandItem(SimilarCompaniesModel model, BuildContext context) {
    return GestureDetector(
      onTap: () => NavigatorUtils.push(
          context, '${CompanyRouder.companyDetailsPage}?companyId=${model.id}'),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colours.border_grey),
            borderRadius: BorderRadius.all(Radius.circular(8.r))),
        margin: EdgeInsets.only(top: 8.h, left: 16.w, right: 16.w),
        padding: EdgeInsets.symmetric(vertical: Dimens.gap_v_dp20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Gaps.hGap16,
                LoadBorderImage(model.logo ?? '',
                    width: 42.w, height: 42.h, holderImg: 'company/company'),
                Gaps.hGap10,
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      model.name ?? '',
                      style: TextStyles.textBold14.copyWith(
                          color: Colours.text, fontWeight: FontWeight.bold),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Gaps.vGap8,
                    Text(
                      model.similarReasons ?? '',
                      style: TextStyles.textGray12.copyWith(height: 1.4.sp),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    )
                  ],
                )),
                Gaps.hGap16,
              ],
            ),
            // Gaps.vGap8,
            // Gaps.line,
            // Padding(
            //   padding: EdgeInsets.symmetric(
            //       horizontal: Dimens.gap_dp16, vertical: Dimens.gap_v_dp5),
            //   child: Text(
            //     model.similarReasons ?? '',
            //     style: TextStyles.textGray10.copyWith(height: 1.4.sp),
            //     maxLines: 3,
            //     overflow: TextOverflow.ellipsis,
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
