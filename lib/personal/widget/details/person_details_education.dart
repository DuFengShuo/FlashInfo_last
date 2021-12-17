// import 'package:flashinfo/company/widget/details/company_details_item_header.dart';
// import 'package:flashinfo/personal/model/educations_bean.dart';
// import 'package:flashinfo/personal/model/personal_details_bean.dart';
// import 'package:flashinfo/personal/provider/personal_provider.dart';
// import 'package:flashinfo/personal/widget/bottomSheet/personal_details_education.dart';
// import 'package:flashinfo/widgets/card_widget.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:provider/provider.dart';
//
// class PersonDetailsEducation extends StatelessWidget {
//   const PersonDetailsEducation({Key? key}) : super(key: key);
//
//   // @override
//   // Widget build(BuildContext context) {
//   //   // return Consumer<PersonalProvider>(builder: (_, provider, __) {
//   //   //   // final PersonalDetailsBean? model = provider.personalDetailsBean;
//   //   //   // final List<EducationsModel> list =
//   //   //   //     provider.personalDetailsBean?.educationExperience?.list ?? [];
//   //   //   // return Visibility(
//   //   //   //     visible: list.isNotEmpty,
//   //   //   //     child: Padding(
//   //   //   //       padding: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 16.h),
//   //   //   //       child: CardWidget(
//   //   //   //           radius: 12.r,
//   //   //   //           child: Column(
//   //   //   //             children: [
//   //   //   //               Padding(
//   //   //   //                 padding: EdgeInsets.symmetric(horizontal: 16.w),
//   //   //   //                 child: CompanyDetailsItemHeader(
//   //   //   //                   name: 'Education Experience',
//   //   //   //                   iconName: 0xe67a,
//   //   //   //                   count: list.length,
//   //   //   //                   onTap: list.length > 2
//   //   //   //                       ? () => showBottomBranches(
//   //   //   //                           (model?.id ?? '').toString(), context)
//   //   //   //                       : null,
//   //   //   //                 ),
//   //   //   //               ),
//   //   //   //               Padding(
//   //   //   //                 padding: EdgeInsets.only(
//   //   //   //                     left: 16.w, right: 16.w, bottom: 12.h),
//   //   //   //                 child: SizedBox(
//   //   //   //                     height: 100.h * (list.length > 2 ? 2 : list.length),
//   //   //   //                     width: double.infinity,
//   //   //   //                     child: MediaQuery.removePadding(
//   //   //   //                       context: context,
//   //   //   //                       removeTop: true,
//   //   //   //                       child: ListView.builder(
//   //   //   //                         physics: const NeverScrollableScrollPhysics(),
//   //   //   //                         itemCount: list.length > 2 ? 2 : list.length,
//   //   //   //                         itemBuilder: (BuildContext context, int index) {
//   //   //   //                           return PersonDetailsEducationItem(
//   //   //   //                               model: list[index]);
//   //   //   //                         },
//   //   //   //                       ),
//   //   //   //                     )),
//   //   //   //               ),
//   //   //   //             ],
//   //   //   //           )),
//   //   //   //     ));
//   //   // });
//   // }
//
//   void showBottomBranches(String personnelId, BuildContext context) {
//     //用于在底部打开弹框的效果
//     showModalBottomSheet<void>(
//         context: context,
//         builder: (BuildContext context) {
//           //构建弹框中的内容
//           return PersonalDetailsDducation(personnelId: personnelId);
//         });
//   }
// }
