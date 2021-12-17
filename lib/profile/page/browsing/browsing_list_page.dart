import 'package:flashinfo/company/company_rouder.dart';
import 'package:flashinfo/mvp/base_page.dart';
import 'package:flashinfo/mvp/power_presenter.dart';
import 'package:flashinfo/personal/personal_router.dart';
import 'package:flashinfo/product/product_router.dart';
import 'package:flashinfo/profile/iview/browsing_iview.dart';
import 'package:flashinfo/profile/model/browsing_bean.dart';
import 'package:flashinfo/profile/presenter/browsing_presenter.dart';
import 'package:flashinfo/profile/widget/browsing_item.dart';
import 'package:flashinfo/provider/base_list_provider.dart';
import 'package:flashinfo/routers/fluro_navigator.dart';
import 'package:flashinfo/widgets/my_refresh_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BrowsingListPage extends StatefulWidget {
  const BrowsingListPage({Key? key, required this.indexType}) : super(key: key);
  final int indexType;
  @override
  _BrowsingListPageState createState() => _BrowsingListPageState();
}

class _BrowsingListPageState extends State<BrowsingListPage>
    with
        AutomaticKeepAliveClientMixin,
        BasePageMixin<BrowsingListPage, PowerPresenter>
    implements BrowsingIMvpView {
  @override
  BaseListProvider<BrowsingModel> browsingProvider =
      BaseListProvider<BrowsingModel>();

  late BrowsingPresenter _browsingPresenter;
  @override
  PowerPresenter createPresenter() {
    final PowerPresenter powerPresenter = PowerPresenter<dynamic>(this);
    _browsingPresenter = BrowsingPresenter();
    _browsingPresenter.indexType = widget.indexType;
    powerPresenter.requestPresenter([_browsingPresenter]);
    return powerPresenter;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<BaseListProvider<BrowsingModel>>(
            create: (_) => browsingProvider),
      ],
      child: Consumer<BaseListProvider<BrowsingModel>>(
        builder: (_, provider, __) {
          return DeerListView(
            key: const Key('browsing_list'),
            itemCount: provider.list.length,
            stateType: provider.stateType,
            onRefresh: _browsingPresenter.onRefresh,
            loadMore: _browsingPresenter.loadMore,
            hasMore: provider.hasMore,
            totalPages: provider.metaModel?.pagination?.totalPages ?? 1,
            itemBuilder: (_, index) {
              final BrowsingModel model = provider.list[index];
              return BrowsingItem(
                  browsingModel: model,
                  onTabItem: () {
                    provider.list.removeAt(index);
                    provider.insert(0, model);
                    switch (widget.indexType) {
                      case 0:
                        NavigatorUtils.push(context,
                            '${CompanyRouder.companyDetailsPage}?companyId=${model.modelId}');
                        break;
                      case 1:
                        NavigatorUtils.push(context,
                            '${PersonalRouter.personalDetailsPage}?personalId=${model.modelId}');
                        break;
                      case 2:
                        NavigatorUtils.push(context,
                            '${ProductRouter.productDetailsPage}?productId=${model.modelId}');
                        break;
                      default:
                    }
                  });
            },
          );
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
