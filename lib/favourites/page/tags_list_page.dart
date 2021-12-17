import 'package:flashinfo/favourites/favourites_router.dart';
import 'package:flashinfo/favourites/iview/tags_iview.dart';
import 'package:flashinfo/favourites/model/tags_bean.dart';
import 'package:flashinfo/favourites/page/favourites_page.dart';
import 'package:flashinfo/favourites/page/group_list_page.dart';
import 'package:flashinfo/favourites/presenter/tags_presenter.dart';
import 'package:flashinfo/favourites/widget/tags_item.dart';
import 'package:flashinfo/mvp/base_page.dart';
import 'package:flashinfo/mvp/power_presenter.dart';
import 'package:flashinfo/provider/base_list_provider.dart';
import 'package:flashinfo/routers/fluro_navigator.dart';
import 'package:flashinfo/widgets/my_refresh_list.dart';
import 'package:flashinfo/widgets/slidable_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/subjects.dart';

class TagsListPage extends StatefulWidget {
  const TagsListPage({Key? key, required this.indexType, this.addTagsSubject})
      : super(key: key);
  final int indexType;
  final PublishSubject<GroupType>? addTagsSubject;
  @override
  _TagsListPageState createState() => _TagsListPageState();
}

class _TagsListPageState extends State<TagsListPage>
    with
        AutomaticKeepAliveClientMixin,
        BasePageMixin<TagsListPage, PowerPresenter>
    implements TagsIMvpView {
  // 保留一个Slidable打开
  final SlidableController _slidableController = SlidableController();
  @override
  BaseListProvider<TagsModel> tagsListProvider = BaseListProvider<TagsModel>();
  late TagsPresenter _tagsPresenter;
  @override
  PowerPresenter createPresenter() {
    final PowerPresenter powerPresenter = PowerPresenter<dynamic>(this);
    _tagsPresenter = TagsPresenter();
    _tagsPresenter.indexType = widget.indexType;
    powerPresenter.requestPresenter([_tagsPresenter]);
    return powerPresenter;
  }

  @override
  void initState() {
    super.initState();
    widget.addTagsSubject?.listen((GroupType groupType) async {
      if (groupType.indexType == widget.indexType) {
        await _tagsPresenter.addTags(groupType.name, (bool addSuccessful) {
          if (addSuccessful) {
            NavigatorUtils.goBack(context);
          }
        });
      }
    });
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      _tagsPresenter.getTags();
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<BaseListProvider<TagsModel>>(
            create: (_) => tagsListProvider),
      ],
      child: Consumer<BaseListProvider<TagsModel>>(
        builder: (_, provider, __) {
          return DeerListView(
            key: const Key('favourites_list'),
            itemCount: provider.list.length,
            stateType: provider.stateType,
            onRefresh: _tagsPresenter.onRefresh,
            loadMore: _tagsPresenter.loadMore,
            hasMore: provider.hasMore,
            pageSize: 10,
            totalPages: provider.metaModel?.pagination?.totalPages ?? 1,
            itemBuilder: (_, index) {
              final TagsModel model = provider.list[index];
              return index < 3
                  ? GestureDetector(
                      onTap: () => NavigatorUtils.pushResult(
                          context, FavouritesRouter.groupListPage, (value) {
                        final TagsModel tagsModel = value as TagsModel;
                        provider.list[index] = tagsModel;
                        // provider.refresh();
                        _tagsPresenter.onRefresh();
                      },
                          arguments: GroupListParam(
                              tagsModel: model,
                              indexType: widget.indexType,
                              indexItem: index)),
                      child: TagsItem(
                        tagsModel: model,
                      ),
                    )
                  : SlidableWidget(
                      index: index,
                      slidableController: _slidableController,
                      onTap: () => NavigatorUtils.pushResult(
                          context, FavouritesRouter.groupListPage, (value) {
                        final TagsModel tagsModel = value as TagsModel;
                        provider.list[index] = tagsModel;
                        // provider.refresh();
                        _tagsPresenter.onRefresh();
                      },
                          arguments: GroupListParam(
                              tagsModel: model,
                              indexType: widget.indexType,
                              indexItem: index)),
                      onTapDele: () =>
                          _tagsPresenter.deleteTags(model.id, index),
                      child: TagsItem(
                        tagsModel: model,
                      ),
                    );
            },
          );
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
