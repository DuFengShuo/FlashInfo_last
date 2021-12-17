import 'package:flashinfo/brand/models/brand_bean.dart';
import 'package:flashinfo/brand/provider/brand_detail_provider.dart';
import 'package:flashinfo/common/common.dart';
import 'package:flashinfo/company/company_rouder.dart';
import 'package:flashinfo/login/login_router.dart';
import 'package:flashinfo/product/product_router.dart';
import 'package:flashinfo/res/colors.dart';
import 'package:flashinfo/res/gaps.dart';
import 'package:flashinfo/res/styles.dart';
import 'package:flashinfo/routers/fluro_navigator.dart';
import 'package:flashinfo/widgets/card_widget.dart';
import 'package:flashinfo/widgets/load_image.dart';
import 'package:flashinfo/widgets/login_toast_dialog.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'company_details_item_header.dart';

class CompanyDetailsProductWidget extends StatelessWidget {
  const CompanyDetailsProductWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<BrandProvider>(builder: (_, provider, __) {
      final BrandBean? brandBean = provider.brandBean;
      final List<ProductModel> list =
          provider.brandBean!.business!.products!.productList!;
      int count = 0;
      if (list.isNotEmpty) {
        count = list.length <= 3 ? list.length : 3;
      }
      return Padding(
        padding:
            EdgeInsets.only(left: 16.w, right: 16.w, bottom: 8.h, top: 8.h),
        child: CardWidget(
            radius: 12.0.r,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(12.r)),
                color: Colours.material_bg,
              ),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: CompanyDetailsItemHeader(
                      isNewIcon: true,
                      iconName: 0xe64c,
                      count: list.length,
                      name: 'Business',
                      fontSize: 16,
                    ),
                  ),
                  Gaps.line,
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: CompanyDetailsItemHeader(
                        // iconName: 0xe67a,
                        name: 'Products',
                        count: brandBean!.business!.products!.total,
                        onTap: (brandBean.business!.products!.total ?? 0) > 3
                            ? () {
                                if (!(SpUtil.getBool(Constant.isLogin,
                                        defValue: false) ??
                                    false)) {
                                  showDialog<void>(
                                      context: context,
                                      barrierDismissible: true,
                                      builder: (_) =>
                                          LoginToastDialog(onPressed: () {
                                            Navigator.pop(context);
                                            NavigatorUtils.push(context,
                                                LoginRouter.smsLoginPage);
                                          }));
                                  return;
                                }
                                NavigatorUtils.push(context,
                                    '${CompanyRouder.companyProductsPage}?companyId=${brandBean.info?.id ?? ''}');
                              }
                            : null),
                  ),
                  if (list.isEmpty)
                    Padding(
                      padding: EdgeInsets.only(
                          bottom: 16.h, left: 16.w, right: 16.w),
                      child: SizedBox(
                        width: double.infinity,
                        height: 20.h,
                        child: const Text(
                            'There are no Products  for this brand.'),
                      ),
                    )
                  else
                    ListView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.only(bottom: 8.h),
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: count,
                      itemBuilder: (BuildContext context, int index) {
                        final ProductModel model = list[index];
                        return _productItemWidget(model, context);
                      },
                    ),
                ],
              ),
            )),
      );
    });
  }

  Widget _productItemWidget(ProductModel models, BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!(SpUtil.getBool(Constant.isLogin, defValue: false) ?? false)) {
          showDialog<void>(
              context: context,
              barrierDismissible: true,
              builder: (_) => LoginToastDialog(onPressed: () {
                    Navigator.pop(context);
                    NavigatorUtils.push(context, LoginRouter.smsLoginPage);
                  }));
          return;
        }
        NavigatorUtils.push(context,
            '${ProductRouter.productDetailsPage}?productId=${models.id}');
      },
      child: Padding(
        padding: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 8.h),
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(
                color: Colours.border_grey,
                width: 1,
                // style: BorderStyle.solid
              ),
              borderRadius: const BorderRadius.all(Radius.circular(12))),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                LoadBorderImage(models.logo ?? '',
                    width: 96.w, height: 96.w, holderImg: 'brand/brand_product'),
                Gaps.hGap10,
                Expanded(
                    child: SizedBox(
                  height: 80.h,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        models.name ?? '',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyles.textSize14.copyWith(
                            color: Colours.text, fontWeight: FontWeight.bold),
                      ),
                      Gaps.vGap8,
                      Expanded(
                        child: Text(
                          models.desc!.isEmpty ? '-' : models.desc ?? '',
                          style: TextStyles.textGray12.copyWith(height: 1.3),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      )
                    ],
                  ),
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // List<Widget> _categoryWidget(String name, List<Category>? category) {
  //   final List<Widget> arr = [];
  //   arr.add(Text(
  //     name,
  //     style: TextStyles.textSize14.copyWith(color: Colours.app_main),
  //   ));
  // arr.add(Gaps.hGap10);
  //
  // final List<Category> list = category ?? <Category>[];
  // list.forEach((Category item) {
  //   arr.add(Container(
  //     decoration: BoxDecoration(
  //       color: const Color.fromARGB(30, 50, 112, 237),
  //       borderRadius: BorderRadius.all(Radius.circular(25.0.h)),
  //     ),
  //     margin: EdgeInsets.only(right: Dimens.gap_dp10),
  //     padding: EdgeInsets.symmetric(
  //         horizontal: Dimens.gap_dp10, vertical: Dimens.gap_v_dp2),
  //     child: Text(
  //       item.name ?? '',
  //       style: TextStyles.textGray10,
  //     ),
  //   ));
  // });

  //   return arr;
  // }
}
