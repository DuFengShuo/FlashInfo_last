import 'package:flashinfo/res/resources.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ContainerTab extends StatelessWidget {
  const ContainerTab(
      {Key? key,
      required this.tabController,
      required this.pageController,
      required this.tabs})
      : super(key: key);
  final List<String> tabs;
  final TabController tabController;
  final PageController pageController;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colours.material_bg,
      height: 44,
      child: TabBar(
        onTap: (index) {
          pageController.jumpToPage(index);
        },
        controller: tabController,
        indicatorColor: Theme.of(context).primaryColor,
        indicatorWeight: 4,
        unselectedLabelColor: Colours.text_gray,
        labelColor: Theme.of(context).primaryColor,
        unselectedLabelStyle: TextStyles.textSize14,
        labelPadding: EdgeInsets.only(left: 0.w),
        labelStyle: TextStyles.text.copyWith(fontWeight: FontWeight.w600),
        indicatorPadding: EdgeInsets.only(left: 45.w, right: 45.w),
        tabs: _tabArray(),
      ),
    );
  }

  List<Widget> _tabArray() {
    final List<Widget> arr = [];
    tabs.forEach((String item) {
      arr.add(Tab(text: item));
    });
    return arr;
  }
}
