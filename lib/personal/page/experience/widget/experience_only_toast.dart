import 'package:flashinfo/brand/brand_rouder.dart';
import 'package:flashinfo/company/company_rouder.dart';
import 'package:flashinfo/res/resources.dart';
import 'package:flashinfo/routers/fluro_navigator.dart';
import 'package:flashinfo/widgets/icon_font.dart';
import 'package:flashinfo/widgets/load_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ExOnlyToastWidget extends StatelessWidget {
  final String? avatarUrl;
  final String? name;
  final String? desc;
  final String? startDate;
  final String? endDate;
  final String? detailId;
  final String? year;
  final bool? isHonors;
  final String? address;
  final int? entityType;
  const ExOnlyToastWidget(
      {Key? key,
      this.avatarUrl,
      this.name,
      this.desc,
      this.startDate,
      this.endDate,
      this.detailId,
      this.year,
      this.isHonors,
      this.address, this.entityType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final List<String> allLinksArray = getAllLinks(info);
    return Container(
        // height: 220.h ,
        margin: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
        padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.0.r),
        ),
        child: ListView(
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          children: [
            GestureDetector(
              child: Container(
                  decoration: BoxDecoration(
                      color: Colours.material_bg,
                      border: Border.all(width: 1, color: Colours.border_grey),
                      borderRadius: BorderRadius.all(Radius.circular(8.r))),
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 10.h),
                  child: Row(
                    children: [
                      Expanded(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            LoadBorderImage(
                              '$avatarUrl',
                              width: 42.w,
                              height: 42.w,
                              holderImg: 'personnel/person_experience',
                              radius: 8.r,
                            ),
                            Gaps.hGap10,
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${name!.isNotEmpty?name:'-'}',
                                    style: TextStyles.textBold18.copyWith(
                                        color: Colours.text,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Visibility(
                                      visible: address!.isNotEmpty,
                                      child: Padding(
                                        padding: EdgeInsets.only(top: 8.h),
                                        child: Text('$address',
                                            style: TextStyles.textGray12.copyWith(height: 1.4)
                                            // maxLines: 2,
                                            // overflow: TextOverflow.ellipsis,
                                            ),
                                      ))
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const IconFont(
                        name: 0xe612,
                        size: 12,
                        color: Colours.text_gray_c,
                      )
                    ],
                  )),
              onTap: () {
                Navigator.pop(context);

                if(entityType==2) {
                  NavigatorUtils.push(
                      context, '${BrandRouder.brandDetailPage}?brandId=${detailId ??'' }&&isToIndex=${'true'}');

                }
                if(entityType==1){

                  NavigatorUtils.push(context,
                      '${CompanyRouder.companyDetailsPage}?companyId=${detailId??'' }&&isToIndex=${'true'}');
                }
                // NavigatorUtils.push(context,
                //     '${CompanyRouder.companyDetailsPage}?companyId=$detailId');
              },
            ),
            Gaps.vGap16,
            Row(
              children: [
                Visibility(
                  child: Text(
                    '$startDate ~ $endDate',
                    style: TextStyles.textGray12
                        .copyWith(height: 1.4.sp),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  visible:
                  startDate!.isNotEmpty &&
                      endDate!.isNotEmpty,
                ),
                Gaps.hGap12,
                Visibility(
                  child: Text(
                    '$year',
                    style: TextStyles.textGray12
                        .copyWith(height: 1.4.sp),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  visible:
                 year!.isNotEmpty,
                ),
              ],
            ),
            Gaps.vGap8,
            Text(
              '$desc',
              style: TextStyles.textGray12.copyWith(height: 1.4.sp),
              // maxLines: 1,
              // overflow: TextOverflow.ellipsis,
            ),
            Gaps.vGap24,
            GestureDetector(
              onTap: () {
                NavigatorUtils.goBack(context);
              },
              child: Container(
                alignment: Alignment.center,
                height: 44.h,
                // width: Screen.width(context),
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colours.border_grey),
                    borderRadius: BorderRadius.all(Radius.circular(44.h))),
                child: Text(
                  'Cancel',
                  style: TextStyles.text,
                ),
              ),
            )
          ],
        ));
  }
}
