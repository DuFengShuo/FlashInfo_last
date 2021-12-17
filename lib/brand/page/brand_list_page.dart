import 'package:flashinfo/brand/iview/brand_list_iview.dart';
import 'package:flashinfo/brand/models/brand_list_bean.dart';
import 'package:flashinfo/brand/presenter/brand_list_presenter.dart';
import 'package:flashinfo/brand/widget/brand_search_list_cell.dart';
import 'package:flashinfo/mvp/base_page.dart';
import 'package:flashinfo/mvp/power_presenter.dart';
import 'package:flashinfo/provider/base_list_provider.dart';
import 'package:flashinfo/provider/user_info_provider.dart';
import 'package:flashinfo/res/colors.dart';
import 'package:flashinfo/res/resources.dart';
import 'package:flashinfo/routers/fluro_navigator.dart';
import 'package:flashinfo/widgets/my_app_bar.dart';
import 'package:flashinfo/widgets/my_refresh_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class BandListPage extends StatefulWidget {
  const BandListPage({Key? key, this.keyword = ''}) : super(key: key);
  final String keyword;

  @override
  _BandListPageState createState() => _BandListPageState();
}

class _BandListPageState extends State<BandListPage>
    with BasePageMixin<BandListPage, PowerPresenter>
    implements BrandListIMvpView {
  @override
  BaseListProvider<BrandItemModel> searcBrandListProvider =
      BaseListProvider<BrandItemModel>(); //搜索品牌结果数据
  late BrandListPresenter _brandListPresenter;
  @override
  PowerPresenter createPresenter() {
    final PowerPresenter powerPresenter = PowerPresenter<dynamic>(this);
    _brandListPresenter = BrandListPresenter();
    _brandListPresenter.keyword = widget.keyword;
    powerPresenter.requestPresenter([_brandListPresenter]);
    return powerPresenter;
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<BaseListProvider<BrandItemModel>>(
              create: (_) => searcBrandListProvider),
        ],
        child: Scaffold(
            backgroundColor: Colours.bg_color,
            appBar: MyAppBar(
                centerTitle: 'Brands',
                backOnPressed: () =>
                    NavigatorUtils.goBackWithParams(context, '')),
            body: Consumer2<BaseListProvider<BrandItemModel>, UserInfoProvider>(
                builder: (_, provider, userInfoProvider, __) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        EdgeInsets.only(left: 16.w, top: 13.h, bottom: 13.h),
                    child: RichText(
                      maxLines: 2,
                      text: TextSpan(
                        text: '${provider.metaModel?.pagination?.total ?? 0} ',
                        style: TextStyles.textBold14
                            .copyWith(color: Colours.app_main),
                        children: const <TextSpan>[
                          TextSpan(
                            text: 'Brands Found',
                            style: TextStyle(color: Colours.text),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                      child: DeerListView(
                    key: const Key('brand_list'),
                    itemCount: userInfoProvider.userInfoModel == null &&
                            (provider.metaModel?.pagination?.total ?? 0) > 20
                        ? 19
                        : ((!userInfoProvider.isVip &&
                                (provider.metaModel?.pagination?.total ?? 0) >
                                    100)
                            ? (provider.list.length < 100
                                ? provider.list.length
                                : 99)
                            : provider.list.length),
                    stateType: provider.stateType,
                    onRefresh: _brandListPresenter.onRefresh,
                    loadMore: _brandListPresenter.loadMore,
                    hasMore: provider.hasMore,
                    totalPages: provider.metaModel?.pagination?.totalPages ?? 1,
                    fuzzyImg: 'company/company_fuzzy',
                    isLogin: (userInfoProvider.userInfoModel == null &&
                            (provider.metaModel?.pagination?.total ?? 0) >
                                20) ||
                        (provider.list.length > 90 &&
                            !userInfoProvider.isVip &&
                            (provider.metaModel?.pagination?.total ?? 0) > 100),
                    loginName: 'View all search results',
                    vipName: 'Upgrade  Plan for unlimited search results',
                    itemBuilder: (_, index) {
                      return Padding(
                          padding: EdgeInsets.only(
                            bottom: 8.h,
                            left: 16.w,
                            right: 16.w,
                          ),
                          child:
                              BrandSearchListCell(model: provider.list[index]));
                    },
                  )),
                ],
              );
            })));
  }
}
