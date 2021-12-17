import 'package:flashinfo/mvp/base_page_presenter.dart';
import 'package:flashinfo/net/net.dart';
import 'package:flashinfo/personal/iview/personal_ivew.dart';
import 'package:flashinfo/personal/model/colleagues_bean.dart';
import 'package:flashinfo/personal/model/educations_bean.dart';
import 'package:flashinfo/personal/model/honors_bean.dart';
import 'package:flashinfo/personal/model/peoples_new_bean.dart';
import 'package:flashinfo/personal/model/person_work_bean.dart';
import 'package:flashinfo/personal/model/works_bean.dart';
import 'package:flashinfo/widgets/Layout/state_layout.dart';
import 'package:flutter/material.dart';

class PersonalJobsPresenter extends BasePagePresenter<PersonalJobsIMvpView> {
  int _page = 1;
  String personnelId = '';
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      onRefresh();
    });
  }

  Future getPersonalJobsList() {
    if (_page == 1) {
      view.personalJobsProvider.setStateType(StateType.listLayout);
    }
    final Map<String, dynamic> params = <String, dynamic>{};
    params['page'] = _page;
    return requestNetwork<WorksBean>(Method.get,
        url: HttpApi.works + '/$personnelId',
        queryParameters: params,
        isShow: false, onSuccess: (WorksBean? bean) {
      view.personalJobsProvider.setMetaModel(bean?.meta);
      if (bean != null && bean.worksList != null) {
        view.personalJobsProvider.setHasMore(bean.worksList?.length == 20);
        if (_page == 1) {
          view.personalJobsProvider.clear();
          if (bean.worksList!.isEmpty) {
            view.personalJobsProvider.setStateType(StateType.message);
          } else {
            view.personalJobsProvider.addAll(bean.worksList!);
          }
        } else {
          view.personalJobsProvider.addAll(bean.worksList!);
        }
      } else {
        /// 加载失败
        view.personalJobsProvider.setHasMore(false);
        view.personalJobsProvider.setStateType(StateType.message);
      }
    }, onError: (_, __) {
      view.personalJobsProvider.setHasMore(false);
      view.personalJobsProvider.setStateType(StateType.message);
    });
  }

  Future<void> onRefresh() async {
    _page = 1;
    await getPersonalJobsList();
  }

  Future loadMore() async {
    _page++;
    await getPersonalJobsList();
  }
}

class PersonalDducationPresenter
    extends BasePagePresenter<PersonalDducationIMvpView> {
  int _page = 1;
  String personnelId = '';
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      onRefresh();
    });
  }

  Future getPersonalDducationList() {
    if (_page == 1) {
      view.personalDducationProvider.setStateType(StateType.listLayout);
    }
    final Map<String, dynamic> params = <String, dynamic>{};
    params['page'] = _page;
    return requestNetwork<EducationsBean>(Method.get,
        url: HttpApi.educations + '/$personnelId',
        queryParameters: params,
        isShow: false, onSuccess: (EducationsBean? bean) {
      view.personalDducationProvider.setMetaModel(bean?.meta);
      if (bean != null && bean.list != null) {
        view.personalDducationProvider.setHasMore(bean.list?.length == 20);
        if (_page == 1) {
          view.personalDducationProvider.clear();
          if (bean.list!.isEmpty) {
            view.personalDducationProvider.setStateType(StateType.message);
          } else {
            view.personalDducationProvider.addAll(bean.list!);
          }
        } else {
          view.personalDducationProvider.addAll(bean.list!);
        }
      } else {
        /// 加载失败
        view.personalDducationProvider.setHasMore(false);
        view.personalDducationProvider.setStateType(StateType.message);
      }
    }, onError: (_, __) {
      view.personalDducationProvider.setHasMore(false);
      view.personalDducationProvider.setStateType(StateType.message);
    });
  }

  Future<void> onRefresh() async {
    _page = 1;
    await getPersonalDducationList();
  }

  Future loadMore() async {
    _page++;
    await getPersonalDducationList();
  }
}

class PersonalHonorsPresenter
    extends BasePagePresenter<PersonalHonorsIMvpView> {
  int _page = 1;
  String personnelId = '';
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      onRefresh();
    });
  }

  Future getPersonalHonorsList() {
    if (_page == 1) {
      view.personalHonorsProvider.setStateType(StateType.listLayout);
    }
    final Map<String, dynamic> params = <String, dynamic>{};
    params['page'] = _page;
    return requestNetwork<HonorsBean>(Method.get,
        url: HttpApi.honors + '/$personnelId',
        queryParameters: params,
        isShow: false, onSuccess: (HonorsBean? bean) {
      view.personalHonorsProvider.setMetaModel(bean?.meta);
      if (bean != null && bean.list != null) {
        view.personalHonorsProvider.setHasMore(bean.list?.length == 20);
        if (_page == 1) {
          view.personalHonorsProvider.clear();
          if (bean.list!.isEmpty) {
            view.personalHonorsProvider.setStateType(StateType.message);
          } else {
            view.personalHonorsProvider.addAll(bean.list!);
          }
        } else {
          view.personalHonorsProvider.addAll(bean.list!);
        }
      } else {
        /// 加载失败
        view.personalHonorsProvider.setHasMore(false);
        view.personalHonorsProvider.setStateType(StateType.message);
      }
    }, onError: (_, __) {
      view.personalHonorsProvider.setHasMore(false);
      view.personalHonorsProvider.setStateType(StateType.message);
    });
  }

  Future<void> onRefresh() async {
    _page = 1;
    await getPersonalHonorsList();
  }

  Future loadMore() async {
    _page++;
    await getPersonalHonorsList();
  }
}


//人员同事
class PersonalColleaguesPresenter
    extends BasePagePresenter<PersonalColleaguesIMvpView> {
  int _page = 1;
  String personnelId = '';
  @override
  void initState() {
    super.initState();
   // view.personalColleaguesProvider.setStateType(StateType.listLayout);
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      onRefresh();
    });
  }

  Future getPersonalColleaguesList() {
    view.personalColleaguesProvider.setStateType(StateType.listLayout);
    final Map<String, dynamic> params = <String, dynamic>{};
    params['page'] = _page;
    return requestNetwork<ColleaguesBean>(Method.get,
        url: HttpApi.peoplesCalleagues + '/$personnelId',
        queryParameters: params,
        isShow: false, onSuccess: (ColleaguesBean? bean) {

        //  view.personalColleaguesProvider.setMetaModel(bean?.meta);
          if (bean != null && bean.dataList != null) {
            // view.personalColleaguesProvider.setHasMore(bean.dataList.length == 20);
            //view.personalColleaguesProvider.clear();
            if (bean.dataList.isEmpty) {
              view.personalColleaguesProvider.setStateType(StateType.message);
            } else {
              view.personalColleaguesProvider.addAll(bean.dataList);
            }
            // if (_page == 1) {
            //   view.personalColleaguesProvider.clear();
            //   if (bean.dataList.isEmpty) {
            //     view.personalColleaguesProvider.setStateType(StateType.message);
            //   } else {
            //     view.personalColleaguesProvider.addAll(bean.dataList);
            //   }
            // } else {
            //   view.personalColleaguesProvider.addAll(bean.dataList);
            // }
          } else {
            /// 加载失败
            //view.personalColleaguesProvider.setHasMore(false);
            view.personalColleaguesProvider.setStateType(StateType.message);
          }
        }, onError: (_, __) {
         // view.personalColleaguesProvider.setHasMore(false);
          view.personalColleaguesProvider.setStateType(StateType.message);
        });
  }

  Future<void> onRefresh() async {
    _page = 1;
    await getPersonalColleaguesList();
  }

  Future loadMore() async {
    _page++;
    await getPersonalColleaguesList();
  }
}


class PersonalExperiencePresenter
    extends BasePagePresenter<PersonalExperienceIMvpView> {
  int _page = 1;
  String personnelId = '';
  int totalCount = 0;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      onRefresh();

    });
  }
  Future getPersonalExperienceList() {
    if (_page == 1) {
      view.personalExperienceProvider.setStateType(StateType.listLayout);
    }
    final Map<String, dynamic> params = <String, dynamic>{};
    params['page'] = _page;
    return requestNetwork<PersonWorkBean>(Method.get,
        url: HttpApi.peoplesWorks + '$personnelId',
        //url: HttpApi.peoplesWorks + 'Bq841L0E4d0O9K3l',
        queryParameters: params,
        isShow: false, onSuccess: (PersonWorkBean? bean) {
         // view.personalExperienceProvider.setMetaModel(bean?.meta);
          totalCount = bean!.total;
          view.personalExperienceCountProvider.setCount(totalCount);
          if (bean != null && bean.data != null) {
            // view.personalExperienceProvider.setHasMore(bean.data.length == 20);
            if (_page == 1) {
              view.personalExperienceProvider.clear();
              if (bean.data.isEmpty) {
                view.personalExperienceProvider.setStateType(StateType.message);
              } else {
                view.personalExperienceProvider.addAll(bean.data);
              }
            } else {
              view.personalExperienceProvider.addAll(bean.data);
            }
          } else {
            /// 加载失败
            view.personalExperienceProvider.setHasMore(false);
            view.personalExperienceProvider.setStateType(StateType.message);
          }
        }, onError: (_, __) {
          view.personalExperienceProvider.setHasMore(false);
          view.personalExperienceProvider.setStateType(StateType.message);
        });
  }

  Future<void> onRefresh() async {
    _page = 1;
    await getPersonalExperienceList();
  }

  Future loadMore() async {
    _page++;
    await getPersonalExperienceList();
  }
}