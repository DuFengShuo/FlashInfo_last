import 'package:flashinfo/favourites/page/add_group_page.dart';
import 'package:flashinfo/favourites/page/tags_list_page.dart';
import 'package:flashinfo/res/colors.dart';
import 'package:flashinfo/res/resources.dart';
import 'package:flashinfo/util/firedata_analytics.dart';
import 'package:flashinfo/util/other_utils.dart';
import 'package:flashinfo/widgets/container_tab.dart';
import 'package:flashinfo/widgets/my_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/subjects.dart';

class GroupType {
  late String name;
  late int indexType;
}

class FavouritesPage extends StatefulWidget {
  const FavouritesPage({Key? key}) : super(key: key);

  @override
  _FavouritesPageState createState() => _FavouritesPageState();
}

class _FavouritesPageState extends State<FavouritesPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final PageController _pageController = PageController(initialPage: 0);
  final PublishSubject<GroupType> _addTagsSubject = PublishSubject<GroupType>();
  final List<String> tabArray = const ['Company', 'Brand', 'Product'];
  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: tabArray.length);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _addTagsSubject.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
          centerTitle: 'Follow List',
          actionIconName: 0xe614,
          textColor: Colours.text,
          onPressed: () {
            _sendAnalyticsEvent();
            _showAddGroupDialog(context);
          }),
      body: Column(
        children: [
          Gaps.line,
          ContainerTab(
            tabs: tabArray,
            tabController: _tabController,
            pageController: _pageController,
          ),
          Gaps.lineV,
          Expanded(
            child: PageView.builder(
                key: const Key('pageView'),
                itemCount: tabArray.length,
                onPageChanged: _onPageChange,
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (_, int index) => TagsListPage(
                      indexType: index,
                      addTagsSubject: _addTagsSubject,
                    )),
          )
        ],
      ),
    );
  }

  //创建分组
  Future<void> _sendAnalyticsEvent() async {
    await FireBaseAnalyticUtil.analytics
        .logEvent(name: 'add_group', parameters: {
      'add_group': 'value',
    }).then((value) {
      print('创建分组');
    });
    // DataFinder.onEventV3("add_group", params: {
    //   "add_group": "value",
    // });
  }

  void _showAddGroupDialog(BuildContext context) {
    showElasticDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AddGroupPage(
          onPressed: (value) {
            final GroupType groupType = GroupType();
            groupType.name = value;
            groupType.indexType = _tabController.index;
            _addTagsSubject.add(groupType);
          },
        );
      },
    );
  }

  void _onPageChange(int index) {
    _tabController.animateTo(index);
  }
}
