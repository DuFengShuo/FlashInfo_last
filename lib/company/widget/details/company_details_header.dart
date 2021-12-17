import 'package:flashinfo/company/models/company_details_bean.dart';
import 'package:flashinfo/company/provider/company_provider.dart';
import 'package:flashinfo/company/widget/bottomSheet/details_header_des.dart';
import 'package:flashinfo/personal/widget/header_sharerow_widget.dart';
import 'package:flashinfo/res/colors.dart';
import 'package:flashinfo/res/dimens.dart';
import 'package:flashinfo/res/gaps.dart';
import 'package:flashinfo/res/styles.dart';
import 'package:flashinfo/widgets/load_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class CompanyDetailsHeader extends StatelessWidget {
  const CompanyDetailsHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          vertical: Dimens.gap_v_dp16, horizontal: Dimens.gap_dp16),
      color: Colours.app_main,
      width: double.infinity,
      child: Consumer<CompanyProvider>(builder: (_, provider, __) {
        final CompanyDetailsBean? companyDetailModel =
            provider.companyDetailsBean;
        return Row(
          children: [
            Stack(
              children: [
                LoadBorderImage(companyDetailModel?.info!.logo ?? '',
                    width: 78.w,
                    height: 78.w,
                    radius: 8.r,
                    holderImg: 'company/company'),
                Positioned(
                  right: 0,
                  top: 0,
                  child: LoadAssetImage(
                    'company/company_tag',
                    width: 36.w,
                    height: 36.w,
                  ),
                )
              ],
            ),
            Gaps.hGap16,
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  companyDetailModel?.info?.name ?? '',
                  style: TextStyles.textBold18
                      .copyWith(color: Colours.material_bg),
                  // maxLines: 2,
                  // overflow: TextOverflow.ellipsis,
                ),
                Gaps.vGap16,
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    HeaderShareRowWidget(
                      bgColor: Colours.material_bg,
                      title: 'Detail',
                      iconUrl: '${companyDetailModel?.info!.linkedin}',
                      iconName: 0xe65e,
                      radius: 22.0.sp,
                      leftMargin: 0,
                      isVisible: companyDetailModel!.info!.linkedin!.isNotEmpty,
                    ),
                    HeaderShareRowWidget(
                      bgColor: Colours.material_bg,
                      title: 'Detail',
                      iconUrl: '${companyDetailModel.info!.twitter}',
                      iconName: 0xe65d,
                      radius: 22.0.sp,
                      leftMargin: Dimens.gap_dp8,
                      isVisible: companyDetailModel.info!.twitter!.isNotEmpty,
                    ),
                    HeaderShareRowWidget(
                      bgColor: Colours.material_bg,
                      title: 'Detail',
                      iconUrl: '${companyDetailModel.info!.facebook}',
                      iconName: 0xe65c,
                      radius: 22.0.sp,
                      leftMargin: Dimens.gap_dp8,
                      isVisible: companyDetailModel.info!.facebook!.isNotEmpty,
                    ),
                    HeaderShareRowWidget(
                      bgColor: Colours.material_bg,
                      title: 'Detail',
                      iconUrl: '${companyDetailModel.info!.youtube}',
                      iconName: 0xe660,
                      radius: 22.0.sp,
                      leftMargin: Dimens.gap_dp8,
                      isVisible: companyDetailModel.info!.youtube!.isNotEmpty,
                    ),
                    HeaderShareRowWidget(
                      bgColor: Colours.material_bg,
                      title: 'Detail',
                      iconUrl: '${companyDetailModel.info!.instagram}',
                      iconName: 0xe661,
                      radius: 22.0.sp,
                      leftMargin: Dimens.gap_dp8,
                      isVisible: companyDetailModel.info!.instagram!.isNotEmpty,
                    ),
                  ],
                )
              ],
            ))
          ],
        );
      }),
    );
  }
}
