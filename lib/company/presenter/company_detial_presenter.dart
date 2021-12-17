// ignore: import_of_legacy_library_into_null_safe
import 'package:data_finder/data_finder.dart';
import 'package:flashinfo/company/iview/company_detail_iview.dart';
import 'package:flashinfo/company/models/company_bean.dart';
import 'package:flashinfo/company/models/company_contact_model.dart';
import 'package:flashinfo/company/models/company_details_bean.dart';
import 'package:flashinfo/mvp/base_page_presenter.dart';
import 'package:flashinfo/net/net.dart';
import 'package:flashinfo/personal/model/peoples_bean.dart';
import 'package:flashinfo/util/firedata_analytics.dart';
import 'package:flashinfo/widgets/Layout/state_layout.dart';
import 'package:flutter/material.dart';

class CompanyDetailPresenter extends BasePagePresenter<CompanyDetialIMvpView> {
  int _companyPage = 1;
  int _peopleContactPage = 1;
  String companyId = '';
  int contact_limit = 0; //0公司所有人员 1公司关键联系人

  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback(
      (_) {
        //Company_PageView
        sendAnalyticsEvent('Company_PageView'); //事件统计
      },
    );
  }

  Future<void> sendAnalyticsEvent(String eventName) async {
    FireBaseAnalyticUtil.analytics.logEvent(name: '$eventName', parameters: {
      'name': '$eventName',
    }).then((value) {
      // print('首页统计事件发送成功');
    });
    FireBaseAnalyticUtil.analytics.logLogin().then((value) {
      // print('事件统计登录了');
    });

    DataFinder.onEventV3(
      '$eventName',
    );
  }

  // 请求公司详情数据
  Future getCompanyDetail(String companyId) {
    return requestNetwork<CompanyDetailsBean>(Method.get,
        url: HttpApi.companyList + '/$companyId',
        isShow: false, onSuccess: (CompanyDetailsBean? model) {
      if (model != null) {
        if (model.message!.isNotEmpty) {
          view.showToast(model.message ?? '');
        }
        // view
        //     .getContext()
        //     .read<UserInfoProvider>()
        //     .updateUserBrowsingCount(model.browsingCount);
        view.companyProvider.setCompanyDetailBean(model);
      } else {
        view.companyProvider.setStateType(StateType.company);
      }
    }, onError: (_, __) {
      view.companyProvider.setStateType(StateType.company);
    });
  }

  // 请求公司详情数据
  // Future getCompanySubsidiary(String companyId) {
  //   final Map<String, dynamic> params = <String, dynamic>{};
  //   params['company_id'] = companyId;

  //   final List<Map<String, String>> subsidiaryInfo = [
  //     {'name': 'branch', 'count': '3'},
  //     {'name': 'albums', 'count': '6'},
  //     {'name': 'similar_companies', 'count': '3'},
  //     {'name': 'news', 'count': '3'},
  //     {'name': 'funding_rounds', 'count': '3'},
  //     {'name': 'investors', 'count': '3'},
  //     {'name': 'investments', 'count': '3'},
  //   ];
  //   params['subsidiary_info'] = convert.json.encode(subsidiaryInfo);
  //   return requestNetwork<CompanySubsidiaryModel>(Method.post,
  //       url: HttpApi.companySubsidiary,
  //       params: params,
  //       isShow: false, onSuccess: (CompanySubsidiaryModel? model) {
  //     if (model != null) {
  //       if (model.message!.isNotEmpty) {
  //         view.showToast(model.message ?? '');
  //       }
  //       view.companyProvider.setCompanySubsidiaryModel(model);
  //     } else {}
  //   }, onError: (_, __) {});
  // }

  // 请求公司列表
  Future getCompanyList() {
    if (_companyPage == 1) {
      view.companyListProvider.setStateType(StateType.listLayout);
    }
    final Map<String, dynamic> params = <String, dynamic>{};
    params['p_id'] = companyId;
    params['page'] = _companyPage;
    return requestNetwork<CompanyBean>(Method.get,
        url: HttpApi.companyList,
        queryParameters: params,
        isShow: false, onSuccess: (CompanyBean? bean) {
      view.companyListProvider.setMetaModel(bean?.meta);
      if (bean != null && bean.list != null) {
        view.companyListProvider.setHasMore(bean.list?.length == 20);
        if (_companyPage == 1) {
          view.companyListProvider.clear();
          if (bean.list!.isEmpty) {
            view.companyListProvider.setStateType(StateType.company);
          } else {
            view.companyListProvider.addAll(bean.list!);
          }
        } else {
          view.companyListProvider.addAll(bean.list!);
        }
      } else {
        /// 加载失败
        view.companyListProvider.setHasMore(false);
        view.companyListProvider.setStateType(StateType.company);
      }
    }, onError: (_, __) {
      view.companyListProvider.setHasMore(false);
      view.companyListProvider.setStateType(StateType.company);
    });
  }

  Future<void> companyOnRefresh() async {
    _companyPage = 1;
    await getCompanyList();
  }

  Future companyLoadMore() async {
    _companyPage++;
    await getCompanyList();
  }

  // 请求公司列表
  Future getCompanyContact() {
    final Map<String, dynamic> params = <String, dynamic>{};
    params['company_id'] = companyId;
    return requestNetwork<CompanyContactModel>(Method.post,
        url: HttpApi.companyContact,
        params: params,
        isShow: false, onSuccess: (CompanyContactModel? bean) {
      if (bean != null && (bean.email!.isNotEmpty || bean.mobile!.isNotEmpty)) {
        view.companyProvider.setCompanyContactModel(bean);
      } else {
        view.companyProvider.setStateType(StateType.company);
      }
    }, onError: (_, __) {
      view.companyProvider.setStateType(StateType.company);
    });
  }

  // 获取人员联系方式
  Future getPeopleContact() {
    if (_peopleContactPage == 1) {
      view.peopleContactProvider.setStateType(StateType.listLayout);
    }
    final Map<String, dynamic> params = <String, dynamic>{};
    params['company_id'] = companyId;
    params['page'] = _peopleContactPage;

    return requestNetwork<PeoplesBean>(Method.post,
        url: HttpApi.peopleContact,
        params: params,
        isShow: false, onSuccess: (PeoplesBean? bean) {
      view.peopleContactProvider.setMetaModel(bean?.meta);
      if (bean != null && bean.list != null) {
        view.peopleContactProvider.setHasMore(bean.list?.length == 20);
        if (_companyPage == 1) {
          view.peopleContactProvider.clear();
          if (bean.list!.isEmpty) {
            view.peopleContactProvider.setStateType(StateType.personnel);
          } else {
            view.peopleContactProvider.addAll(bean.list!);
          }
        } else {
          view.peopleContactProvider.addAll(bean.list!);
        }
      } else {
        /// 加载失败
        view.peopleContactProvider.setHasMore(false);
        view.peopleContactProvider.setStateType(StateType.personnel);
      }
    }, onError: (_, __) {
      /// 加载失败
      view.peopleContactProvider.setHasMore(false);
      view.peopleContactProvider.setStateType(StateType.personnel);
    });
  }

  Future<void> peopleContactOnRefresh() async {
    _peopleContactPage = 1;
    await getPeopleContact();
  }

  Future peopleContactLoadMore() async {
    _peopleContactPage++;
    await getPeopleContact();
  }
}
