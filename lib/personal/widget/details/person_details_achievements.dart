// import 'package:flashinfo/company/widget/details/company_details_item_header.dart';
// import 'package:flashinfo/personal/model/honors_bean.dart';
// import 'package:flashinfo/personal/model/personal_details_bean.dart';
// import 'package:flashinfo/personal/provider/personal_provider.dart';
// import 'package:flashinfo/personal/widget/bottomSheet/personal_details_achievements.dart';
// import 'package:flashinfo/widgets/card_widget.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:provider/provider.dart';
//
// class PersonDetailsAchievements extends StatelessWidget {
//   const PersonDetailsAchievements({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Consumer<PersonalProvider>(builder: (_, provider, __) {
//       final PersonalDetailsBean? model = provider.personalDetailsBean;
//       final List<HonorsModel> list =
//           provider.personalDetailsBean?.achievementExperience?.list ?? [];
//       return Visibility(
//           visible: list.isNotEmpty,
//           child: Padding(
//             padding: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 16.h),
//             child: CardWidget(
//                 radius: 12.r,
//                 //padding: EdgeInsets.symmetric(horizontal: Dimens.gap_dp10,vertical: Dimens.gap_v_dp10),
//                 child: Column(
//                   children: [
//                     Padding(
//                       padding: EdgeInsets.symmetric(horizontal: 16.w),
//                       child: CompanyDetailsItemHeader(
//                         name: 'Personal Achievements',
//                         iconName: 0xe667,
//                         count: list.length,
//                         onTap: list.length > 2
//                             ? () => showBottomBranches(
//                                 (model?.id ?? '').toString(), context)
//                             : null,
//                       ),
//                     ),
//                     Padding(
//                       padding: EdgeInsets.only(
//                           left: 16.w, right: 16.w, bottom: 12.h),
//                       child: SizedBox(
//                           height: 71.h * (list.length > 2 ? 2 : list.length),
//                           width: double.infinity,
//                           child: MediaQuery.removePadding(
//                             context: context,
//                             removeTop: true,
//                             child: ListView.builder(
//                               physics: const NeverScrollableScrollPhysics(),
//                               itemCount: list.length > 2 ? 2 : list.length,
//                               itemBuilder: (BuildContext context, int index) {
//                                 return PersonDetailsAchievementsItem(
//                                     model: list[index]);
//                               },
//                             ),
//                           )),
//                     ),
//                   ],
//                 )),
//           ));
//     });
//   }
//
//   void showBottomBranches(String personnelId, BuildContext context) {
//     //用于在底部打开弹框的效果
//     showModalBottomSheet<void>(
//         context: context,
//         builder: (BuildContext context) {
//           //构建弹框中的内容
//           return PersonalDetailsAchievements(personnelId: personnelId);
//         });
//   }
// }
