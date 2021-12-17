import 'package:flashinfo/favourites/iview/tags_iview.dart';
import 'package:flashinfo/favourites/model/tags_bean.dart';
import 'package:flashinfo/favourites/page/add_group_page.dart';
import 'package:flashinfo/favourites/presenter/collects_presenter.dart';
import 'package:flashinfo/favourites/presenter/tags_presenter.dart';
import 'package:flashinfo/favourites/widget/group_dialog_item.dart';
import 'package:flashinfo/mvp/base_page.dart';
import 'package:flashinfo/mvp/power_presenter.dart';
import 'package:flashinfo/mvp/status_model.dart';
import 'package:flashinfo/provider/base_list_provider.dart';
import 'package:flashinfo/provider/group_provider.dart';
import 'package:flashinfo/res/resources.dart';
import 'package:flashinfo/routers/fluro_navigator.dart';
import 'package:flashinfo/util/other_utils.dart';
import 'package:flashinfo/widgets/base_dialog.dart';
import 'package:flashinfo/widgets/icon_font.dart';
import 'package:flashinfo/widgets/my_refresh_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class GroupDialogPage extends StatefulWidget {
  const GroupDialogPage(
      {Key? key, this.indexType = 0, this.relatedTd, this.collectSuccessful})
      : super(key: key);
  final int indexType;
  final String? relatedTd;
  final void Function(StatusModel)? collectSuccessful;
  @override
  _GroupDialogPageState createState() => _GroupDialogPageState();
}

class _GroupDialogPageState extends State<GroupDialogPage>
    with BasePageMixin<GroupDialogPage, PowerPresenter>
    implements TagsIMvpView, CollectsIMvpView {
  int indexItem = -1;
  late List<String?> _gtoupSelecedArray;
  bool isFirst = true;
  @override
  BaseListProvider<TagsModel> tagsListProvider = BaseListProvider<TagsModel>();

  late TagsPresenter _tagsPresenter;
  late CollectsPresenter _collectsPresenter;
  @override
  PowerPresenter createPresenter() {
    final PowerPresenter powerPresenter = PowerPresenter<dynamic>(this);
    _tagsPresenter = TagsPresenter();
    _collectsPresenter = CollectsPresenter();
    _tagsPresenter.indexType = widget.indexType;
    _collectsPresenter.indexType = widget.indexType;
    powerPresenter.requestPresenter([_tagsPresenter, _collectsPresenter]);
    return powerPresenter;
  }

  @override
  void initState() {
    super.initState();
    _gtoupSelecedArray = <String?>[];
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      switch (widget.indexType) {
        case 0:
          if (context.read<GroupProvider>().groupCompanyListProvider == null ||
              context
                  .read<GroupProvider>()
                  .groupCompanyListProvider!
                  .list
                  .isEmpty) {
            _tagsPresenter.onRefresh();
          } else {
            tagsListProvider.addAll(
                context.read<GroupProvider>().groupCompanyListProvider?.list ??
                    []);
          }
          break;
        case 1:
          if (context.read<GroupProvider>().groupBrandListProvider == null ||
              context
                  .read<GroupProvider>()
                  .groupBrandListProvider!
                  .list
                  .isEmpty) {
            _tagsPresenter.onRefresh();
          } else {
            tagsListProvider.addAll(
                context.read<GroupProvider>().groupBrandListProvider?.list ??
                    []);
          }
          break;
        case 2:
          if (context.read<GroupProvider>().groupProductListProvider == null ||
              context
                  .read<GroupProvider>()
                  .groupProductListProvider!
                  .list
                  .isEmpty) {
            _tagsPresenter.onRefresh();
          } else {
            tagsListProvider.addAll(
                context.read<GroupProvider>().groupProductListProvider?.list ??
                    []);
          }

          break;
        case 3:
          if (context.read<GroupProvider>().groupPersonnelListProvider ==
                  null ||
              context
                  .read<GroupProvider>()
                  .groupPersonnelListProvider!
                  .list
                  .isEmpty) {
            _tagsPresenter.onRefresh();
          } else {
            tagsListProvider.addAll(context
                    .read<GroupProvider>()
                    .groupPersonnelListProvider
                    ?.list ??
                []);
          }
          break;
        default:
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BaseDialog(
      isBottomShow: true,
      title: 'Add to My Follow List',
      leftTitle: 'Cancel',
      rightTitle: 'Save',
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: Dimens.gap_dp16),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                  onTap: () {
                    _showAddGroupDialogPage(context);
                  },
                  child: Container(
                    padding: EdgeInsets.only(bottom: Dimens.gap_v_dp16),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: Divider.createBorderSide(context,
                            width: Dimens.gap_dp1),
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 44.w,
                          height: 44.w,
                          decoration: BoxDecoration(
                              color: Colours.bg_color,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8.r))),
                          child: IconFont(
                              name: 0xe614,
                              size: Dimens.font_sp20,
                              color: Colours.app_main),
                        ),
                        Gaps.hGap10,
                        Text(
                          'Create New List',
                          style: TextStyles.textSize16
                              .copyWith(color: Colours.app_main),
                        ),
                      ],
                    ),
                  )),
              Expanded(
                child: Container(
                  color: Colors.transparent,
                  child: Consumer<GroupProvider>(
                    builder: (_, provider, __) {
                      BaseListProvider<TagsModel>? groupListProvider;
                      switch (widget.indexType) {
                        case 0:
                          groupListProvider = provider.groupCompanyListProvider;
                          break;
                        case 1:
                          groupListProvider = provider.groupBrandListProvider;
                          break;
                        case 2:
                          groupListProvider = provider.groupProductListProvider;
                          break;
                        case 3:
                          groupListProvider =
                              provider.groupPersonnelListProvider;
                          break;
                        default:
                      }
                      if (_gtoupSelecedArray.isEmpty &&
                          (groupListProvider?.list ?? []).isNotEmpty &&
                          isFirst) {
                        isFirst = false;
                        _gtoupSelecedArray.add(groupListProvider?.list[0].id);
                      }
                      return (groupListProvider?.list ?? []).isEmpty
                          ? Gaps.empty
                          : DeerListView(
                              key: const Key('group_list'),
                              pageSize: 10,
                              itemCount: groupListProvider?.list.length ?? 0,
                              onRefresh: _tagsPresenter.onRefresh,
                              loadMore: _tagsPresenter.loadMore,
                              hasMore: groupListProvider!.hasMore,
                              stateType: groupListProvider.stateType,
                              totalPages: groupListProvider
                                      .metaModel?.pagination?.totalPages ??
                                  1,
                              itemBuilder: (_, index) {
                                final TagsModel model =
                                    groupListProvider!.list[index];
                                return GroupDialogItem(
                                  gtoupSelecedArray: _gtoupSelecedArray,
                                  tagsModel: model,
                                  onTap: (bool? value) {
                                    if (value != null && value) {
                                      ///添加关注
                                      if (!_gtoupSelecedArray
                                          .contains(model.id)) {
                                        _gtoupSelecedArray.add(model.id);
                                      }
                                    } else {
                                      ///取消关注
                                      if (_gtoupSelecedArray
                                          .contains(model.id)) {
                                        _gtoupSelecedArray.remove(model.id);
                                      }
                                    }
                                    setState(() {});
                                  },
                                );
                              },
                            );

                      // ListView.builder(
                      //   itemCount: groupListProvider?.list.length ?? 0,
                      //   itemBuilder: (context, index) {
                      //     final TagsModel model =
                      //         groupListProvider!.list[index];
                      //     return GroupDialogItem(
                      //       gtoupSelecedArray: _gtoupSelecedArray,
                      //       tagsModel: model,
                      //       onTap: (bool? value) {
                      //         if (value != null && value) {
                      //           ///添加关注
                      //           if (!_gtoupSelecedArray.contains(model.id)) {
                      //             _gtoupSelecedArray.add(model.id);
                      //           }
                      //         } else {
                      //           ///取消关注
                      //           if (_gtoupSelecedArray.contains(model.id)) {
                      //             _gtoupSelecedArray.remove(model.id);
                      //           }
                      //         }
                      //         setState(() {});
                      //       },
                      //     );
                      //   },
                      // );
                    },
                  ),
                ),
              )
            ]),
      ),
      onPressed: () async {
        if (_gtoupSelecedArray.isEmpty) {
          NavigatorUtils.goBack(context);
          return;
        }
        await _collectsPresenter
            .addCollects(_gtoupSelecedArray.join(','), widget.relatedTd,
                (StatusModel statusModel) {
          NavigatorUtils.goBack(context);
          widget.collectSuccessful!(statusModel);
        });
      },
    );
  }

  void _showAddGroupDialogPage(BuildContext context) {
    showElasticDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AddGroupPage(
          onPressed: (value) async {
            await _tagsPresenter.addTags(value.toString(),
                (bool addSuccessful) {
              if (addSuccessful) {
                NavigatorUtils.goBack(context);
              }
            });
          },
        );
      },
    );
  }
}
