import 'package:flashinfo/company/widget/details/company_details_item_header.dart';
import 'package:flashinfo/personal/model/peoples_new_bean.dart';
import 'package:flashinfo/personal/page/experience/widget/experience_cell.dart';
import 'package:flashinfo/personal/page/licenses/widget/person_licenses_cell.dart';
import 'package:flashinfo/personal/personal_router.dart';
import 'package:flashinfo/personal/provider/personal_provider.dart';
import 'package:flashinfo/res/resources.dart';
import 'package:flashinfo/routers/fluro_navigator.dart';
import 'package:flashinfo/widgets/card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class PersonalLicenses extends StatelessWidget {
  const PersonalLicenses({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
      Consumer<PersonalProvider>(builder: (_, provider, __) {
        final PeoplesNewBean? model = provider.personalDetailsBean;
        return       Padding(
          padding: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 8.h, top: 8.h),
          child: CardWidget(
              radius: 12.0.r,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(12.r)),
                  color: Colours.material_bg,
                ),
                // padding: EdgeInsets.symmetric(horizontal: Dimens.gap_dp16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:  EdgeInsets.symmetric(horizontal: 16.w),
                      child: CompanyDetailsItemHeader(
                          isNewIcon: true,
                          iconName: 0xe675,
                          name: 'Licenses & Certifications',
                          count: model!.honors!.isNotEmpty? model.honors!.length :0,
                          onTap:  model.honors!.isNotEmpty && model.honors!.length>3?(){
                            NavigatorUtils.push(context, PersonalRouter.personallicensesList,arguments: model);
                          }:null
                          // count: 33,
                          // onTap: (){
                          //   NavigatorUtils.push(context, PersonalRouter.personallicensesList);
                          // }
                          ),
                    ),
                    Gaps.line,
                    Gaps.vGap8,
                    if (model.honors!.isEmpty)
                      Padding(
                        padding: EdgeInsets.only(bottom: 16.h,left: 16.w,right: 16.w,top: 10.h),
                        child: SizedBox(
                          width: double.infinity,
                          height: 20.h,
                          child: const Text('There are no licenses or certifications for this people.'),
                        ),
                      )
                    else
                    Padding(
                      padding:  EdgeInsets.symmetric(horizontal: 1.w),
                      child: ListView.builder(
                        padding: EdgeInsets.only(
                          bottom: 8.h,
                        ),
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: model.honors!.length>3?3: model.honors!.length,
                        itemBuilder: (BuildContext context, int index) {
                          int dataLeng =0 ;
                          if(model.honors!.length>3){
                            dataLeng=3;
                          }
                          if(model.honors!.length==2){
                            dataLeng=2;
                          }
                          if(model.honors!.length==1){
                            dataLeng=1;
                          }
                           final Honors models = model.honors![index];
                          return  LicensesCell(isShowLine:  index!=dataLeng-1,honors: models,);
                        },
                      ),
                    )
                  ],
                ),
              )),
        );
      });


  }
}
