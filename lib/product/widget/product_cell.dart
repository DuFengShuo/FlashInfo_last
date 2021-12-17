import 'package:flashinfo/common/common.dart';
import 'package:flashinfo/favourites/page/cancel_group_page.dart';
import 'package:flashinfo/favourites/page/group_dialog_page.dart';
import 'package:flashinfo/login/login_router.dart';
import 'package:flashinfo/mvp/status_model.dart';
import 'package:flashinfo/product/model/products_bean.dart';
import 'package:flashinfo/res/resources.dart';
import 'package:flashinfo/routers/fluro_navigator.dart';
import 'package:flashinfo/util/image_utils.dart';
import 'package:flashinfo/util/other_utils.dart';
import 'package:flashinfo/widgets/hight_light_text_widget.dart';
import 'package:flashinfo/widgets/icon_font.dart';
import 'package:flashinfo/widgets/login_toast_dialog.dart';
import 'package:flashinfo/widgets/my_card.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductCellWidget extends StatelessWidget {
  const ProductCellWidget({
    Key? key,
    this.productModel,
    this.collectSuccessful,
    this.onTap,
    this.highlightText = '',
    this.isCancelAl = true,
  }) : super(key: key);
  final ProductsModel? productModel;
  final void Function(StatusModel)? collectSuccessful;
  final void Function()? onTap;
  final String? highlightText;
  final bool isCancelAl;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(left: 16.0.w, right: 16.0.w, bottom: 8.0.h),
      child: MyCard(
          child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: Dimens.gap_dp10, vertical: Dimens.gap_v_dp10),
        child: InkWell(
          onTap: onTap,
          child: _buildContent(context),
        ),
      )),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colours.material_bg,
                border: Border.all(
                    color: Colours.bg_color,
                    width: 0.6.w,
                    style: BorderStyle.solid),
                borderRadius: BorderRadius.circular(3), // 设置四周圆角
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: ImageUtils.getImageProvider(productModel?.logo ?? '',
                      holderImg: 'product/product'),
                ),
              ),
              width: 48.0.w,
              height: 48.0.h,
            ),
            Gaps.hGap8,
            Expanded(
                child: Container(
              color: Colours.material_bg,
              width: double.infinity,
              height: 48.0.h,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  HighlightTextWidget(
                      name: productModel?.name ?? '',
                      highlightText: highlightText ?? ''),
                  Text(
                    productModel?.desc ?? '',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 8.0.sp,
                      color: Colours.text_gray,
                    ),
                  ),
                ],
              ),
            )),
            Gaps.hGap8,
            InkWell(
              onTap: () => _showFavouritesDialog(context),
              child: IconFont(
                  name: 0xe611,
                  size: 16.h,
                  color: (productModel?.isCollect ?? false)
                      ? Colours.app_main
                      : Colours.unselected_item_color),
            ),
            Gaps.hGap5,
          ],
        ),
        Gaps.vGap10,
        Visibility(
          visible: (productModel?.companyModel == null ||
                  productModel!.companyModel!.name!.isEmpty)
              ? false
              : true,
          child: InkWell(
            onTap: () {},
            child: Row(
              children: [
                IconFont(
                    name: 0xe627,
                    size: 12.h,
                    color: Colours.unselected_item_color),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        vertical: 8.0.h, horizontal: 8.0.w),
                    decoration: BoxDecoration(
                      border: Border(
                        top: Divider.createBorderSide(context, width: 0.8.w),
                      ),
                    ),
                    child: Text(
                      productModel?.companyModel?.name ?? '',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyles.textSize12
                          .copyWith(color: Colours.app_main),
                    ),
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }

  void _showFavouritesDialog(BuildContext context) {
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
    if (!isCancelAl) {
      final StatusModel statusModel = StatusModel();
      collectSuccessful!(statusModel);
      return;
    }
    if (productModel?.isCollect == true) {
      showElasticDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return CancelGroupPage(
            indexType: 2,
            relatedTd: productModel?.id,
            collectCancel: collectSuccessful,
          );
        },
      );
    } else {
      showElasticDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return GroupDialogPage(
            indexType: 2,
            relatedTd: productModel?.id,
            collectSuccessful: collectSuccessful,
          );
        },
      );
    }
  }
}
