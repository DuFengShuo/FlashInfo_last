import 'package:flashinfo/company/widget/details/company_details_item_header.dart';
import 'package:flashinfo/personal/model/peoples_new_bean.dart';
import 'package:flashinfo/personal/page/skills/widget/skill_tag_widget.dart';
import 'package:flashinfo/personal/personal_router.dart';
import 'package:flashinfo/personal/provider/personal_provider.dart';
import 'package:flashinfo/res/resources.dart';
import 'package:flashinfo/routers/fluro_navigator.dart';
import 'package:flashinfo/widgets/card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class PersonSkill extends StatefulWidget {
  const PersonSkill({Key? key}) : super(key: key);

  @override
  _PersonSkillState createState() => _PersonSkillState();
}

class _PersonSkillState extends State<PersonSkill> {
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
              // padding: EdgeInsets.symmetric(horizontal: Dimens.gap_dp16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: Dimens.gap_dp16),
                    child: CompanyDetailsItemHeader(
                        isNewIcon: true,
                        iconName: 0xe679,
                        name: 'Skills',
                        count:  model!.skills!.length ,
                        onTap: model.skills!.isEmpty ? null : model.skills!.length>10? () {
                          NavigatorUtils.push(
                              context, PersonalRouter.personalSkillList,arguments: model);
                        }:null

                        ),
                  ),
                  // Gaps.vGap10,
                  Gaps.line,
                  Gaps.vGap16,
                  if (model.skills!.isEmpty)
                    Padding(
                      padding: EdgeInsets.only(
                         left: 16.w, right: 16.w,),
                      child: SizedBox(
                        width: double.infinity,
                        height: 20.h,
                        child: const Text(
                            'There are no skills for this people.'),
                      ),
                    )
                  else
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child:  SkillTagWidget(skill: model.skills,),
                  ),
                  Gaps.vGap15,
                ],
              ),
            )),
      );
    });
  }
}
