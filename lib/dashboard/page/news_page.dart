import 'package:flashinfo/dashboard/models/news_bean.dart';
import 'package:flashinfo/dashboard/presenter/dashboard_presenter.dart';
import 'package:flashinfo/dashboard/widgets/news_cell_widget.dart';
import 'package:flashinfo/provider/base_list_provider.dart';
import 'package:flashinfo/provider/common_provider.dart';
import 'package:flashinfo/res/resources.dart';
import 'package:flashinfo/routers/fluro_navigator.dart';
import 'package:flashinfo/util/device_utils.dart';
import 'package:flashinfo/util/other_utils.dart';
import 'package:flashinfo/widgets/my_refresh_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NewsPage extends StatelessWidget {
  const NewsPage({Key? key, required this.dashboardPagePresenter})
      : super(key: key);

  final DashboardPagePresenter dashboardPagePresenter;

  @override
  Widget build(BuildContext context) {
    return Consumer2<BaseListProvider<BrandNewModel>, CommonProvider>(
      builder: (_, provider, commonProvider, __) {
        return Padding(
            padding: EdgeInsets.only(
              top: Dimens.gap_v_dp8,
            ),
            child: DeerListView(
              key: const Key('news_list'),
              itemCount: provider.list.length,
              stateType: provider.stateType,
              hasMore: provider.hasMore,
              totalPages: provider.metaModel?.pagination?.totalPages ?? 1,
              onRefresh: dashboardPagePresenter.onRefreshNews,
              loadMore: dashboardPagePresenter.loadMoreNews,
              itemBuilder: (_, index) {
                final BrandNewModel model = provider.list[index];
                return NewsCellWidget(
                    newsModel: model,
                    onTap: () => _launchWebURL('', model.link ?? '', context));
              },
            ));
      },
    );
  }

  void _launchWebURL(String title, String url, BuildContext context) {
    if (Device.isMobile) {
      NavigatorUtils.goWebViewPage(context, title, url);
    } else {
      Utils.launchWebURL(url);
    }
  }
}
