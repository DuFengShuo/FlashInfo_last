import 'package:flashinfo/company/company_rouder.dart';
import 'package:flashinfo/company/models/company_bean.dart';
import 'package:flashinfo/company/page/reviews/company_details_reviews.dart';
import 'package:flashinfo/company/widget/details/follow_contact_widget.dart';
import 'package:flashinfo/mvp/base_page.dart';
import 'package:flashinfo/mvp/power_presenter.dart';
import 'package:flashinfo/mvp/status_model.dart';
import 'package:flashinfo/personal/widget/details/person_details_header.dart';
import 'package:flashinfo/product/iview/product_iview.dart';
import 'package:flashinfo/product/model/products_bean.dart';
import 'package:flashinfo/product/model/products_details_bean.dart';
import 'package:flashinfo/product/presenter/products_details_presenter.dart';
import 'package:flashinfo/product/provider/product_provider.dart';
import 'package:flashinfo/product/widget/bottomSheet/product_contact.dart';
import 'package:flashinfo/product/widget/details/product_details_company.dart';
import 'package:flashinfo/product/widget/details/product_details_description.dart';
import 'package:flashinfo/product/widget/details/product_details_img.dart';
import 'package:flashinfo/product/widget/details/product_header_widget.dart';
import 'package:flashinfo/res/resources.dart';
import 'package:flashinfo/routers/fluro_navigator.dart';
import 'package:flashinfo/util/device_utils.dart';
import 'package:flashinfo/util/image_utils.dart';
import 'package:flashinfo/widgets/Layout/state_layout.dart';
import 'package:flashinfo/widgets/my_scroll_view.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class ProductDetailsPage extends StatefulWidget {
  const ProductDetailsPage({Key? key, required this.productId, this.model})
      : super(key: key);
  final String productId;
  final ProductsModel? model;

  @override
  _ProductDetailsPageState createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage>
    with BasePageMixin<ProductDetailsPage, PowerPresenter>
    implements ProductDetialIMvpView {
  late ScrollController _scrollController;
  int showSearch = 0;

  @override
  ProductProvider productProvider = ProductProvider();
  late ProductDetailPresenter _productDetailPresenter;

  @override
  PowerPresenter createPresenter() {
    final PowerPresenter powerPresenter = PowerPresenter<dynamic>(this);
    _productDetailPresenter = ProductDetailPresenter();
    powerPresenter.requestPresenter([_productDetailPresenter]);
    return powerPresenter;
  }

  @override
  void initState() {
    productProvider.setStateType(StateType.detailLayout);
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback(
      (_) async {
        await _productDetailPresenter.getProductDetail(widget.productId);
      },
    );
    _scrollController = new ScrollController();
    _scrollController.addListener(() {
      if ((_scrollController.offset > 80.h && showSearch == 1) ||
          (_scrollController.offset < 80.h && showSearch == 0)) {
        return;
      }
      setState(() {
        showSearch = _scrollController.offset > 80.h ? 1 : 0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ProductProvider>(
        create: (_) => productProvider,
        child: Scaffold(
            backgroundColor: Colours.bg_color,
            body: Consumer<ProductProvider>(builder: (_, provider, __) {
              final ProductsDetailsBean? model = provider.productsDetailsBean;
              return model == null
                  ? StateLayout(
                      type: provider.stateType,
                    )
                  : new NestedScrollView(
                      controller: _scrollController,
                      headerSliverBuilder: (context, bool innerScrolled) {
                        return [
                          SliverAppBar(
                            title: Gaps.empty,
                            pinned: true,
                            floating: false,
                            // 不随着滑动隐藏标题
                            elevation: 0,
                            expandedHeight: 150.h,
                            backgroundColor: Colours.app_main,
                            leading: Padding(
                                padding: EdgeInsets.only(left: 20.w),
                                child: InkWell(
                                  onTap: () {
                                    if (widget.model == null) {
                                      NavigatorUtils.goBack(context);
                                    } else {
                                      NavigatorUtils.goBackWithParams(
                                          context, widget.model!);
                                    }
                                  },
                                  child: const Icon(
                                    Icons.arrow_back_ios,
                                    color: Colours.material_bg,
                                  ),
                                )),
                            flexibleSpace: FlexibleSpaceBar(
                              title: showSearch == 1
                                  ? Row(
                                      children: [
                                        Visibility(
                                            visible: Device.isIOS,
                                            child: SizedBox(
                                              width: 50.w,
                                            )),
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8.r),
                                          child: Image(
                                            width: 22.w,
                                            height: 22.w,
                                            fit: BoxFit.fill,
                                            image: ImageUtils.getImageProvider(
                                                '${model.logo}'),
                                          ),
                                        ),
                                        Gaps.hGap8,
                                        Expanded(
                                          child: Text(
                                            model.name ?? '',
                                            style: TextStyles.textBold16,
                                            textAlign: TextAlign.left,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        Gaps.hGap18,
                                      ],
                                    )
                                  : Gaps.empty,
                              background: ProductHeaderWidget(
                                name: model.name,
                                iconName: model.logo,
                                webUrl: model.website,
                              ),
                            ),
                          ),
                        ];
                      },
                      body: MyScrollView(
                        physics: const NeverScrollableScrollPhysics(),
                        isSafeArea: false,
                        bottomButton: Container(
                            height: MediaQuery.of(context).padding.bottom + 60,
                            color: Colours.material_bg,
                            child: FollowContactWidget(
                                isCollect: model.isCollect ?? false,
                                followId: model.id ?? '',
                                indexType: 2,
                                onTapReviews: () => NavigatorUtils.push(context,
                                    CompanyRouder.companyRateReviewsPage),
                                onTapContact: () =>
                                    showBottomSheet(context, model.company),
                                collectSuccessful: (StatusModel statusModel) {
                                  model.isCollect = !(model.isCollect ?? false);
                                  widget.model?.isCollect = model.isCollect;
                                })),
                        children: _buildBody(),
                      ),
                    );
            })));
  }

  List<Widget> _buildBody() {
    return <Widget>[
      const ProductDetailsImg(),
      const ProductDetailsDescription(),
      const ProductDetailsCompany(),
      Consumer<ProductProvider>(builder: (_, provider, __) {
        final ProductsDetailsBean? model = provider.productsDetailsBean;
        return CompanyDetailsReviews(
          comments: model?.comments,
          relatedId: model?.id,
          pageType: 'product',
        );
      }),
    ];
  }

  //显示底部弹框的功能
  void showBottomSheet(BuildContext context, CompanyModel? company) {
    //用于在底部打开弹框的效果
    showModalBottomSheet<void>(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (BuildContext context) {
          //构建弹框中的内容
          return ProductContact(company: company);
        });
  }
}
