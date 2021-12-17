// ignore: import_of_legacy_library_into_null_safe
import 'package:data_finder/data_finder.dart';
import 'package:flashinfo/brand/models/brand_list_bean.dart';
import 'package:flashinfo/brand/widget/brand_search_list_cell.dart';
import 'package:flashinfo/dashboard/presenter/dashboard_presenter.dart';
import 'package:flashinfo/provider/base_list_provider.dart';
import 'package:flashinfo/provider/common_provider.dart';
import 'package:flashinfo/res/resources.dart';
import 'package:flashinfo/util/firedata_analytics.dart';
import 'package:flashinfo/widgets/my_refresh_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RecommendPage extends StatefulWidget {
  const RecommendPage({Key? key, required this.dashboardPagePresenter})
      : super(key: key);
  final DashboardPagePresenter dashboardPagePresenter;

  @override
  _RecommendPageState createState() => _RecommendPageState();
}

class _RecommendPageState extends State<RecommendPage>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      widget.dashboardPagePresenter.getRecommendList();
      _sendAnalyticsEvent();
    });
  }

  Future<void> _sendAnalyticsEvent() async {
    FireBaseAnalyticUtil.analytics.logEvent(name: 'recommend', parameters: {
      'name': 'recommend',
    }).then((value) {
      print('首页推荐页面');
    });
    DataFinder.onEventV3('news_show', params: <String, dynamic>{
      'params1': 'value1',
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Consumer<CommonProvider>(
      builder: (_, provider, __) {
        final BaseListProvider<BrandItemModel>? recompanyListProvider =
            provider.recompanyListProvider;
        return Padding(
          padding: EdgeInsets.only(
            top: Dimens.gap_v_dp8,
          ),
          child: DeerListView(
            key: const Key('news_list'),
            itemCount: recompanyListProvider!.list.length,
            stateType: recompanyListProvider.stateType,
            hasMore: recompanyListProvider.hasMore,
            totalPages:
                recompanyListProvider.metaModel?.pagination?.totalPages ?? 1,
            onRefresh: widget.dashboardPagePresenter.onRefreshCompany,
            loadMore: widget.dashboardPagePresenter.loadMoreCompany,
            itemBuilder: (_, index) {
              final BrandItemModel model = recompanyListProvider.list[index];
              return Padding(
                padding: EdgeInsets.only(
                    left: Dimens.gap_dp16,
                    right: Dimens.gap_dp16,
                    bottom: Dimens.gap_dp8),
                child: BrandSearchListCell(
                    index: index, highlightText: '', model: model),
              );
            },
          ),
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
