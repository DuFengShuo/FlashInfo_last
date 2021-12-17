import 'package:flashinfo/brand/iview/brand_detail_iview.dart';
import 'package:flashinfo/brand/models/brand_bean.dart';
import 'package:flashinfo/brand/presenter/brand_detail_presenter.dart';
import 'package:flashinfo/brand/widget/brand_event_cell.dart';
import 'package:flashinfo/mvp/base_page.dart';
import 'package:flashinfo/mvp/power_presenter.dart';
import 'package:flashinfo/provider/base_list_provider.dart';
import 'package:flashinfo/res/colors.dart';
import 'package:flashinfo/res/dimens.dart';
import 'package:flashinfo/widgets/my_app_bar.dart';
import 'package:flashinfo/widgets/my_refresh_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BandEventListPage extends StatefulWidget {
  final String brandId;

  const BandEventListPage({Key? key, required this.brandId}) : super(key: key);

  @override
  _BandEventListPageState createState() => _BandEventListPageState();
}

class _BandEventListPageState extends State<BandEventListPage>
    with BasePageMixin<BandEventListPage, PowerPresenter>
    implements BrandEventIMvpView {
  @override
  BaseListProvider<EventModel> brandEventProvider =
      BaseListProvider<EventModel>();

  late BrandEventsPresenter _brandEventsPresenter;

  @override
  PowerPresenter createPresenter() {
    final PowerPresenter powerPresenter = PowerPresenter<dynamic>(this);
    _brandEventsPresenter = BrandEventsPresenter();
    _brandEventsPresenter.brandId = widget.brandId;
    powerPresenter.requestPresenter([_brandEventsPresenter]);
    return powerPresenter;
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<BaseListProvider<EventModel>>(
              create: (_) => brandEventProvider),
        ],
        child: Scaffold(
            backgroundColor: Colours.bg_color,
            appBar: const MyAppBar(
              centerTitle: 'Events',
            ),
            body: Consumer<BaseListProvider<EventModel>>(
                builder: (_, provider, __) {
              return Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: Dimens.gap_dp16, vertical: Dimens.gap_v_dp16),
                child: DeerListView(
                  key: const Key('event_list'),
                  itemCount: provider.list.length,
                  stateType: provider.stateType,
                  onRefresh: _brandEventsPresenter.onRefresh,
                  loadMore: _brandEventsPresenter.loadMore,
                  hasMore: provider.hasMore,
                  itemBuilder: (_, index) {
                    final EventModel eventModel =
                        brandEventProvider.list[index];
                    return EventCellWidget(
                      model: eventModel,
                    );
                  },
                ),
              );
            })));
  }
}
