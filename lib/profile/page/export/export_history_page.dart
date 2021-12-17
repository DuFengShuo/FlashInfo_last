import 'package:flashinfo/mvp/base_page.dart';
import 'package:flashinfo/mvp/power_presenter.dart';
import 'package:flashinfo/profile/iview/export_iview.dart';
import 'package:flashinfo/profile/model/export_bean.dart';
import 'package:flashinfo/profile/presenter/export_presenter.dart';
import 'package:flashinfo/profile/profile_router.dart';
import 'package:flashinfo/provider/base_list_provider.dart';
import 'package:flashinfo/res/colors.dart';
import 'package:flashinfo/res/dimens.dart';
import 'package:flashinfo/routers/fluro_navigator.dart';
import 'package:flashinfo/widgets/my_app_bar.dart';
import 'package:flashinfo/widgets/my_refresh_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'export_history_item.dart';

class ExportHistoryPage extends StatefulWidget {
  const ExportHistoryPage({Key? key}) : super(key: key);

  @override
  _ExportHistoryPageState createState() => _ExportHistoryPageState();
}

class _ExportHistoryPageState extends State<ExportHistoryPage>
    with BasePageMixin<ExportHistoryPage, PowerPresenter>
    implements ExportIMvpView {
  @override
  BaseListProvider<ExportModel> exportListProvider =
      BaseListProvider<ExportModel>();
  late ExportPresenter _exportPresenter;
  @override
  PowerPresenter createPresenter() {
    final PowerPresenter powerPresenter = PowerPresenter<dynamic>(this);
    _exportPresenter = ExportPresenter();
    powerPresenter.requestPresenter([_exportPresenter]);
    return powerPresenter;
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback(
      (_) async {
        _exportPresenter.onRefresh();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<BaseListProvider<ExportModel>>(
            create: (_) => exportListProvider),
      ],
      child: Consumer<BaseListProvider<ExportModel>>(
        builder: (_, provider, __) {
          return Scaffold(
            backgroundColor: Colours.bg_color,
            appBar: const MyAppBar(
              centerTitle: 'Export History',
            ),
            body: Padding(
              padding: EdgeInsets.symmetric(vertical: Dimens.gap_v_dp10),
              child: DeerListView(
                key: const Key('export_istory'),
                itemCount: provider.list.length,
                stateType: provider.stateType,
                onRefresh: _exportPresenter.onRefresh,
                loadMore: _exportPresenter.loadMore,
                hasMore: provider.hasMore,
                totalPages: provider.metaModel?.pagination?.totalPages ?? 1,
                itemBuilder: (_, index) {
                  final ExportModel? model = provider.list[index];
                  return GestureDetector(
                    onTap: () {
                      NavigatorUtils.pushResult(
                          context, ProfileRouter.exportDetailsPage, (value) {
                        print(value);
                      }, arguments: model);
                    },
                    child: ExportHistoryItem(
                      exportModel: model,
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
