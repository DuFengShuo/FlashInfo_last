import 'package:flashinfo/company/widget/details/company_details_item_header.dart';
import 'package:flashinfo/product/model/products_details_bean.dart';
import 'package:flashinfo/product/provider/product_provider.dart';
import 'package:flashinfo/res/resources.dart';
import 'package:flashinfo/widgets/card_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductDetailsDescription extends StatelessWidget {
  const ProductDetailsDescription({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductProvider>(builder: (_, provider, __) {
      final ProductsDetailsBean? model = provider.productsDetailsBean;
      return Visibility(
          visible: (model?.desc ?? '').isNotEmpty,
          child: Padding(
            padding:  EdgeInsets.symmetric(horizontal: 16.w,vertical: 16.h),
            child: CardWidget(
              radius: 12.r,
              // margin: EdgeInsets.only(left: 16.w, right: 16.w,bottom: 16.h,top: 16.h),
              // decoration: BoxDecoration(
              //     color: Colours.material_bg,
              //     borderRadius: BorderRadius.all(Radius.circular(12.r))),
              // padding: EdgeInsets.symmetric(horizontal: Dimens.gap_dp10,vertical: Dimens.gap_v_dp10),
              child: Padding(
                padding:  EdgeInsets.only(left: 16.w,right: 16.w,bottom: 12.h),
                child: Column(
                  children: [
                    const CompanyDetailsItemHeader(
                      name: 'Product Description',
                    ),
                    // Gaps.vGap16,
                    Text(
                      model?.desc ?? '',
                      style: TextStyles.textGray13.copyWith(height: 1.3),
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                    )
                  ],
                ),
              ),
            ),
          ));
    });
  }
}
