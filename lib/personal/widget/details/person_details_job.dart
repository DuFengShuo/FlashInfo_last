import 'package:flashinfo/company/widget/details/company_details_item_header.dart';
import 'package:flashinfo/personal/model/personal_details_bean.dart';
import 'package:flashinfo/personal/model/works_bean.dart';
import 'package:flashinfo/personal/provider/personal_provider.dart';
import 'package:flashinfo/personal/widget/bottomSheet/personal_details_jobs.dart';
import 'package:flashinfo/widgets/card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class PersonDetailsJob extends StatelessWidget {
  const PersonDetailsJob({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<PersonalProvider>(builder: (_, provider, __) {
      // final PersonalDetailsBean? model = provider.personalDetailsBean;
      // final List<WorksModel> list =
      //     provider.personalDetailsBean?.workExperience?.list ?? [];
      return Visibility(
          visible:true,
          child: Padding(
            padding: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 16.h),
            child: CardWidget(
                radius: 12.r,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: const CompanyDetailsItemHeader(
                        name: 'Jobs',
                        iconName: 0xe664,
                        count:4,
                        onTap: null,
                      ),
                    ),
                    // Padding(
                    //   padding: EdgeInsets.only(
                    //       left: 16.w, right: 16.w, bottom: 12.h),
                    //   child: SizedBox(
                    //       height: 90.h * (list.length > 2 ? 2 : list.length),
                    //       width: double.infinity,
                    //       child: MediaQuery.removePadding(
                    //         context: context,
                    //         removeTop: true,
                    //         child: ListView.builder(
                    //           physics: const NeverScrollableScrollPhysics(),
                    //           itemCount: list.length > 2 ? 2 : list.length,
                    //           itemBuilder: (BuildContext context, int index) {
                    //             return PersonDetailsJobItem(model: list[index]);
                    //           },
                    //         ),
                    //       )),
                    // ),
                  ],
                )),
          ));
    });
  }

  void showBottomBranches(String personnelId, BuildContext context) {
    //用于在底部打开弹框的效果
    showModalBottomSheet<void>(
        context: context,
        builder: (BuildContext context) {
          //构建弹框中的内容
          return PersonalDetailsJobs(personnelId: personnelId);
        });
  }
}
