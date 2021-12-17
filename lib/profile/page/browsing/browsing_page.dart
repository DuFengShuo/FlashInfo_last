import 'package:flashinfo/profile/page/browsing/browsing_list_page.dart';
import 'package:flashinfo/res/colors.dart';
import 'package:flashinfo/res/resources.dart';
import 'package:flashinfo/widgets/container_tab.dart';
import 'package:flashinfo/widgets/my_app_bar.dart';
import 'package:flutter/material.dart';

class BrowsingPage extends StatefulWidget {
  const BrowsingPage({Key? key}) : super(key: key);

  @override
  _BrowsingPageState createState() => _BrowsingPageState();
}

class _BrowsingPageState extends State<BrowsingPage>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  late TabController _tabController;
  final PageController _pageController = PageController(initialPage: 0);
  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 3);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: Colours.bg_color,
      appBar: const MyAppBar(
        centerTitle: 'Browsing History',
      ),
      body: Column(
        children: [
          ContainerTab(
            tabs: const ['Companies', 'Contacts', 'Products'],
            tabController: _tabController,
            pageController: _pageController,
          ),
          Gaps.line,
          Container(
            width: double.infinity,
            color: Colours.material_bg,
            padding: EdgeInsets.symmetric(
                horizontal: Dimens.gap_dp16, vertical: Dimens.gap_v_dp10),
            child: Text(
              'Recent Viewed',
              style: TextStyles.textGray12,
            ),
          ),
          Expanded(
            child: PageView.builder(
              key: const Key('pageView'),
              itemCount: 3,
              onPageChanged: _onPageChange,
              controller: _pageController,
              itemBuilder: (_, int index) => BrowsingListPage(
                indexType: index,
              ),
            ),
          )
        ],
      ),
    );
  }

  void _onPageChange(int index) {
    _tabController.animateTo(index);
  }

  @override
  bool get wantKeepAlive => true;
}
