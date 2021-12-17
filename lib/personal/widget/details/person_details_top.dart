import 'package:flashinfo/company/widget/details/company_details_item_header.dart';
import 'package:flashinfo/home/model/initialize_model.dart';
import 'package:flashinfo/personal/model/personal_details_bean.dart';
import 'package:flashinfo/personal/provider/personal_provider.dart';
import 'package:flashinfo/provider/common_provider.dart';
import 'package:flashinfo/res/dimens.dart';
import 'package:flashinfo/res/resources.dart';
import 'package:flashinfo/widgets/card_widget.dart';
import 'package:flashinfo/widgets/load_image.dart';
import 'package:flutter/material.dart';
import 'package:flashinfo/util/screen_utils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class PersonDetailsTop extends StatelessWidget {
  const PersonDetailsTop({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: 16.w,vertical: 16.h),
      child: CardWidget(
        radius: 12.r,
        child: Column(
          children: [
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: 16.w),
              child: const CompanyDetailsItemHeader(
                name: 'Personal  Details',
                iconName: 0xe672,
              ),
            ),
            Consumer2<PersonalProvider, CommonProvider>(
                builder: (_, provider, commonProvider, __) {
               //   final PersonalDetailsBean? model = provider.personalDetailsBean;
                  final IconModel? iconDetails =
                      commonProvider.initializeModel?.icon;
                  return Padding(
                    padding: EdgeInsets.only(left: Dimens.gap_dp16, right: 16.w, top: 12.h,bottom: 12.h),
                    child: Wrap(
                      runSpacing: Dimens.gap_dp10,
                      spacing: Dimens.gap_v_dp10,
                    //  children: _detailsWidget(model?.details, iconDetails),
                    ),
                  );
                })
          ],
        ),
      ),
    );
  }

  List<Widget> _detailsWidget(List<Details>? details, IconModel? iconDetails) {
    final List<Widget> arr = [];
    final List<Details> list = details ?? <Details>[];
    if (list.isNotEmpty) {}
    if (iconDetails != null && list.isNotEmpty) {
      list.forEach((Details item) {
        arr.add(PersonDetailsTopItem(
          details: item,
          iconDetails: iconDetails,
        ));
      });
    }
    return arr;
  }
}

class PersonDetailsTopItem extends StatelessWidget {
  const PersonDetailsTopItem(
      {Key? key, required this.details, required this.iconDetails})
      : super(key: key);
  final Details details;
  final IconModel iconDetails;
  @override
  Widget build(BuildContext context) {
    final Map<String, String>? imgIcon;
    if (details.imgType == 'nationalFlag') {
      imgIcon = iconDetails.nationalFlag;
    } else {
      imgIcon = iconDetails.details;
    }
    return Container(
      constraints: BoxConstraints(
        minWidth: (context.width - 90.w) / 2,
      ),
      child: Row(
        children: [
          LoadImage(imgIcon![details.imgName] ?? '',
              height: Dimens.gap_v_dp15, holderImg: 'personnel/personnel'),
          Gaps.hGap10,
          Expanded(
              child: Text(
            (details.value?.trim().isNotEmpty ?? false)
                ? (details.value ?? '-')
                : '-',
            style: TextStyles.textSize13,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ))
        ],
      ),
    );
  }
}
