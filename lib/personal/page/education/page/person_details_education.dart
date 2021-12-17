import 'package:flashinfo/company/widget/details/company_details_item_header.dart';
import 'package:flashinfo/personal/model/peoples_new_bean.dart';
import 'package:flashinfo/personal/page/education/widget/education_cell.dart';
import 'package:flashinfo/personal/page/experience/widget/experience_cell.dart';
import 'package:flashinfo/personal/personal_router.dart';
import 'package:flashinfo/personal/provider/personal_provider.dart';
import 'package:flashinfo/res/resources.dart';
import 'package:flashinfo/routers/fluro_navigator.dart';
import 'package:flashinfo/widgets/card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class PersonalEducation extends StatelessWidget {
  const PersonalEducation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<PersonalProvider>(builder: (_, provider, __) {
      final PeoplesNewBean? model = provider.personalDetailsBean;
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
              //  padding: EdgeInsets.symmetric(horizontal: Dimens.gap_dp16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: Dimens.gap_dp16),
                    child: CompanyDetailsItemHeader(
                        isNewIcon: true,
                        iconName: 0xe676,
                        name: 'Education',
                        count: model!.education!.isNotEmpty
                            ? model.education!.length
                            : 0,
                        onTap: model.education!.isEmpty
                            ? null
                            : model.education!.length>3? () {
                                NavigatorUtils.push(context,
                                    PersonalRouter.personalEducationsList,arguments: model);
                              }:null),
                  ),
                  Gaps.line,
                  Gaps.vGap8,
                  if (model.education!.isEmpty)
                    Padding(
                      padding: EdgeInsets.only(
                          bottom: 16.h, left: 16.w, right: 16.w, top: 10.h),
                      child: SizedBox(
                        width: double.infinity,
                        height: 20.h,
                        child: const Text(
                            'There are no education for this people.'),
                      ),
                    )
                  else
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: Dimens.gap_dp1),
                      child: ListView.builder(
                        padding: EdgeInsets.only(
                          bottom: 8.h,
                        ),
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: model.education!.length > 3
                            ? 3
                            : model.education!.length,
                        itemBuilder: (BuildContext context, int index) {
                          final Education models = model.education![index];
                          int dataLeng =0 ;
                          if(model.education!.length>3){
                            dataLeng=3;
                          }
                          if(model.education!.length==2){
                            dataLeng=2;
                          }
                          if(model.education!.length==1){
                            dataLeng=1;
                          }
                          return EducationCell(
                            isShowLine: index != dataLeng-1,
                            education: models,
                          );
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
