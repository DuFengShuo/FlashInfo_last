import 'package:flashinfo/brand/brand_rouder.dart';
import 'package:flashinfo/company/company_rouder.dart';
import 'package:flashinfo/company/widget/details/company_details_item_header.dart';
import 'package:flashinfo/personal/model/peoples_new_bean.dart';
import 'package:flashinfo/personal/page/colleagues/widget/colleague_cell.dart';
import 'package:flashinfo/personal/personal_router.dart';
import 'package:flashinfo/res/colors.dart';
import 'package:flashinfo/res/gaps.dart';
import 'package:flashinfo/res/resources.dart';
import 'package:flashinfo/routers/fluro_navigator.dart';
import 'package:flashinfo/widgets/card_widget.dart';
import 'package:flashinfo/widgets/load_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ColleaguelistCell extends StatelessWidget {
  final  Colleagues? colleagues;
  const ColleaguelistCell({Key? key,this.colleagues}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h, ),
      child: CardWidget(
        radius: 12.r,
        child: Container(
          margin: EdgeInsets.only(bottom: 10.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(12.r)),
            color: Colours.material_bg,
          ),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 18.w),
                child: CompanyDetailsItemHeader(
                    isNewIcon: true,
                    showImage: true,
                    iconName: 0xe64a,
                    name: '${colleagues!.info!.companyName??'-'}',
                    imageName: '${colleagues!.info!.companyLogo??'-'}',
                    count: colleagues!.total,
                    onTap: () {

                      if(colleagues!.info!.entryType==2) {
                        NavigatorUtils.push(
                            context, '${BrandRouder.brandDetailPage}?brandId=${colleagues!.info!.companyId}&&isToIndex=${'true'}');

                      }
                      if( colleagues!.info!.entryType==1){
                        NavigatorUtils.push(
                            context, '${CompanyRouder.companyDetailsPage}?companyId=${colleagues!.info!.companyId}&&isToIndex=${'true'}');
                      }

                    }
                    ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                color: Colours.material_bg,
                height: 140.h,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.h),
                  child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal ,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: colleagues!.list!.length,
                      itemBuilder: (BuildContext context, int index) {
                        ListModel listModel =  colleagues!.list![index];
                        return ColleagueCell(listModel: listModel,colleagues: colleagues,);
                      }),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
