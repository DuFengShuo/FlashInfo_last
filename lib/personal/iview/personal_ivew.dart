import 'package:flashinfo/mvp/mvps.dart';
import 'package:flashinfo/personal/model/educations_bean.dart';
import 'package:flashinfo/personal/model/honors_bean.dart';
import 'package:flashinfo/personal/model/peoples_new_bean.dart';
import 'package:flashinfo/personal/model/person_work_bean.dart';
import 'package:flashinfo/personal/model/works_bean.dart';
import 'package:flashinfo/personal/provider/personal_provider.dart';
import 'package:flashinfo/provider/base_list_provider.dart';

abstract class PersonalDetialIMvpView implements IMvpView {
  PersonalProvider get personalProvider;
}

abstract class PersonalJobsIMvpView implements IMvpView {
  BaseListProvider<WorksModel> get personalJobsProvider;
}

abstract class PersonalDducationIMvpView implements IMvpView {
  BaseListProvider<EducationsModel> get personalDducationProvider;
}

abstract class PersonalHonorsIMvpView implements IMvpView {
  BaseListProvider<HonorsModel> get personalHonorsProvider;
}

abstract class PersonalColleaguesIMvpView implements IMvpView {
  BaseListProvider<Colleagues> get personalColleaguesProvider;
}



abstract class PersonalExperienceIMvpView implements IMvpView {
  BaseListProvider<WorkData> get personalExperienceProvider;
  PersonalExperienceCountProvider get personalExperienceCountProvider;

}