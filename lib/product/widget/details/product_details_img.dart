import 'package:flashinfo/company/models/albums_bean.dart';
import 'package:flashinfo/product/provider/product_provider.dart';
import 'package:flashinfo/res/colors.dart';
import 'package:flashinfo/res/dimens.dart';
import 'package:flashinfo/widgets/load_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class ProductDetailsImg extends StatelessWidget {
  const ProductDetailsImg({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductProvider>(builder: (_, provider, __) {
      final List<AlbumsModel> list =
          provider.productsDetailsBean?.albums?.list ?? [];
      return Visibility(
          visible: list.isNotEmpty,
          child: Container(
            padding: EdgeInsets.symmetric(
                horizontal: Dimens.gap_dp10, vertical: Dimens.gap_v_dp10),
            decoration: BoxDecoration(
                color: Colours.material_bg,
                borderRadius: BorderRadius.all(Radius.circular(12.r))),
            margin: EdgeInsets.symmetric(
                horizontal: Dimens.gap_dp10, vertical: Dimens.gap_v_dp16),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  color: Colours.material_bg,
                  padding: EdgeInsets.symmetric(
                      horizontal: Dimens.gap_dp16, vertical: Dimens.gap_v_dp16),
                  child: SizedBox(
                      height: 145.h,
                      width: double.infinity,
                      child: MediaQuery.removePadding(
                        context: context,
                        removeTop: true,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: list.length,
                          itemBuilder: (BuildContext context, int index) {
                            final AlbumsModel? model = list[index];
                            return LoadBorderImage(model?.logo ?? '',
                                width: 145.w,
                                height: 90.h,
                                holderImg: 'product/product');
                          },
                        ),
                      )),
                )
              ],
            ),
          ));
    });
  }
}
