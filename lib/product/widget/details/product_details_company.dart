import 'package:flashinfo/company/company_rouder.dart';
import 'package:flashinfo/company/models/company_bean.dart';
import 'package:flashinfo/company/widget/details/company_details_item_header.dart';
import 'package:flashinfo/product/provider/product_provider.dart';
import 'package:flashinfo/res/resources.dart';
import 'package:flashinfo/routers/fluro_navigator.dart';
import 'package:flashinfo/widgets/card_widget.dart';
import 'package:flashinfo/widgets/load_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class ProductDetailsCompany extends StatelessWidget {
  const ProductDetailsCompany({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductProvider>(builder: (_, provider, __) {
      final CompanyModel? model = provider.productsDetailsBean?.company;
      return Visibility(
        visible: model != null,
         child: Padding(
           padding:  EdgeInsets.only(left: 16.w,right: 16.w,bottom: 16.h),
           child: CardWidget(
            radius: 12.r,

      child: Column(
        children: [
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: 16.w,),
            child: const CompanyDetailsItemHeader(
              name: 'Company',
              iconName: 0xe673,
            ),
          ),
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: 16.w,),
            child: ProductDetailsCompanyItem(model: model),
          ),
          Gaps.vGap12,
        ],
      ),
      ),
         ));
    });
  }
}

class ProductDetailsCompanyItem extends StatelessWidget {
  const ProductDetailsCompanyItem({Key? key, this.model}) : super(key: key);
  final CompanyModel? model;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => NavigatorUtils.pushResult(
          context, '${CompanyRouder.companyDetailsPage}?companyId=${model?.id}',
          (value) {
        print(value);
      }, arguments: model),
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: Divider.createBorderSide(context, width: Dimens.gap_dp1),
          ),
        ),
        height: 70.h,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LoadBorderImage(model?.logo ?? '',
                width: 50.w, height: 50.h, holderImg: 'company/company'),
            Gaps.hGap10,
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model?.name ?? '',
                    style:
                        TextStyles.textBold14.copyWith(color: Colours.app_main),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Gaps.vGap15,
                  Text(
                    model?.intro ?? '',
                    style: TextStyles.textGray13,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
