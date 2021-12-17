import 'package:flashinfo/mvp/base_page.dart';
import 'package:flashinfo/mvp/power_presenter.dart';
import 'package:flashinfo/provider/base_list_provider.dart';
import 'package:flashinfo/provider/common_provider.dart';
import 'package:flashinfo/res/dimens.dart';
import 'package:flashinfo/res/resources.dart';
import 'package:flashinfo/routers/fluro_navigator.dart';
import 'package:flashinfo/search/iview/search_iview.dart';
import 'package:flashinfo/search/model/autocomplete_bean.dart';
import 'package:flashinfo/search/presenter/search_presenter.dart';
import 'package:flashinfo/search/search_router.dart';
import 'package:flashinfo/search/widgets/search_cache_widget.dart';
import 'package:flashinfo/util/image_utils.dart';
import 'package:flashinfo/widgets/my_refresh_list.dart';
import 'package:flashinfo/widgets/search_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/subjects.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchCachePage extends StatefulWidget {
  const SearchCachePage({Key? key}) : super(key: key);

  @override
  _SearchCachePageState createState() => _SearchCachePageState();
}

class _SearchCachePageState extends State<SearchCachePage>
    with BasePageMixin<SearchCachePage, PowerPresenter>
    implements SearchCacheIMvpView {
  final PublishSubject<String> _localTextSubject =
      PublishSubject<String>(); //存储搜索的值
  @override
  String searchValue = ''; //搜索框文本

  @override
  BaseListProvider<AutocompleteModel> autoListProvider =
      BaseListProvider<AutocompleteModel>();

  late SearchCachePresenter _searchCachePresenter;
  late final PublishSubject<String> _searchBarsubject =
      PublishSubject<String>();
  @override
  PowerPresenter createPresenter() {
    final PowerPresenter powerPresenter = PowerPresenter<dynamic>(this);
    _searchCachePresenter = SearchCachePresenter();
    powerPresenter.requestPresenter([_searchCachePresenter]);
    return powerPresenter;
  }

  Future _searchAutocomplete(String text) async {
    if (text.trim().length < 3) {
      autoListProvider.clear();
      _localTextSubject.add('0');
      return;
    }
    setState(() {
      searchValue = text;
    });
    await _searchCachePresenter.searchAutocomplete();
  }

  void pushSearch(String text) {
    setState(() {
      searchValue = text;
    });
    _searchBarsubject.add(text);
    NavigatorUtils.pushResult(
        context, '${SearchRouter.searchPage}?searchValue=$text', (value) {
      _localTextSubject.add('0');
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _localTextSubject.close();
    _searchBarsubject.close();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<BaseListProvider<AutocompleteModel>>(
            create: (_) => autoListProvider),
      ],
      child: Scaffold(
        appBar: SearchBar(
            autofocus: true,
            searchValue: searchValue,
            hintText: 'Search for companies，contact，products',
            onChanged: _searchAutocomplete,
            onPressed: pushSearch,
            searchBarsubject: _searchBarsubject),
        body: Consumer<BaseListProvider<AutocompleteModel>>(
          builder: (_, provider, __) {
            return DeerListView(
              key: const Key('search_autocomplete'),
              childLayout: SearchCacheWidget(
                localTextSubject: _localTextSubject,
                onCacheItem: pushSearch,
              ),
              itemCount: provider.list.length,
              stateType: provider.stateType,
              hasMore: provider.hasMore,
              totalPages: provider.metaModel?.pagination?.totalPages ?? 1,
              itemBuilder: (_, index) {
                final AutocompleteModel? model = provider.list[index];
                return GestureDetector(
                  onTap: () => pushSearch(model?.name ?? ''),
                  child: Container(
                    height: 52.h,
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: Dimens.gap_dp16),
                    alignment: Alignment.centerLeft,
                    decoration: const BoxDecoration(
                        color: Colours.material_bg,
                        border: Border(
                            bottom:
                                BorderSide(width: 1, color: Colours.bg_color))),
                    child: Row(
                      children: [
                        Visibility(
                          visible: model?.countryImg?.imgName != null &&
                              (model?.countryImg?.imgName ?? '').isNotEmpty,
                          child: Consumer<CommonProvider>(
                            builder: (_, commonProvider, __) {
                              final Map<String, String>? nationalFlag =
                                  commonProvider
                                      .initializeModel?.icon?.nationalFlag;
                              return CircleAvatar(
                                radius: 18.0.r,
                                backgroundColor: Colors.transparent,
                                backgroundImage: ImageUtils.getImageProvider(
                                    nationalFlag?[model?.countryImg?.imgName] ??
                                        '',
                                    holderImg: 'me/avatar'),
                              );
                            },
                          ),
                        ),
                        Gaps.hGap10,
                        Expanded(
                            child: Text(
                          model?.name ?? '',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ))
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
