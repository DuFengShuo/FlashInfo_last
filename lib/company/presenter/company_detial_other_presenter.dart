import 'package:flashinfo/company/iview/company_detail_iview.dart';
import 'package:flashinfo/company/models/albums_bean.dart';
import 'package:flashinfo/company/models/company_bean.dart';
import 'package:flashinfo/company/models/company_detail_model.dart';
import 'package:flashinfo/company/models/company_details_bean.dart';
import 'package:flashinfo/company/models/finance_rounds_bean.dart';
import 'package:flashinfo/company/models/investments_bean.dart';
import 'package:flashinfo/company/models/investors_bean.dart';
import 'package:flashinfo/company/models/unlock_contact_model.dart';
import 'package:flashinfo/company/widget/details/gallery_example_item.dart';
import 'package:flashinfo/dashboard/models/news_bean.dart';
import 'package:flashinfo/mvp/base_page_presenter.dart';
import 'package:flashinfo/net/net.dart';
import 'package:flashinfo/personal/model/peoples_bean.dart';
import 'package:flashinfo/product/model/products_bean.dart';
import 'package:flashinfo/provider/user_info_provider.dart';
import 'package:flashinfo/widgets/Layout/state_layout.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CompanyEmployeePresenter
    extends BasePagePresenter<CompanyEmployeeIMvpView> {
  int _page = 1;
  String companyId = '';
  int contactLimit = 0; //0公司所有人员 1公司关键联系人
  @override
  void initState() {
    super.initState();
  }

  // 请求公司人员列表
  Future getCompanyPeroleList() {
    if (_page == 1) {
      view.employeePeopleProvider.setStateType(StateType.listLayout);
    }
    final Map<String, dynamic> params = <String, dynamic>{};
    // params['company_id'] = companyId;
    params['page'] = _page;
    params['only_contact'] = contactLimit;
    return requestNetwork<PeoplesBean>(Method.post,
        url: HttpApi.brandPeople + companyId,
        queryParameters: params,
        isShow: false, onSuccess: (PeoplesBean? bean) {
      view.employeePeopleProvider.setMetaModel(bean?.meta);
      if (bean != null && bean.list != null) {
        print(bean.list!.length);
        view.employeePeopleProvider.setHasMore(bean.list?.length == 30);
        if (_page == 1) {
          view.employeePeopleProvider.clear();
          if (bean.list!.isEmpty) {
            view.employeePeopleProvider.setStateType(StateType.personnel);
          } else {
            view.employeePeopleProvider.addAll(bean.list!);
          }
        } else {
          view.employeePeopleProvider.addAll(bean.list!);
        }
      } else {
        /// 加载失败
        view.employeePeopleProvider.setHasMore(false);
        view.employeePeopleProvider.setStateType(StateType.personnel);
      }
    }, onError: (_, __) {
      view.employeePeopleProvider.setHasMore(false);
      view.employeePeopleProvider.setStateType(StateType.personnel);
    });
  }

  Future<void> onRefresh() async {
    _page = 1;
    await getCompanyPeroleList();
  }

  Future loadMore() async {
    _page++;
    await getCompanyPeroleList();
  }
}

class CompanyProductsPresenter
    extends BasePagePresenter<CompanyProductsIMvpView> {
  int _page = 1;
  String companyId = '';
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      onRefresh();
    });
  }

  // 请求公司产品
  Future getCompanyProductsList() {
    if (_page == 1) {
      view.companyProductsProvider.setStateType(StateType.listLayout);
    }
    final Map<String, dynamic> params = <String, dynamic>{};
    //  params['company_id'] = companyId;
    params['page'] = _page;
    return requestNetwork<ProductsBean>(Method.post,
        url: HttpApi.brandProduct + companyId,
        queryParameters: params,
        isShow: false, onSuccess: (ProductsBean? bean) {
      view.companyProductsProvider.setMetaModel(bean?.meta);
      if (bean != null && bean.list != null) {
        view.companyProductsProvider.setHasMore(bean.list?.length == 30);
        if (_page == 1) {
          view.companyProductsProvider.clear();
          if (bean.list!.isEmpty) {
            view.companyProductsProvider.setStateType(StateType.personnel);
          } else {
            view.companyProductsProvider.addAll(bean.list!);
          }
        } else {
          view.companyProductsProvider.addAll(bean.list!);
        }
      } else {
        /// 加载失败
        view.companyProductsProvider.setHasMore(false);
        view.companyProductsProvider.setStateType(StateType.personnel);
      }
    }, onError: (_, __) {
      view.companyProductsProvider.setHasMore(false);
      view.companyProductsProvider.setStateType(StateType.personnel);
    });
  }

  Future<void> onRefresh() async {
    _page = 1;
    await getCompanyProductsList();
  }

  Future loadMore() async {
    _page++;
    await getCompanyProductsList();
  }
}

class CompanyAlbumsPresenter extends BasePagePresenter<CompanyAlbumsIMvpView> {
  int _page = 1;
  String companyId = '';
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      onRefresh();
    });
  }

  Future getCompanyAlbumsList() async {
    if (_page == 1) {
      view.companyAlbumsProvider.setStateType(StateType.listLayout);
    }
    final Map<String, dynamic> params = <String, dynamic>{};
    //  params['related_id'] = companyId;
    params['page'] = _page;
    params['per_page'] = 100;
    return requestNetwork<AlbumsBean>(Method.post,
        url: HttpApi.brandPhotos + companyId,
        params: params,
        isShow: true, onSuccess: (AlbumsBean? bean) {
      view.companyAlbumsProvider.setMetaModel(bean?.meta);
      if (bean != null && bean.list != null) {
        view.companyAlbumsProvider.setHasMore(bean.list?.length == 20);
        if (_page == 1) {
          view.companyAlbumsProvider.clear();
          if (bean.list!.isEmpty) {
            view.companyAlbumsProvider.setStateType(StateType.personnel);
          } else {
            view.companyAlbumsProvider.addAll(bean.list!);
          }
        } else {
          view.companyAlbumsProvider.addAll(bean.list!);
        }
        view.galleryItems.clear();
        view.companyAlbumsProvider.list.forEach((AlbumsModel model) {
          view.galleryItems.add(
            GalleryExampleItem(
              id: model.id.toString(),
              resource: model.logo.toString(),
            ),
          );
        });
      } else {
        /// 加载失败
        view.companyAlbumsProvider.setHasMore(false);
        view.companyAlbumsProvider.setStateType(StateType.personnel);
      }
    }, onError: (_, __) {
      view.companyAlbumsProvider.setHasMore(false);
      view.companyAlbumsProvider.setStateType(StateType.personnel);
    });
  }

  Future<void> onRefresh() async {
    _page = 1;
    await getCompanyAlbumsList();
  }

  Future loadMore() async {
    _page++;
    await getCompanyAlbumsList();
  }
}

class CompanyNewsPresenter extends BasePagePresenter<CompanyNewsIMvpView> {
  int _page = 1;
  String companyId = '';
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      onRefresh();
    });
  }

  // 请求公司产品
  Future getCompanyNewsList() {
    if (_page == 1) {
      view.companyNewsProvider.setStateType(StateType.listLayout);
    }
    final Map<String, dynamic> params = <String, dynamic>{};
    params['page'] = _page;
    return requestNetwork<NewsBean>(Method.post,
        url: HttpApi.brandNews + companyId,
        queryParameters: params,
        isShow: false, onSuccess: (NewsBean? bean) {
      view.companyNewsProvider.setMetaModel(bean?.meta);
      if (bean != null && bean.news != null) {
        view.companyNewsProvider.setHasMore(bean.news?.length == 20);
        if (_page == 1) {
          view.companyNewsProvider.clear();
          if (bean.news!.isEmpty) {
            view.companyNewsProvider.setStateType(StateType.personnel);
          } else {
            view.companyNewsProvider.addAll(bean.news ?? []);
          }
        } else {
          view.companyNewsProvider.addAll(bean.news ?? []);
        }
      } else {
        /// 加载失败
        view.companyNewsProvider.setHasMore(false);
        view.companyNewsProvider.setStateType(StateType.personnel);
      }
    }, onError: (_, __) {
      view.companyNewsProvider.setHasMore(false);
      view.companyNewsProvider.setStateType(StateType.personnel);
    });
  }

  Future<void> onRefresh() async {
    _page = 1;
    await getCompanyNewsList();
  }

  Future loadMore() async {
    _page++;
    await getCompanyNewsList();
  }
}

class CompanyCommandPresenter
    extends BasePagePresenter<CompanyCommandIMvpView> {
  int _page = 1;
  String companyId = '';
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      onRefresh();
    });
  }

  Future getCompanyCommandList() {
    if (_page == 1) {
      view.companyCommandProvider.setStateType(StateType.listLayout);
    }
    final Map<String, dynamic> params = <String, dynamic>{};
    params['company_id'] = companyId;
    params['page'] = _page;
    return requestNetwork<CompanyBean>(Method.post,
        url: HttpApi.similarCompany,
        params: params,
        isShow: false, onSuccess: (CompanyBean? bean) {
      view.companyCommandProvider.setMetaModel(bean?.meta);
      if (bean != null && bean.list != null) {
        view.companyCommandProvider.setHasMore(bean.list?.length == 20);
        if (_page == 1) {
          view.companyCommandProvider.clear();
          if (bean.list!.isEmpty) {
            view.companyCommandProvider.setStateType(StateType.personnel);
          } else {
            view.companyCommandProvider.addAll(bean.list!);
          }
        } else {
          view.companyCommandProvider.addAll(bean.list!);
        }
      } else {
        /// 加载失败
        view.companyCommandProvider.setHasMore(false);
        view.companyCommandProvider.setStateType(StateType.personnel);
      }
    }, onError: (_, __) {
      view.companyCommandProvider.setHasMore(false);
      view.companyCommandProvider.setStateType(StateType.personnel);
    });
  }

  Future<void> onRefresh() async {
    _page = 1;
    await getCompanyCommandList();
  }

  Future loadMore() async {
    _page++;
    await getCompanyCommandList();
  }
}

class CommentStoreParams {
  int? type;
  int? companyRelationship;
  String? relatedId;
  String? title;
  String? comments;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = <String, dynamic>{};
    map['type'] = type;
    map['company_relationship'] = companyRelationship;
    map['related_id'] = relatedId;
    map['title'] = title;
    map['comments'] = comments;
    return map;
  }
}

class CompanyReviewsPresenter
    extends BasePagePresenter<CompanyReviewsIMvpView> {
  int _page = 1;
  String relatedId = '';
  String pageType = 'company';
  @override
  void initState() {
    super.initState();
  }

  Future getCompanyReviewsList() {
    if (_page == 1) {
      view.companyReviewsProvider.setStateType(StateType.listLayout);
    }
    final Map<String, dynamic> params = <String, dynamic>{};
    // params['related_id'] = relatedId;
    params['type'] = pageType;
    params['page'] = _page;
    return requestNetwork<Reviews>(Method.post,
        url: HttpApi.commentIndex + '/$relatedId',
        params: params,
        isShow: false, onSuccess: (Reviews? bean) {
      view.companyReviewsProvider.setMetaModel(bean?.meta);
      if (bean != null && bean.data != null) {
        view.companyReviewsProvider.setHasMore(bean.data?.length == 20);
        if (_page == 1) {
          view.companyReviewsProvider.clear();
          if (bean.data!.isEmpty) {
            view.companyReviewsProvider.setStateType(StateType.personnel);
          } else {
            view.companyReviewsProvider.addAll(bean.data!);
          }
        } else {
          view.companyReviewsProvider.addAll(bean.data!);
        }
      } else {
        /// 加载失败
        view.companyReviewsProvider.setHasMore(false);
        view.companyReviewsProvider.setStateType(StateType.personnel);
      }
    }, onError: (_, __) {
      view.companyReviewsProvider.setHasMore(false);
      view.companyReviewsProvider.setStateType(StateType.personnel);
    });
  }

  Future<void> onRefresh() async {
    _page = 1;
    await getCompanyReviewsList();
  }

  Future loadMore() async {
    _page++;
    await getCompanyReviewsList();
  }

  Future commentStore(
      CommentStoreParams commentStoreParams, Function(ReviewsModel?) success) {
    return requestNetwork<ReviewsModel>(Method.post,
        url: HttpApi.commentStore,
        params: commentStoreParams.toJson(),
        isShow: false, onSuccess: (ReviewsModel? model) {
      success(model);
      //
      // if (model != null) {
      //   if (model.message!.isNotEmpty) {
      //     view.showToast(model.message ?? '');
      //   }
      // } else {}
    }, onError: (_, __) {});
  }
}

class CompanyFinanceRoundsPresenter
    extends BasePagePresenter<CompanyFinanceRoundsIMvpView> {
  int _page = 1;
  String companyId = '';

  @override
  void initState() {
    super.initState();
  }

  Future getCompanyFinanceRoundsList() {
    if (_page == 1) {
      view.companyFinanceRoundsProvider.setStateType(StateType.listLayout);
    }
    final Map<String, dynamic> params = <String, dynamic>{};
    params['company_id'] = companyId;
    params['per_page'] = 100;
    return requestNetwork<FinanceRoundsBean>(Method.post,
        url: HttpApi.companyFinanceRounds,
        params: params,
        isShow: false, onSuccess: (FinanceRoundsBean? bean) {
      print(bean?.message);
      view.companyFinanceRoundsProvider.setMetaModel(bean?.meta);
      if (bean != null && bean.list != null) {
        view.companyFinanceRoundsProvider.setHasMore(bean.list?.length == 20);
        if (_page == 1) {
          view.companyFinanceRoundsProvider.clear();
          if (bean.list!.isEmpty) {
            view.companyFinanceRoundsProvider.setStateType(StateType.personnel);
          } else {
            view.companyFinanceRoundsProvider.addAll(bean.list!);
          }
        } else {
          view.companyFinanceRoundsProvider.addAll(bean.list!);
        }
      } else {
        /// 加载失败
        view.companyFinanceRoundsProvider.setHasMore(false);
        view.companyFinanceRoundsProvider.setStateType(StateType.personnel);
      }
    }, onError: (_, __) {
      view.companyFinanceRoundsProvider.setHasMore(false);
      view.companyFinanceRoundsProvider.setStateType(StateType.personnel);
    });
  }

  Future<void> onRefresh() async {
    _page = 1;
    await getCompanyFinanceRoundsList();
  }

  Future loadMore() async {
    _page++;
    await getCompanyFinanceRoundsList();
  }
}

class CompanyInvestmentsPresenter
    extends BasePagePresenter<CompanyInvestmentsIMvpView> {
  int _page = 1;
  String companyId = '';
  @override
  void initState() {
    super.initState();
  }

  Future getCompanyInvestmentsList() {
    if (_page == 1) {
      view.companyInvestmentsProvider.setStateType(StateType.listLayout);
    }
    final Map<String, dynamic> params = <String, dynamic>{};
    params['company_id'] = companyId;
    params['per_page'] = 100;
    return requestNetwork<InvestmentsBean>(Method.post,
        url: HttpApi.companyInvestments,
        params: params,
        isShow: false, onSuccess: (InvestmentsBean? bean) {
      view.companyInvestmentsProvider.setMetaModel(bean?.meta);
      if (bean != null && bean.list != null) {
        view.companyInvestmentsProvider.setHasMore(bean.list?.length == 20);
        if (_page == 1) {
          view.companyInvestmentsProvider.clear();
          if (bean.list!.isEmpty) {
            view.companyInvestmentsProvider.setStateType(StateType.personnel);
          } else {
            view.companyInvestmentsProvider.addAll(bean.list!);
          }
        } else {
          view.companyInvestmentsProvider.addAll(bean.list!);
        }
      } else {
        /// 加载失败
        view.companyInvestmentsProvider.setHasMore(false);
        view.companyInvestmentsProvider.setStateType(StateType.personnel);
      }
    }, onError: (_, __) {
      view.companyInvestmentsProvider.setHasMore(false);
      view.companyInvestmentsProvider.setStateType(StateType.personnel);
    });
  }

  Future<void> onRefresh() async {
    _page = 1;
    await getCompanyInvestmentsList();
  }

  Future loadMore() async {
    _page++;
    await getCompanyInvestmentsList();
  }
}

class CompanyInvestorsPresenter
    extends BasePagePresenter<CompanyInvestorsIMvpView> {
  int _page = 1;
  String companyId = '';
  @override
  void initState() {
    super.initState();
  }

  Future getCompanyInvestorsList() {
    if (_page == 1) {
      view.companyInvestorsProvider.setStateType(StateType.listLayout);
    }
    final Map<String, dynamic> params = <String, dynamic>{};
    params['company_id'] = companyId;
    params['per_page'] = 100;
    return requestNetwork<InvestorsBean>(Method.post,
        url: HttpApi.companyInvestors,
        params: params,
        isShow: false, onSuccess: (InvestorsBean? bean) {
      view.companyInvestorsProvider.setMetaModel(bean?.meta);
      if (bean != null && bean.list != null) {
        view.companyInvestorsProvider.setHasMore(bean.list?.length == 20);
        if (_page == 1) {
          view.companyInvestorsProvider.clear();
          if (bean.list!.isEmpty) {
            view.companyInvestorsProvider.setStateType(StateType.personnel);
          } else {
            view.companyInvestorsProvider.addAll(bean.list!);
          }
        } else {
          view.companyInvestorsProvider.addAll(bean.list!);
        }
      } else {
        /// 加载失败
        view.companyInvestorsProvider.setHasMore(false);
        view.companyInvestorsProvider.setStateType(StateType.personnel);
      }
    }, onError: (_, __) {
      view.companyInvestorsProvider.setHasMore(false);
      view.companyInvestorsProvider.setStateType(StateType.personnel);
    });
  }

  Future<void> onRefresh() async {
    _page = 1;
    await getCompanyInvestorsList();
  }

  Future loadMore() async {
    _page++;
    await getCompanyInvestorsList();
  }
}

class PeopleUnlockPresenter extends BasePagePresenter<PeopleUnlockIMvpView> {
  Future peopleUnlock(String personnelId, {Function(String, String)? success}) {
    final Map<String, dynamic> params = <String, dynamic>{};
    params['personnel_id'] = personnelId;
    return requestNetwork<UnlockContactModel>(Method.post,
        url: HttpApi.peopleUnlock,
        params: params,
        isShow: true, onSuccess: (UnlockContactModel? bean) async {
      if (bean?.status == 1) {
        success!(
            bean?.nlockContact?.email ?? '', bean?.nlockContact?.mobile ?? '');
        await view
            .getContext()
            .read<UserInfoProvider>()
            .setVipData(bean?.nlockContact?.vipData);
        await view.getContext().read<UserInfoProvider>().setUnlockContacts();
      } else {
        view.showToast(bean?.message ?? '');
      }
    }, onError: (_, __) {});
  }
}

class StafflevelPresenter extends BasePagePresenter<StafflevelIMvpView> {
  Future companyStafflevel(String companylId,
      {Function(StaffLevelModel)? success}) {
    return requestNetwork<StaffLevel>(Method.get,
        url: HttpApi.companyStafflevel + '/$companylId',
        isShow: false, onSuccess: (StaffLevel? bean) async {
      if (bean != null && bean.staffLevelModel != null) {
        success!(bean.staffLevelModel!);
      }
    }, onError: (_, __) {});
  }
}

class CompanyBranchesPresenter
    extends BasePagePresenter<CompanyBranchesIMvpView> {
  int _page = 1;
  String companyId = '';
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      onRefresh();
    });
  }

  // 请求公司产品
  Future getCompanyBranchesList() {
    if (_page == 1) {
      view.companyBranchesListProvider.setStateType(StateType.listLayout);
    }
    final Map<String, dynamic> params = <String, dynamic>{};
    params['page'] = _page;
    return requestNetwork<Branches>(Method.post,
        url: HttpApi.companyBranch + companyId,
        queryParameters: params,
        isShow: false, onSuccess: (Branches? bean) {
      print('=====${bean!.total}');
      if (bean != null && bean.data != null) {
        view.companyBranchesListProvider.setHasMore(bean.data?.length == 20);
        if (_page == 1) {
          view.companyBranchesListProvider.clear();
          if (bean.data!.isEmpty) {
            view.companyBranchesListProvider.setStateType(StateType.personnel);
          } else {
            view.companyBranchesListProvider.addAll(bean.data ?? []);
          }
        } else {
          view.companyBranchesListProvider.addAll(bean.data ?? []);
        }
      } else {
        /// 加载失败
        view.companyBranchesListProvider.setHasMore(false);
        view.companyBranchesListProvider.setStateType(StateType.personnel);
      }
    }, onError: (_, __) {
      view.companyBranchesListProvider.setHasMore(false);
      view.companyBranchesListProvider.setStateType(StateType.personnel);
    });
  }

  Future<void> onRefresh() async {
    _page = 1;
    await getCompanyBranchesList();
  }

  Future loadMore() async {
    _page++;
    await getCompanyBranchesList();
  }
}

class CompanyBusinessPresenter
    extends BasePagePresenter<CompanyBusinessIMvpView> {
  int _page = 1;
  String companyId = '';
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      onRefresh();
    });
  }

  // 请求公司产品
  Future getCompanyBusinessList() {
    if (_page == 1) {
      view.companyBusinessListProvider.setStateType(StateType.listLayout);
    }
    final Map<String, dynamic> params = <String, dynamic>{};
    params['page'] = _page;
    return requestNetwork<BusinessDatas>(Method.post,
        url: HttpApi.companyBusiness + companyId,
        queryParameters: params,
        isShow: false, onSuccess: (BusinessDatas? bean) {
      if (bean != null && bean.data != null) {
        view.companyBusinessListProvider.setHasMore(bean.data?.length == 20);
        if (_page == 1) {
          view.companyBusinessListProvider.clear();
          if (bean.data!.isEmpty) {
            view.companyBusinessListProvider.setStateType(StateType.personnel);
          } else {
            view.companyBusinessListProvider.addAll(bean.data ?? []);
          }
        } else {
          view.companyBusinessListProvider.addAll(bean.data ?? []);
        }
      } else {
        /// 加载失败
        view.companyBusinessListProvider.setHasMore(false);
        view.companyBusinessListProvider.setStateType(StateType.personnel);
      }
    }, onError: (_, __) {
      view.companyBusinessListProvider.setHasMore(false);
      view.companyBusinessListProvider.setStateType(StateType.personnel);
    });
  }

  Future<void> onRefresh() async {
    _page = 1;
    await getCompanyBusinessList();
  }

  Future loadMore() async {
    _page++;
    await getCompanyBusinessList();
  }
}

class CompanyOfficerPresenter
    extends BasePagePresenter<CompanyOfficerIMvpView> {
  int _page = 1;
  String companyId = '';
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      onRefresh();
    });
  }

  // 请求公司董事会成员
  Future getCompanyOfficersList() {
    if (_page == 1) {
      view.companyOfficerListProvider.setStateType(StateType.listLayout);
    }
    final Map<String, dynamic> params = <String, dynamic>{};
    params['page'] = _page;
    return requestNetwork<Officers>(Method.post,
        url: HttpApi.companyOfficers + companyId,
        queryParameters: params,
        isShow: false, onSuccess: (Officers? bean) {
      if (bean != null && bean.data != null) {
        view.companyOfficerListProvider.setHasMore(bean.data?.length == 20);
        if (_page == 1) {
          view.companyOfficerListProvider.clear();
          if (bean.data!.isEmpty) {
            view.companyOfficerListProvider.setStateType(StateType.personnel);
          } else {
            view.companyOfficerListProvider.addAll(bean.data ?? []);
          }
        } else {
          view.companyOfficerListProvider.addAll(bean.data ?? []);
        }
      } else {
        /// 加载失败
        view.companyOfficerListProvider.setHasMore(false);
        view.companyOfficerListProvider.setStateType(StateType.personnel);
      }
    }, onError: (_, __) {
      view.companyOfficerListProvider.setHasMore(false);
      view.companyOfficerListProvider.setStateType(StateType.personnel);
    });
  }

  Future<void> onRefresh() async {
    _page = 1;
    await getCompanyOfficersList();
  }

  Future loadMore() async {
    _page++;
    await getCompanyOfficersList();
  }
}
