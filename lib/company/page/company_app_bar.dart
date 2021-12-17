import 'package:flashinfo/company/models/company_detail_model.dart';
import 'package:flashinfo/company/widget/details/company_details_header.dart';
import 'package:flashinfo/res/resources.dart';
import 'package:flashinfo/widgets/load_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CompanyPppBar extends StatelessWidget {
  const CompanyPppBar(
      {Key? key, this.bottom, this.showSearch = false, this.model})
      : super(key: key);
  final PreferredSizeWidget? bottom;
  final bool showSearch;
  final CompanyDetailModel? model;
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      title: showSearch
          ? Container(
              color: Colors.transparent,
              width: double.infinity,
              child: Row(
                children: [
                  LoadBorderImage(model?.logo ?? '',
                      width: 22.w, height: 22.w, holderImg: 'company/company'),
                  Gaps.hGap10,
                  Text(
                    model?.name ?? '',
                    textAlign: TextAlign.left,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  )
                ],
              ),
            )
          : const Text('Company details'),
      pinned: true,
      floating: false, // 不随着滑动隐藏标题
      elevation: 0,
      expandedHeight: 245.h,
      backgroundColor: Colours.app_main,
      flexibleSpace: FlexibleSpaceBar(
          background: Container(
        color: Colours.material_bg,
        padding: EdgeInsets.only(bottom: 45.h),
        child: const CompanyDetailsHeader(),
      )),
      bottom: bottom,
    );
  }
}
