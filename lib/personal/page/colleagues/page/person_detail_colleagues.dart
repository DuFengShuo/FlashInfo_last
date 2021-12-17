import 'package:flashinfo/company/widget/details/company_details_item_header.dart';
import 'package:flashinfo/personal/model/peoples_new_bean.dart';
import 'package:flashinfo/personal/page/colleagues/widget/colleague_cell.dart';
import 'package:flashinfo/personal/personal_router.dart';
import 'package:flashinfo/personal/provider/personal_provider.dart';
import 'package:flashinfo/res/resources.dart';
import 'package:flashinfo/routers/fluro_navigator.dart';
import 'package:flashinfo/widgets/card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class PersonColleagues extends StatefulWidget {
  const PersonColleagues({Key? key}) : super(key: key);

  @override
  _PersonColleaguesState createState() => _PersonColleaguesState();
}

class _PersonColleaguesState extends State<PersonColleagues> {
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
              padding: EdgeInsets.symmetric(horizontal: Dimens.gap_dp16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CompanyDetailsItemHeader(
                      isNewIcon: true,
                      iconName: 0xe658,
                      name: 'Colleagues',
                      count: model!.colleagues?.total ?? 0,
                      onTap: model.colleagues?.total != null
                          ? () {
                              NavigatorUtils.push(context,
                                  '${PersonalRouter.personalColleaguesList}?personId=${model.info!.id}');
                            }
                          : null),
                  if (model.colleagues?.list == null)
                    Padding(
                      padding: EdgeInsets.only(bottom: 16.h, top: 10.h),
                      child: SizedBox(
                        width: double.infinity,
                        height: 20.h,
                        child: const Text(
                            'There are no colleagues for this people.'),
                      ),
                    )
                  else
                    Container(
                      color: Colours.material_bg,
                      height: 145.h,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        padding: EdgeInsets.only(
                          bottom: 8.h,
                        ),
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: model.colleagues?.list?.length,
                        itemBuilder: (BuildContext context, int index) {
                          ListModel listModel = model.colleagues!.list![index];
                          return ColleagueCell(
                            listModel: listModel,
                            colleagues: model.colleagues,
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
