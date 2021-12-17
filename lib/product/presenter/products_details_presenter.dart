import 'package:flashinfo/mvp/base_page_presenter.dart';
import 'package:flashinfo/net/net.dart';
import 'package:flashinfo/product/iview/product_iview.dart';
import 'package:flashinfo/product/model/products_details_bean.dart';
import 'package:flashinfo/provider/user_info_provider.dart';
import 'package:flashinfo/widgets/Layout/state_layout.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductDetailPresenter extends BasePagePresenter<ProductDetialIMvpView> {
  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback(
      (_) {},
    );
  }
  // 请求产品详情数据
  Future getProductDetail(String productlId) {
    return requestNetwork<ProductsDetailsBean>(Method.get,
        url: HttpApi.productsList + '/$productlId',
        isShow: false, onSuccess: (ProductsDetailsBean? model) {
      if (model != null) {
        if (model.message!.isNotEmpty) {
          view.showToast(model.message ?? '');
        }
        view
            .getContext()
            .read<UserInfoProvider>()
            .updateUserBrowsingCount(model.browsingCount);
        view.productProvider.setProductDetailModel(model);
      } else {
        view.productProvider.setStateType(StateType.company);
      }
    }, onError: (_, __) {
      view.productProvider.setStateType(StateType.company);
    });
  }
}
