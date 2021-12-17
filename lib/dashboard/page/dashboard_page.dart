import 'package:flashinfo/dashboard/iview/dashboard_iview.dart';
import 'package:flashinfo/dashboard/models/news_bean.dart';
import 'package:flashinfo/dashboard/page/news_page.dart';
import 'package:flashinfo/dashboard/page/recommend_page.dart';
import 'package:flashinfo/dashboard/presenter/dashboard_presenter.dart';
import 'package:flashinfo/dashboard/widgets/dashboard_search_widget.dart';
import 'package:flashinfo/dashboard/widgets/dashboard_tab_widget.dart';
import 'package:flashinfo/dashboard/widgets/dashboard_top_widget.dart';
import 'package:flashinfo/mvp/base_page.dart';
import 'package:flashinfo/mvp/power_presenter.dart';
import 'package:flashinfo/provider/base_list_provider.dart';
import 'package:flashinfo/res/colors.dart';
import 'package:flashinfo/res/resources.dart';
import 'package:flashinfo/routers/fluro_navigator.dart';
import 'package:flashinfo/search/search_router.dart';
import 'package:flashinfo/util/device_utils.dart';
import 'package:flashinfo/util/image_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage>
    with
        BasePageMixin<DashboardPage, PowerPresenter>,
        SingleTickerProviderStateMixin,
        AutomaticKeepAliveClientMixin
    implements DashboardIMvpView {
  late DashboardPagePresenter _dashboardPagePresenter;
  @override
  PowerPresenter createPresenter() {
    final PowerPresenter powerPresenter = PowerPresenter<dynamic>(this);
    _dashboardPagePresenter = DashboardPagePresenter();
    powerPresenter.requestPresenter([_dashboardPagePresenter]);
    return powerPresenter;
  }

  late ScrollController _scrollController;
  int showSearch = 0;
  late TabController _tabController;
  final List<dynamic> _itemIconArray = <dynamic>[
    {'title': 'Company', 'iconName': 0xe663, 'index': 1},
    {'title': 'People', 'iconName': 0xe662, 'index': 0},
    {'title': 'Board Member', 'iconName': 0xe661, 'index': 2},
    {'title': 'Business Center', 'iconName': 0xe660, 'index': 3},
  ];
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _scrollController = new ScrollController();
    _scrollController.addListener(() {
      if ((_scrollController.offset > 150.h && showSearch == 1) ||
          (_scrollController.offset < 150.h && showSearch == 0)) {
        return;
      }
      setState(() {
        showSearch = _scrollController.offset > 150.h ? 1 : 0;
      });
    });
  }

  @override
  BaseListProvider<BrandNewModel> newsListProvider =
      BaseListProvider<BrandNewModel>();
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<BaseListProvider<BrandNewModel>>(
              create: (_) => newsListProvider),
        ],
        child: Scaffold(
          backgroundColor: Colours.bg_color,
          body: DefaultTabController(
            length: 2,
            child: new NestedScrollView(
              controller: _scrollController,
              headerSliverBuilder: (context, bool innerScrolled) {
                return [
                  SliverAppBar(
                    pinned: true,
                    floating: false, // 不随着滑动隐藏标题
                    elevation: 0,
                    expandedHeight: Device.isAndroid ? 320.h : 300.h,
                    backgroundColor: Colours.app_main,
                    flexibleSpace: Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: ImageUtils.getAssetImage(
                                'dashboard/dashboard_top_bg',
                              ))),
                      child: FlexibleSpaceBar(
                        centerTitle: true,
                        title: showSearch == 1
                            ? Container(
                                alignment: Alignment.bottomCenter,
                                height: double.infinity,
                                padding: EdgeInsets.only(
                                    left: Dimens.gap_dp16,
                                    right: Dimens.gap_dp16,
                                    bottom: 40.h),
                                child: DashboardSearchLogWidget(
                                  callBack: () => NavigatorUtils.push(
                                      context, SearchRouter.searchCachePage),
                                ),
                              )
                            : Gaps.empty,
                        background: DashboardTopWidget(
                          itemIconArray: _itemIconArray,
                        ),
                      ),
                    ),
                    forceElevated: innerScrolled,
                    bottom: PreferredSize(
                        preferredSize: Size.fromHeight(45.h),
                        child: DashboardTobWidget(
                          tabController: _tabController,
                        )),
                  ),
                ];
              },
              body: TabBarView(
                controller: _tabController,
                children: <Widget>[
                  RecommendPage(
                    dashboardPagePresenter: _dashboardPagePresenter,
                  ),
                  NewsPage(
                    dashboardPagePresenter: _dashboardPagePresenter,
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  @override
  bool get wantKeepAlive => true;
}
