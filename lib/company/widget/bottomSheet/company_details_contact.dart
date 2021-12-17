// import 'package:flashinfo/company/iview/company_detail_iview.dart';
// import 'package:flashinfo/company/models/company_contact_model.dart';
// import 'package:flashinfo/company/models/company_detail_model.dart';
// import 'package:flashinfo/company/models/company_bean.dart';
// import 'package:flashinfo/company/presenter/company_detial_presenter.dart';
// import 'package:flashinfo/company/provider/company_provider.dart';
// import 'package:flashinfo/mvp/base_page.dart';
// import 'package:flashinfo/mvp/power_presenter.dart';
// import 'package:flashinfo/personal/model/peoples_bean.dart';
// import 'package:flashinfo/provider/base_list_provider.dart';
// import 'package:flashinfo/res/resources.dart';
// import 'package:flashinfo/routers/fluro_navigator.dart';
// import 'package:flashinfo/util/other_utils.dart';
// import 'package:flashinfo/widgets/base_bottom_sheet.dart';
// import 'package:flashinfo/widgets/icon_font.dart';
// import 'package:flashinfo/widgets/load_image.dart';
// import 'package:flashinfo/widgets/my_button.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:provider/provider.dart';

// class CompanyDetailsContact extends StatefulWidget {
//   const CompanyDetailsContact(
//       {Key? key, this.companyDetailModel, required this.companyId})
//       : super(key: key);
//   final CompanyDetailModel? companyDetailModel;
//   final String? companyId;

//   @override
//   _CompanyDetailsContactState createState() => _CompanyDetailsContactState();
// }

// class _CompanyDetailsContactState extends State<CompanyDetailsContact>
//     with BasePageMixin<CompanyDetailsContact, PowerPresenter>
//     implements CompanyDetialIMvpView {
//   @override
//   CompanyProvider companyProvider = CompanyProvider();
//   @override
//   BaseListProvider<CompanyModel> companyListProvider =
//       BaseListProvider<CompanyModel>();
//   @override
//   BaseListProvider<PeoplesModel> peopleContactProvider =
//       BaseListProvider<PeoplesModel>();
//   late CompanyDetailPresenter _companyDetailPresenter;

//   @override
//   PowerPresenter createPresenter() {
//     final PowerPresenter powerPresenter = PowerPresenter<dynamic>(this);
//     _companyDetailPresenter = CompanyDetailPresenter();
//     _companyDetailPresenter.companyId = widget.companyId ?? '';
//     powerPresenter.requestPresenter([_companyDetailPresenter]);
//     return powerPresenter;
//   }

//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance!.addPostFrameCallback(
//       (_) async {
//         _companyDetailPresenter.getCompanyContact();
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider<CompanyProvider>(
//         create: (_) => companyProvider,
//         child: Consumer<CompanyProvider>(builder: (_, provider, __) {
//           return BaseBottomSheet(
//              height: 350.h,
//             children: [
//               Text(
//                 'Company',
//                 style: TextStyles.textBold18,
//               ),
//               Gaps.vGap10,
//               if (provider.companyContactModel == null)
//                 Expanded(
//                     child: Center(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       const LoadAssetImage(
//                         'state/company',
//                         width: 120,
//                       ),
//                       Gaps.vGap10,
//                       Text(
//                         'No data',
//                         style: Theme.of(context).textTheme.subtitle2,
//                       )
//                     ],
//                   ),
//                 ))
//               else
//                 Column(
//                   children: [
//                     Gaps.vGap24,
//                     GestureDetector(
//                         onTap: () {
//                           Utils.launchTelURL('${provider.companyContactModel?.mobile}');
//                         },
//                         child: Column(
//                           children:
//                               itemMobile(provider.companyContactModel?.mobile),
//                         )),
//                     Gaps.vGap24,
//                     Column(
//                       children: itemEmail(provider.companyContactModel?.email),
//                     ),
//                   ],
//                 ),
//               Gaps.vGap10,
//               const Spacer(),
//               MyButton(
//                 onPressed: () => NavigatorUtils.goBack(context),
//                 text: 'OK',
//                 minHeight: 44.h,
//                 backgroundColor: Colours.app_main,
//                 textColor: Colours.material_bg,
//                 radius: 40.r,
//               )
//             ],
//           );
//         }));
//   }

//   List<Widget> itemEmail(List<Email>? mobileArr) {
//     final List<Widget> array = [];
//     if ((mobileArr ?? []).isEmpty) {
//       return array;
//     }
//     mobileArr?.forEach((Email item) {
//       array.add(
//         Row(
//           children: [
//             Gaps.hGap10,
//             Text(item.email ?? '', style: TextStyles.textSize14),
//             const Spacer(),
//             Container(
//               height: 44.w,
//               width: 44.w,
//               decoration: BoxDecoration(
//                   color: Colours.app_main,
//                   borderRadius: BorderRadius.all(Radius.circular(44.r))),
//               child: const IconFont(
//                 name: 0xe62a,
//                 color: Colours.material_bg,
//                 size: 14,
//               ),
//             ),
//             Gaps.hGap10,
//           ],
//         ),
//       );
//     });
//     return array;
//   }

//   List<Widget> itemMobile(List<Mobile>? mobileArr) {
//     final List<Widget> array = [];
//     if ((mobileArr ?? []).isEmpty) {
//       return array;
//     }
//     mobileArr?.forEach((Mobile item) {
//       array.add(
//         Row(
//           children: [
//             Gaps.hGap10,
//             Text(
//               item.mobile ?? '',
//               style: TextStyles.textSize14.copyWith(color: Colours.app_main),
//             ),
//             const Spacer(),
//             // Text(widget.companyDetailModel?.name ?? '',
//             //     style: TextStyles.textSize14),
//             // Gaps.hGap5,
//             // Gaps.hGap5,
//             Container(
//               height: 44.w,
//               width: 44.w,
//               decoration: BoxDecoration(
//                   color: Colours.app_main,
//                   borderRadius: BorderRadius.all(Radius.circular(44.r))),
//               child: const IconFont(
//                 name: 0xe625,
//                 color: Colours.material_bg,
//                 size: 20,
//               ),
//             ),

//             Gaps.hGap10,
//           ],
//         ),
//       );
//     });
//     return array;
//   }
// }

import 'package:flashinfo/company/models/company_details_bean.dart';
import 'package:flashinfo/provider/common_provider.dart';
import 'package:flashinfo/res/resources.dart';
import 'package:flashinfo/routers/fluro_navigator.dart';
import 'package:flashinfo/util/other_utils.dart';
import 'package:flashinfo/widgets/base_bottom_sheet.dart';
import 'package:flashinfo/widgets/load_image.dart';
import 'package:flashinfo/widgets/my_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class CompanyDetailsContact extends StatefulWidget {
  const CompanyDetailsContact({Key? key, required this.registrationInfo})
      : super(key: key);
  final RegistrationInfo? registrationInfo;
  @override
  _CompanyDetailsContactState createState() => _CompanyDetailsContactState();
}

class _CompanyDetailsContactState extends State<CompanyDetailsContact> {
  final List<Widget> arr = [];
  @override
  void initState() {
    super.initState();

    arr.clear();
    if (context.read<CommonProvider>().initializeModel?.icon?.details != null) {
      final Map<String, String>? iconDetails =
          context.read<CommonProvider>().initializeModel?.icon?.details;
      if ((widget.registrationInfo?.phoneNumber ?? '').isNotEmpty) {
        arr.add(CompanyDetailsTopItem(
          isPhone: true,
          title: widget.registrationInfo?.phoneNumber ?? '',
          iconDetails: iconDetails!,
        ));
      }
      if ((widget.registrationInfo?.email ?? '').isNotEmpty) {
        arr.add(CompanyDetailsTopItem(
          isPhone: false,
          title: widget.registrationInfo?.email ?? '',
          iconDetails: iconDetails!,
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseBottomSheet(
      height: 250.h,
      children: [
        Text(
          'Contact',
          style: TextStyles.textBold18,
        ),
        Gaps.vGap10,
        if (arr.isEmpty)
          Expanded(
              child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const LoadAssetImage(
                  'state/personnel',
                  width: 120,
                ),
                Gaps.vGap10,
                Text(
                  'No data',
                  style: Theme.of(context).textTheme.subtitle2,
                )
              ],
            ),
          ))
        else
          SizedBox(
              height: 100.h,
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: Dimens.gap_dp16),
                          child: Wrap(
                            runSpacing: Dimens.gap_dp10,
                            spacing: Dimens.gap_v_dp10,
                            children: arr,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              )),
        MyButton(
          onPressed: () => NavigatorUtils.goBack(context),
          text: 'OK',
          minHeight: 44.h,
          backgroundColor: Colours.app_main,
          textColor: Colours.material_bg,
          radius: 40.r,
        )
      ],
    );
  }
}

class CompanyDetailsTopItem extends StatelessWidget {
  const CompanyDetailsTopItem(
      {Key? key,
      this.isPhone = true,
      required this.iconDetails,
      this.title = '-'})
      : super(key: key);
  final bool isPhone;
  final String title;
  final Map<String, String> iconDetails;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colours.material_bg,
      padding: EdgeInsets.symmetric(vertical: Dimens.gap_v_dp10),
      width: double.infinity,
      child: Row(
        children: [
          LoadImage(iconDetails[isPhone ? 'phone' : 'email'] ?? '',
              width: Dimens.gap_dp15,
              height: Dimens.gap_v_dp15,
              holderImg: 'personnel/personnel'),
          Gaps.hGap10,
          Expanded(
            child: GestureDetector(
              onTap: () {
                if (isPhone) {
                  Utils.launchTelURL('$title');
                }
              },
              child: Text(
                title,
                style: TextStyles.textSize13.copyWith(
                    color: isPhone ? Colours.app_main : Colours.text_gray),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          )
        ],
      ),
    );
  }
}
