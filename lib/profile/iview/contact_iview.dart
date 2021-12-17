import 'package:flashinfo/mvp/mvps.dart';
import 'package:flashinfo/profile/model/people_unlock_bean.dart';
import 'package:flashinfo/provider/base_list_provider.dart';

abstract class ContactIMvpView implements IMvpView {
  BaseListProvider<PeopleUnlockModel> get peopleUnlocProvider;
}
