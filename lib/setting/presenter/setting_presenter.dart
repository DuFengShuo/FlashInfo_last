import 'package:flashinfo/mvp/base_page_presenter.dart';
import 'package:flashinfo/mvp/mvps.dart';
import 'package:flashinfo/mvp/status_model.dart';
import 'package:flashinfo/net/net.dart';
import 'package:flashinfo/routers/fluro_navigator.dart';

class SettingPresenter extends BasePagePresenter<IMvpView> {}

class FeedbackPresenter extends BasePagePresenter<IMvpView> {
  Future feedback(Map<String, String> params) {
    return requestNetwork<StatusModel>(Method.post,
        url: HttpApi.feedback,
        queryParameters: params,
        isShow: true, onSuccess: (StatusModel? model) {
      if (model != null) {
        if (model.status == 0) {
          NavigatorUtils.goBack(view.getContext());
        }
        if (model.message!.isEmpty) {
          view.showToast(model.message ?? '');
        }
      }
    }, onError: (_, __) {});
  }
}
