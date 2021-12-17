import 'package:flashinfo/login/model/user_info_model.dart';
import 'package:flashinfo/mvp/base_page_presenter.dart';
import 'package:flashinfo/net/dio_utils.dart';
import 'package:flashinfo/net/net.dart';
import 'package:flashinfo/profile/iview/profile_iview.dart';

class ProfilePresenter extends BasePagePresenter<ProfileIMvpView> {
  @override
  void initState() {
    super.initState();
  }

  Future userInfo() {
    return requestNetwork<UserInfoModel>(Method.get,
        url: HttpApi.userInfo,
        isShow: false,
        onSuccess: (UserInfoModel? model) {});
  }
}
