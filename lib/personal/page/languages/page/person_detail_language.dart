import 'package:flashinfo/company/widget/details/company_details_item_header.dart';
import 'package:flashinfo/personal/model/peoples_new_bean.dart';
import 'package:flashinfo/personal/model/personal_details_bean.dart';
import 'package:flashinfo/personal/provider/personal_provider.dart';
import 'package:flashinfo/res/resources.dart';
import 'package:flashinfo/widgets/card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class PersonDetailLanguage extends StatefulWidget {
  const PersonDetailLanguage({Key? key}) : super(key: key);

  @override
  _PersonDetailLanguageState createState() => _PersonDetailLanguageState();
}

class _PersonDetailLanguageState extends State<PersonDetailLanguage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<PersonalProvider>(builder: (_, provider, __) {
      final PeoplesNewBean? model = provider.personalDetailsBean;

      late String launString = '';
      for(int i = 0 ; i<model!.languages!.length; i++){
        String ee = '';
        final String languages =model.languages![i];
        ee = '$languages ${i==model.languages!.length-1?'':' · '} ';
        launString+=ee;
      }
      return Padding(
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
                    padding: EdgeInsets.symmetric(horizontal: Dimens.gap_dp16),
                    child: const CompanyDetailsItemHeader(
                      isNewIcon: true,
                      iconName: 0xe678,
                      name: 'Languages',
                    ),
                  ),

                  Gaps.line,
                  if (launString.isEmpty)
                    Padding(
                      padding:    EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                      child: SizedBox(
                        width: double.infinity,
                        height: 20.h,
                        child: const Text('There are no languages for this people.'),
                      ),
                    )
                  else
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                    child:                           Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.w),
                      child: Text(
                        '$launString',
                        // maxLines: 3,
                        // overflow: TextOverflow.ellipsis,
                        style: TextStyles.textBold14
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  //   Gaps.vGap10,
                ],
              ),
            )),
      );
    });
  }
}
