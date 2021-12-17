import 'package:flashinfo/brand/brand_rouder.dart';
import 'package:flashinfo/company/company_rouder.dart';
import 'package:flashinfo/company/models/company_bean.dart';
import 'package:flashinfo/company/widget/company_cell_widget.dart';
import 'package:flashinfo/favourites/iview/tags_iview.dart';
import 'package:flashinfo/favourites/model/collects_list_beam.dart';
import 'package:flashinfo/favourites/model/tags_bean.dart';
import 'package:flashinfo/favourites/page/group_name_page.dart';
import 'package:flashinfo/favourites/presenter/collects_presenter.dart';
import 'package:flashinfo/favourites/widget/favourites_brand_cell.dart';
import 'package:flashinfo/favourites/widget/group_export_widget.dart';
import 'package:flashinfo/mvp/base_page.dart';
import 'package:flashinfo/mvp/meta_model.dart';
import 'package:flashinfo/mvp/power_presenter.dart';
import 'package:flashinfo/mvp/status_model.dart';
import 'package:flashinfo/personal/widget/personl_cell_widget.dart';
import 'package:flashinfo/product/model/products_bean.dart';
import 'package:flashinfo/product/product_router.dart';
import 'package:flashinfo/product/widget/product_cell.dart';
import 'package:flashinfo/profile/page/export/export_page.dart';
import 'package:flashinfo/profile/profile_router.dart';
import 'package:flashinfo/provider/base_list_provider.dart';
import 'package:flashinfo/res/colors.dart';
import 'package:flashinfo/res/resources.dart';
import 'package:flashinfo/routers/fluro_navigator.dart';
import 'package:flashinfo/util/firedata_analytics.dart';
import 'package:flashinfo/util/other_utils.dart';
import 'package:flashinfo/util/toast_utils.dart';
import 'package:flashinfo/widgets/my_app_bar.dart';
import 'package:flashinfo/widgets/my_refresh_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'dart:convert' as convert;

class GroupListParam {
  GroupListParam({
    this.indexType,
    this.indexItem,
    this.tagsModel,
  });
  late TagsModel? tagsModel;
  late int? indexType;
  late int? indexItem;
}

class GroupListPage extends StatefulWidget {
  const GroupListPage({Key? key, this.groupListParam}) : super(key: key);
  final GroupListParam? groupListParam;
  @override
  _GroupListPageState createState() => _GroupListPageState();
}

class _GroupListPageState extends State<GroupListPage>
    with BasePageMixin<GroupListPage, PowerPresenter>
    implements CollectsListIMvpView, CollectsIMvpView {
  late CollectsListPresenter _collectsListPresenter;
  late CollectsPresenter _collectsPresenter;
  @override
  PowerPresenter createPresenter() {
    final PowerPresenter powerPresenter = PowerPresenter<dynamic>(this);
    _collectsListPresenter = CollectsListPresenter();
    _collectsPresenter = CollectsPresenter();
    _collectsPresenter.indexType = widget.groupListParam?.indexType ?? 0;
    _collectsListPresenter.indexType = widget.groupListParam?.indexType ?? 0;
    powerPresenter
        .requestPresenter([_collectsListPresenter, _collectsPresenter]);
    return powerPresenter;
  }

  @override
  BaseListProvider<CompanyTagModel> collectsListProvider =
      BaseListProvider<CompanyTagModel>();

  @override
  BaseListProvider<CompanyTagModel> companyTagListProvider =
      BaseListProvider<CompanyTagModel>();

  @override
  BaseListProvider<PersonnelTagModel> peopleTagListProvider =
      BaseListProvider<PersonnelTagModel>();

  @override
  BaseListProvider<ProductTagModel> productTagListProvider =
      BaseListProvider<ProductTagModel>();
  @override
  BaseListProvider<BrandTagModel> brandTagListProvider =
      BaseListProvider<BrandTagModel>();
  TagsModel? _model;
  @override
  void initState() {
    _model = widget.groupListParam?.tagsModel;
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      _collectsListPresenter.onRefresh(widget.groupListParam);
    });
  }

  //修改分组
  Future<void> _sendAnalyticsEvent() async {
    await FireBaseAnalyticUtil.analytics
        .logEvent(
      name: 'edit_group',
    )
        .then((value) {
      print('修改分组名称');
    });
    // DataFinder.onEventV3("add_group", params: {
    //   "add_group": "value",
    // });
  }

  void _showChangeNameDialog(
      BuildContext context, Function(String)? onPressed) {
    if (widget.groupListParam?.indexItem == 0) {
      Toast.show('Default group cannot edit!');
    } else {
      showElasticDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return GroupNamePage(
            onPressed: onPressed,
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<BaseListProvider<CompanyTagModel>>(
            create: (_) => collectsListProvider),
        ChangeNotifierProvider<BaseListProvider<CompanyTagModel>>(
            create: (_) => companyTagListProvider),
        ChangeNotifierProvider<BaseListProvider<PersonnelTagModel>>(
            create: (_) => peopleTagListProvider),
        ChangeNotifierProvider<BaseListProvider<ProductTagModel>>(
            create: (_) => productTagListProvider),
        ChangeNotifierProvider<BaseListProvider<BrandTagModel>>(
            create: (_) => brandTagListProvider),
      ],
      child: Scaffold(
        appBar: MyAppBar(
          centerTitle: widget.groupListParam?.tagsModel?.name ?? '',
          actionIconName:
              (widget.groupListParam?.indexItem ?? 0) < 3 ? null : 0xe664,
          textColor: Colours.text,
          isNewIcon: true,
          onPressed: () {
            _sendAnalyticsEvent();
            _showChangeNameDialog(context, (valse) {
              _collectsListPresenter.changeTagName(
                  valse,
                  widget.groupListParam?.tagsModel?.id ?? '',
                  widget.groupListParam?.indexItem ?? 0, (TagsModel? model) {
                widget.groupListParam?.tagsModel?.name = model?.name;
                setState(() {
                  _model = model;
                });
              });
            });
          },
          backOnPressed: () {
            NavigatorUtils.goBackWithParams(context, _model!);
          },
        ),
        body: Consumer4<
                BaseListProvider<CompanyTagModel>,
                BaseListProvider<PersonnelTagModel>,
                BaseListProvider<ProductTagModel>,
                BaseListProvider<BrandTagModel>>(
            builder: (_, companyTagListProvider, peopleTagListProvider,
                productTagListProvider, brandTagListProvider, __) {
          final MetaModel? metaModel = widget.groupListParam?.indexType == 0
              ? companyTagListProvider.metaModel
              : (widget.groupListParam?.indexType == 1
                  ? brandTagListProvider.metaModel
                  : (widget.groupListParam?.indexType == 2
                      ? productTagListProvider.metaModel
                      : peopleTagListProvider.metaModel));
          final int count = metaModel?.pagination?.total ?? 0;
          widget.groupListParam?.tagsModel?.contentCount = count;
          return Column(
            children: [
              Gaps.lineV,
              GroupExportWidget(
                count: count,
                isShowExport:
                    widget.groupListParam?.indexType == 0 ? true : false,
                onExportTap: () {
                  _collectsListPresenter.sendAnalyticsEvent();
                  final Map<String, dynamic> param = <String, dynamic>{};
                  param['type'] = 'Follow List';
                  param['modelType'] = ExportStoreType
                      .values[widget.groupListParam?.indexType ?? 0]
                      .toString()
                      .replaceAll('ExportStoreType.', '');
                  param['groupName'] = widget.groupListParam?.tagsModel?.name;
                  NavigatorUtils.pushResult(context, ProfileRouter.exportPage,
                      (value) {
                    print(value);
                  },
                      arguments: ExportStoreParams(
                          exportCount: count,
                          source: 'tag',
                          searchCondition: convert.jsonEncode({
                            'tag_id': widget.groupListParam?.tagsModel?.id
                          }).toString(),
                          modelType: ExportStoreType
                              .values[widget.groupListParam?.indexType ?? 0]
                              .toString()
                              .replaceAll('ExportStoreType.', ''),
                          viewCondition: convert.jsonEncode(param)));
                },
              ),
              Expanded(
                child: _groupList(),
              ),
            ],
          );
        }),
      ),
    );
  }

  Widget _groupList() {
    if (widget.groupListParam?.indexType == 0) {
      return DeerListView(
        key: const Key('collects_list'),
        pageSize: 10,
        itemCount: companyTagListProvider.list.length,
        stateType: companyTagListProvider.stateType,
        totalPages:
            companyTagListProvider.metaModel?.pagination?.totalPages ?? 1,
        onRefresh: () =>
            _collectsListPresenter.onRefresh(widget.groupListParam),
        loadMore: () => _collectsListPresenter.loadMore(widget.groupListParam),
        hasMore: companyTagListProvider.hasMore,
        itemBuilder: (_, index) {
          final CompanyTagModel model = companyTagListProvider.list[index];
          model.companyModel?.tagId = model.tagId;
          return CompanyCellWidget(
            isCancelAll: false,
            collectSuccessful: (StatusModel statusModel) async {
              if (model.companyModel?.isCollect ?? false) {
                await _collectsPresenter.cancelCollects(model.id,
                    (StatusModel statusModel) {
                  model.companyModel?.isCollect =
                      !(model.companyModel?.isCollect ?? true);
                  final MetaModel metaModel = companyTagListProvider.metaModel!;
                  if (metaModel.pagination!.total != 0) {
                    metaModel.pagination!.total =
                        (metaModel.pagination?.total ?? 1) - 1;
                    companyTagListProvider.setMetaModel(metaModel);
                  }
                });
              } else {
                await _collectsPresenter.addCollects(
                    widget.groupListParam?.tagsModel?.id ?? '',
                    model.companyModel?.id, (StatusModel statusModel) {
                  if (statusModel.collectResult != null) {
                    model.id = statusModel.collectResult![model.tagId] ?? '';
                  }
                  model.companyModel?.isCollect =
                      !(model.companyModel?.isCollect ?? true);
                  final MetaModel metaModel = companyTagListProvider.metaModel!;
                  metaModel.pagination!.total =
                      (metaModel.pagination?.total ?? 1) + 1;
                  companyTagListProvider.setMetaModel(metaModel);
                });
              }

              _collectsListPresenter.initState();
            },
            isLead: true,
            companyModel: model.companyModel,
            onTap: () {
              NavigatorUtils.pushResult(context,
                  '${CompanyRouder.companyDetailsPage}?companyId=${model.companyModel?.id ?? ''}',
                  (value) {
                final CompanyModel companyModelpush = value as CompanyModel;
                if (!(companyModelpush.isCollect ?? false)) {
                  companyTagListProvider.removeAt(index);
                  final MetaModel metaModel = companyTagListProvider.metaModel!;
                  if (metaModel.pagination!.total != 0) {
                    metaModel.pagination!.total =
                        (metaModel.pagination?.total ?? 1) - 1;
                    companyTagListProvider.setMetaModel(metaModel);
                  }
                  _collectsListPresenter.initState();
                }
              }, arguments: model.companyModel);
            },
          );
        },
      );
    } else if (widget.groupListParam?.indexType == 1) {
      return DeerListView(
        key: const Key('collects_list'),
        pageSize: 10,
        itemCount: brandTagListProvider.list.length,
        stateType: brandTagListProvider.stateType,
        onRefresh: () =>
            _collectsListPresenter.onRefresh(widget.groupListParam),
        loadMore: () => _collectsListPresenter.loadMore(widget.groupListParam),
        hasMore: brandTagListProvider.hasMore,
        totalPages: brandTagListProvider.metaModel?.pagination?.totalPages ?? 1,
        itemBuilder: (_, index) {
          final BrandTagModel model = brandTagListProvider.list[index];
          model.brandDetail.tagId = model.tagId;
          return Padding(
            padding: EdgeInsets.only(bottom: Dimens.gap_v_dp8),
            child: FavouritesBrandCell(
                model: model,
                onTapitem: () {
                  NavigatorUtils.pushResult(context,
                      '${BrandRouder.brandDetailPage}?brandId=${model.brandDetail.id}',
                      (value) {
                    final BrandDetail brandDetailpush = value as BrandDetail;
                    if (!brandDetailpush.isCollect) {
                      brandTagListProvider.removeAt(index);
                      final MetaModel metaModel =
                          brandTagListProvider.metaModel!;
                      if (metaModel.pagination!.total != 0) {
                        metaModel.pagination!.total =
                            (metaModel.pagination?.total ?? 1) - 1;
                        brandTagListProvider.setMetaModel(metaModel);
                      }
                      _collectsListPresenter.initState();
                    }
                  }, arguments: model.brandDetail);
                },
                onTap: () async {
                  if (model.brandDetail.isCollect) {
                    await _collectsPresenter.cancelCollects(model.id,
                        (StatusModel statusModel) {
                      model.brandDetail.isCollect =
                          !model.brandDetail.isCollect;
                      final MetaModel metaModel =
                          brandTagListProvider.metaModel!;
                      if (metaModel.pagination!.total != 0) {
                        metaModel.pagination!.total =
                            (metaModel.pagination?.total ?? 1) - 1;
                        brandTagListProvider.setMetaModel(metaModel);
                      }
                    });
                  } else {
                    await _collectsPresenter.addCollects(
                        widget.groupListParam?.tagsModel?.id ?? '',
                        model.brandDetail.id, (StatusModel statusModel) {
                      if (statusModel.collectResult != null) {
                        model.id =
                            statusModel.collectResult![model.tagId] ?? '';
                      }
                      model.brandDetail.isCollect =
                          !model.brandDetail.isCollect;
                      final MetaModel metaModel =
                          brandTagListProvider.metaModel!;
                      metaModel.pagination!.total =
                          (metaModel.pagination?.total ?? 1) + 1;
                      brandTagListProvider.setMetaModel(metaModel);
                    });
                  }

                  _collectsListPresenter.initState();
                }),
          );
        },
      );
    } else if (widget.groupListParam?.indexType == 2) {
      return DeerListView(
        key: const Key('collects_list'),
        pageSize: 10,
        itemCount: productTagListProvider.list.length,
        stateType: productTagListProvider.stateType,
        onRefresh: () =>
            _collectsListPresenter.onRefresh(widget.groupListParam),
        loadMore: () => _collectsListPresenter.loadMore(widget.groupListParam),
        hasMore: productTagListProvider.hasMore,
        totalPages:
            productTagListProvider.metaModel?.pagination?.totalPages ?? 1,
        itemBuilder: (_, index) {
          final ProductTagModel model = productTagListProvider.list[index];
          model.productsModel?.tagId = model.tagId;
          return ProductCellWidget(
            isCancelAl: false,
            productModel: model.productsModel,
            collectSuccessful: (StatusModel statusModel) async {
              if (model.productsModel?.isCollect ?? false) {
                await _collectsPresenter.cancelCollects(model.id,
                    (StatusModel statusModel) {
                  model.productsModel?.isCollect =
                      !(model.productsModel?.isCollect ?? true);
                  final MetaModel metaModel = productTagListProvider.metaModel!;
                  if (metaModel.pagination!.total != 0) {
                    metaModel.pagination!.total =
                        (metaModel.pagination?.total ?? 1) - 1;
                    productTagListProvider.setMetaModel(metaModel);
                  }
                });
              } else {
                await _collectsPresenter.addCollects(
                    widget.groupListParam?.tagsModel?.id ?? '',
                    model.productsModel?.id, (StatusModel statusModel) {
                  if (statusModel.collectResult != null) {
                    model.id = statusModel.collectResult![model.tagId] ?? '';
                  }
                  model.productsModel?.isCollect =
                      !(model.productsModel?.isCollect ?? true);
                  final MetaModel metaModel = productTagListProvider.metaModel!;
                  metaModel.pagination!.total =
                      (metaModel.pagination?.total ?? 1) + 1;
                  productTagListProvider.setMetaModel(metaModel);
                });
              }
              _collectsListPresenter.initState();
            },
            onTap: () => NavigatorUtils.pushResult(context,
                '${ProductRouter.productDetailsPage}?productId=${model.productsModel?.id ?? ''}',
                (value) {
              final ProductsModel productsModelpush = value as ProductsModel;
              if (!(productsModelpush.isCollect ?? false)) {
                productTagListProvider.removeAt(index);
                final MetaModel metaModel = productTagListProvider.metaModel!;
                if (metaModel.pagination!.total != 0) {
                  metaModel.pagination!.total =
                      (metaModel.pagination?.total ?? 1) - 1;
                  productTagListProvider.setMetaModel(metaModel);
                }
                _collectsListPresenter.initState();
              }
            }, arguments: model.productsModel),
          );
        },
      );
    } else {
      return DeerListView(
        key: const Key('collects_list'),
        pageSize: 10,
        itemCount: peopleTagListProvider.list.length,
        stateType: peopleTagListProvider.stateType,
        onRefresh: () =>
            _collectsListPresenter.onRefresh(widget.groupListParam),
        loadMore: () => _collectsListPresenter.loadMore(widget.groupListParam),
        hasMore: peopleTagListProvider.hasMore,
        totalPages:
            peopleTagListProvider.metaModel?.pagination?.totalPages ?? 1,
        itemBuilder: (_, index) {
          final PersonnelTagModel model = peopleTagListProvider.list[index];
          return PersonalCellWidget(
            peoplesModel: model.peoplesModel,
            collectSuccessful: (bool isCollect) {
              if (!isCollect) {
                peopleTagListProvider.removeAt(index);
                _collectsListPresenter.initState();
                final MetaModel metaModel = peopleTagListProvider.metaModel!;
                if (metaModel.pagination!.total != 0) {
                  metaModel.pagination!.total =
                      (metaModel.pagination?.total ?? 1) - 1;
                  peopleTagListProvider.setMetaModel(metaModel);
                }
              }
            },
          );
        },
      );
    }
  }
}
