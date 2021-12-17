import 'package:flashinfo/brand/models/brand_bean.dart';
import 'package:flashinfo/company/company_rouder.dart';
import 'package:flashinfo/personal/model/person_work_bean.dart';
import 'package:flashinfo/res/resources.dart';
import 'package:flashinfo/routers/fluro_navigator.dart';
import 'package:flashinfo/util/device_utils.dart';
import 'package:flashinfo/util/image_utils.dart';
import 'package:flashinfo/util/other_utils.dart';
import 'package:flashinfo/util/screen_utils.dart';
import 'package:flashinfo/widgets/icon_font.dart';
import 'package:flashinfo/widgets/load_image.dart';
import 'package:flashinfo/widgets/my_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PersonalInfoToastWidget extends StatelessWidget {
  final String? avatarUrl;
  final String? name;
  final String? desc;
  final String? startDate;
  final String? endDate;
  final String? detailId;
  final int? year;
  final bool? isHonors;
  const PersonalInfoToastWidget({
    Key? key,
    this.avatarUrl,
    this.name,
    this.desc,
    this.startDate,
    this.endDate,
    this.detailId,
    this.year,
    this.isHonors,
  }) : super(key: key);

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
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
                child: Row(
                   crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    LoadBorderImage(
                      '$avatarUrl',
                      width: 42.w,
                      height: 42.w,
                      holderImg: '${isHonors==true?'personnel/person_license':'personnel/person_education'}',
                      radius: 8.r,
                    ),
                    Gaps.hGap10,
                    Expanded(
                      child: Padding(
                        padding:  EdgeInsets.only(top: 0.w),
                        child: Text(
                          '${name!.isNotEmpty?name:'-'}',
                          style: TextStyles.textBold18.copyWith(
                              color: Colours.text, fontWeight: FontWeight.bold),
                          // maxLines: 2,
                          // overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),


                    // Visibility(
                    //     visible: isHonors ==null,
                    //     child:    const IconFont(
                    //       name: 0xe612,
                    //       size: 12,
                    //       color: Colours.text_gray_c,
                    //     )
                    // )

                    // Gaps.vGap8
                  ],
                ),
              ),
              onTap: () {
                // if(isHonors !=null && isHonors == true){
                //
                // } else {
                //   Navigator.pop(context);
                //   NavigatorUtils.push(context,
                //       '${CompanyRouder.companyDetailsPage}?companyId=$detailId');
                // }

              },
            ),

            Visibility(
              visible: desc!.isNotEmpty,
              child:    Padding(
                padding:  EdgeInsets.only(top: 16.h,bottom: 8.h),
                child: Text(
                '$desc',
                style: TextStyles.textSize12.copyWith(height: 1.4.sp),
                // maxLines: 1,
                // overflow: TextOverflow.ellipsis,
            ),
              ),),
         Gaps.vGap8,

            if (year != null)
              Visibility(
                child: Text(
                  '$year',
                  style: TextStyles.textGray12.copyWith(height: 1.4.sp),
                  // maxLines: 1,
                  // overflow: TextOverflow.ellipsis,
                ),
                visible: year!=0,
              )
            else
              Visibility(
                child: Text(
                  '$startDate ~ $endDate',
                  style: TextStyles.textGray12.copyWith(height: 1.4.sp),
                  // maxLines: 1,
                  // overflow: TextOverflow.ellipsis,
                ),
                visible: startDate!.isNotEmpty && endDate!.isNotEmpty,
              ),
            // Visibility(
            //   child: Padding(
            //       padding: EdgeInsets.only(
            //           top: 8.h, right: 10),
            //       child: Container(
            //         child: Text(
            //           '$desc',
            //           style: TextStyles.textGray12
            //               .copyWith(height: 1.4.sp),
            //           maxLines: 2,
            //           overflow: TextOverflow.ellipsis,
            //         ),
            //         constraints: BoxConstraints(
            //             maxWidth: 200.w),
            //       )),
            //   visible: desc!.isNotEmpty
            // ),

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
