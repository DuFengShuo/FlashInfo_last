import 'package:flashinfo/common/common.dart';
import 'package:flashinfo/company/iview/company_detail_iview.dart';
import 'package:flashinfo/company/presenter/company_detial_other_presenter.dart';
import 'package:flashinfo/login/login_router.dart';
import 'package:flashinfo/mvp/base_page.dart';
import 'package:flashinfo/mvp/power_presenter.dart';
import 'package:flashinfo/product/model/products_bean.dart';
import 'package:flashinfo/product/product_router.dart';
import 'package:flashinfo/provider/base_list_provider.dart';
import 'package:flashinfo/res/resources.dart';
import 'package:flashinfo/routers/fluro_navigator.dart';
import 'package:flashinfo/widgets/load_image.dart';
import 'package:flashinfo/widgets/login_toast_dialog.dart';
import 'package:flashinfo/widgets/my_app_bar.dart';
import 'package:flashinfo/widgets/my_refresh_list.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CompanyProductsPage extends StatefulWidget {
  const CompanyProductsPage({Key? key, this.companyId}) : super(key: key);
  final String? companyId;
  @override
  _CompanyProductsPageState createState() => _CompanyProductsPageState();
}

class _CompanyProductsPageState extends State<CompanyProductsPage>
    with BasePageMixin<CompanyProductsPage, PowerPresenter>
    implements CompanyProductsIMvpView {
  @override
  BaseListProvider<ProductsModel> companyProductsProvider =
      BaseListProvider<ProductsModel>();

  late CompanyProductsPresenter _companyProductsPresenter;
  @override
  PowerPresenter createPresenter() {
    final PowerPresenter powerPresenter = PowerPresenter<dynamic>(this);
    _companyProductsPresenter = CompanyProductsPresenter();
    _companyProductsPresenter.companyId = widget.companyId ?? '';
    powerPresenter.requestPresenter([_companyProductsPresenter]);
    return powerPresenter;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<BaseListProvider<ProductsModel>>(
            create: (_) => companyProductsProvider),
      ],
      child: Scaffold(
        backgroundColor: Colours.bg_color,
        appBar: const MyAppBar(
          centerTitle: 'Products',
        ),
        body: Consumer<BaseListProvider<ProductsModel>>(
          builder: (_, provider, __) {
            return DeerListView(
              key: const Key('product_lists'),
              itemCount: provider.list.length,
              stateType: provider.stateType,
              onRefresh: _companyProductsPresenter.onRefresh,
              loadMore: _companyProductsPresenter.loadMore,
              hasMore: provider.hasMore,
              pageSize: 30,
              totalPages: provider.metaModel?.pagination?.totalPages ?? 1,
              itemBuilder: (_, index) {
                return Padding(
                  padding: EdgeInsets.only(top: index == 0 ? 16 : 0),
                  child: CompanyEmployeeItem(
                    model: provider.list[index],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class CompanyEmployeeItem extends StatelessWidget {
  const CompanyEmployeeItem({Key? key, this.model}) : super(key: key);
  final ProductsModel? model;
  @override
  Widget build(BuildContext context) {
    return
      GestureDetector(
        onTap: (){
          if (!(SpUtil.getBool(Constant.isLogin,
              defValue: false) ??
              false)) {
            showDialog<void>(
                context: context,
                barrierDismissible: true,
                builder: (_) => LoginToastDialog(onPressed: () {
                  Navigator.pop(context);
                  NavigatorUtils.push(
                      context, LoginRouter.smsLoginPage);
                }));
            return;
          }
          NavigatorUtils.push(
              context, '${ProductRouter.productDetailsPage}?productId=${model!.id}');
        },
        child:       Container(
          margin: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 8.h),
          padding: EdgeInsets.symmetric(
              vertical: Dimens.gap_v_dp10, horizontal: Dimens.gap_v_dp16),
          decoration: BoxDecoration(
              color: Colours.material_bg,
              borderRadius: BorderRadius.all(Radius.circular(12.r))
            // border: Border(
            //   bottom: Divider.createBorderSide(context, width: Dimens.gap_dp1),
            // ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LoadBorderImage(
                 model?.logo ?? '',

                width: 96.w,
                height: 96.w,
                holderImg: 'brand/brand_product',
                radius: 8.r,
              ),
              Gaps.hGap10,
              Expanded(
                  child: SizedBox(
                    // height: 80.h,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Gaps.vGap8,
                        Text(
                          model?.name ?? '',
                          style: TextStyles.textBold14,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Gaps.vGap8,
                        Text(
                          // model?.desc ?? '',
                          model!.desc!.isEmpty ? '-' : model!.desc ?? '',
                          style: TextStyles.textGray12.copyWith(height: 1.3),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  )),
            ],
          ),
        ),
      );


  }

  // List<Widget> _categoryWidget() {
  //   final List<Widget> arr = [];
  //   arr.add(Text(
  //     model?.name ?? '',
  //     style: TextStyles.textSize14.copyWith(color: Colours.app_main),
  //   ));
  //   arr.add(Gaps.hGap10);
  //   final List<Category> list = model?.category ?? <Category>[];
  //   list.forEach((Category item) {
  //     arr.add(Container(
  //       decoration: BoxDecoration(
  //         color: const Color.fromARGB(30, 50, 112, 237),
  //         borderRadius: BorderRadius.all(Radius.circular(25.0.h)),
  //       ),
  //       margin: EdgeInsets.only(right: Dimens.gap_dp10),
  //       padding: EdgeInsets.symmetric(
  //           horizontal: Dimens.gap_dp10, vertical: Dimens.gap_v_dp2),
  //       child: Text(
  //         item.name ?? '',
  //         style: TextStyles.textGray10,
  //       ),
  //     ));
  //   });

  //   return arr;
  // }
}
