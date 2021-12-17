import 'package:flashinfo/mvp/base_page_presenter.dart';
import 'package:flashinfo/net/net.dart';
import 'package:flashinfo/profile/iview/export_iview.dart';
import 'package:flashinfo/profile/model/export_bean.dart';
import 'package:flashinfo/profile/page/export/export_page.dart';
import 'package:flashinfo/provider/user_info_provider.dart';
import 'package:flashinfo/widgets/Layout/state_layout.dart';
import 'package:provider/provider.dart';

class ExportPresenter extends BasePagePresenter<ExportIMvpView> {
  int _page = 1;
  @override
  void initState() {
    super.initState();
  }

  Future exportHistory() {
    if (_page == 1) {
      view.exportListProvider.setStateType(StateType.listLayout);
    }
    final Map<String, dynamic> params = <String, dynamic>{};
    params['page'] = _page.toString();
    return requestNetwork<ExportBean>(Method.get,
        url: HttpApi.exportIndex,
        params: params,
        isShow: false, onSuccess: (ExportBean? bean) {
      if (bean != null && bean.list != null) {
        view.exportListProvider.setHasMore(bean.list?.length == 20);
        if (_page == 1) {
          view.exportListProvider.clear();
          if (bean.list!.isEmpty) {
            view.exportListProvider.setStateType(StateType.exportHistory);
          } else {
            view.exportListProvider.addAll(bean.list!);
          }
        } else {
          view.exportListProvider.addAll(bean.list!);
        }
      } else {
        /// 加载失败
        view.exportListProvider.setHasMore(false);
        view.exportListProvider.setStateType(StateType.exportHistory);
      }
    }, onError: (_, __) {
      view.exportListProvider.setHasMore(false);
      view.exportListProvider.setStateType(StateType.exportHistory);
    });
  }

  Future<void> onRefresh() async {
    _page = 1;
    await exportHistory();
  }

  Future<void> loadMore() async {
    _page++;
    await exportHistory();
  }

  Future exportStore(ExportStoreParams? params,
      {Function(ExportModel?)? success}) {
    return requestNetwork<ExportModel>(Method.post,
        url: HttpApi.export,
        params: params!.toJson(),
        isShow: true, onSuccess: (ExportModel? bean) async {
      if (bean != null) {
        if (bean.message!.isNotEmpty) {
          view.showToast(bean.message ?? '');
        }
        await view
            .getContext()
            .read<UserInfoProvider>()
            .setVipData(bean.vipData);
        success!(bean);
      } else {
        success!(null);
      }
    }, onError: (_, __) {
      success!(null);
    });
  }
}
