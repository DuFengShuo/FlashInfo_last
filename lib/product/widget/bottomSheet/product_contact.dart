import 'package:flashinfo/company/models/company_bean.dart';
import 'package:flashinfo/provider/common_provider.dart';
import 'package:flashinfo/res/resources.dart';
import 'package:flashinfo/routers/fluro_navigator.dart';
import 'package:flashinfo/widgets/base_bottom_sheet.dart';
import 'package:flashinfo/widgets/load_image.dart';
import 'package:flashinfo/widgets/my_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class ProductContact extends StatefulWidget {
  const ProductContact({Key? key, this.onTap, this.company}) : super(key: key);
  final void Function()? onTap;
  final CompanyModel? company;
  @override
  _ProductContactState createState() => _ProductContactState();
}

class _ProductContactState extends State<ProductContact> {
  CompanyModel? company;
  @override
  void initState() {
    company = widget.company;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseBottomSheet(
      height: 300.h,
      children: [
        Text(
          'Contact',
          style: TextStyles.textBold18,
        ),
        Gaps.vGap10,
        if (company == null ||
            (company!.mobile!.isEmpty && company!.email!.isEmpty))
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Gaps.vGap20,
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
          )
        else
          SizedBox(
              height: 130.h,
              child: Row(
                children: [
                  Consumer<CommonProvider>(
                    builder: (_, commonProvider, __) {
                      final Map<String, String>? iconDetails =
                          commonProvider.initializeModel?.icon?.details;
                      return Expanded(
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: Dimens.gap_dp16),
                              child: Wrap(
                                runSpacing: Dimens.gap_dp10,
                                spacing: Dimens.gap_v_dp10,
                                children: [
                                  PersonDetailsTopItem(
                                    iconDetails: iconDetails!,
                                    imgName: 'phone',
                                    value: company!.mobile,
                                  ),
                                  PersonDetailsTopItem(
                                    iconDetails: iconDetails,
                                    imgName: 'email',
                                    value: company!.email,
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  ),
                ],
              )),
      const  Spacer(),
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

class PersonDetailsTopItem extends StatelessWidget {
  const PersonDetailsTopItem(
      {Key? key, required this.iconDetails, this.imgName, this.value})
      : super(key: key);
  final Map<String, String> iconDetails;
  final String? imgName;
  final String? value;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colours.material_bg,
      padding: EdgeInsets.symmetric(vertical: Dimens.gap_v_dp10),
      width: double.infinity,
      child: Row(
        children: [
          LoadImage(iconDetails[imgName] ?? '',
              width: Dimens.gap_dp15,
              height: Dimens.gap_v_dp15,
              holderImg: 'personnel/personnel'),
          Gaps.hGap10,
          Expanded(
              child: Text(
            (value?.trim().isNotEmpty ?? false) ? (value ?? '-') : '-',
            style: TextStyles.textSize13.copyWith(
                color: (imgName == 'phone')
                    ? Colours.app_main
                    : Colours.text_gray),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ))
        ],
      ),
    );
  }
}
