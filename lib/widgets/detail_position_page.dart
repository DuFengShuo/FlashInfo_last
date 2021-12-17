import 'package:flashinfo/brand/widget/brand_bottombar_widget.dart';
import 'package:flashinfo/common/common.dart';
import 'package:flashinfo/company/company_rouder.dart';
import 'package:flashinfo/company/widget/details/company_details_topbar.dart';
import 'package:flashinfo/login/login_router.dart';
import 'package:flashinfo/mvp/status_model.dart';
import 'package:flashinfo/personal/model/peoples_new_bean.dart';
import 'package:flashinfo/personal/provider/personal_provider.dart';
import 'package:flashinfo/personal/widget/bottomSheet/people_contact.dart';
import 'package:flashinfo/personal/widget/details/person_details_header.dart';
import 'package:flashinfo/personal/widget/details/person_details_summary.dart';
import 'package:flashinfo/res/resources.dart';
import 'package:flashinfo/routers/fluro_navigator.dart';
import 'package:flashinfo/util/screen_utils.dart';
import 'package:flashinfo/util/send_analytics_event.dart';
import 'package:flashinfo/widgets/login_toast_dialog.dart';
import 'package:flashinfo/widgets/scrollshow_appbar_widget.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class DetailPositionPage extends StatefulWidget {
  final List<Widget> contentPages;
  final List<String> tabTitles;
  final String? title;
  final void Function()? callBack;
  const DetailPositionPage(
      {Key? key,
      required this.contentPages,
      required this.tabTitles,
      this.title, this.callBack})
      : super(key: key);

  @override
  _DetailPositionPageState createState() => _DetailPositionPageState();
}

class _DetailPositionPageState extends State<DetailPositionPage>
    with SingleTickerProviderStateMixin {
  late List<String> tabs = [];
  late List<Widget> contentList = []; //内容列表
  late TabController tabController;
  final ItemScrollController itemScrollController =
      ItemScrollController(); //positionScrollView
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();
  bool isShowTopBar = false; //默认隐藏topBar

  @override
  void initState() {
    super.initState();
    contentList = widget.contentPages;
    tabs = widget.tabTitles;
    contentList.insert(
        0,
        Column(
          children: [
            const PersonDetailHeaderWidget(),
            CompanyDetailTopBarWidget(
              tabDatas: tabs,
              itemPositionsListener: itemPositionsListener,
              callBack: (int value) {
                //查看分支事件统计
                // _companyDetailPresenter.sendAnalyticsEvent('Branch_click');
                if (value != null) {
                  print('点了===$value');
                  itemScrollController.scrollTo(
                      index: value,
                      duration: const Duration(milliseconds: 200));
                }
              },
            ),
            Gaps.vGap12,
            const PersonalSummaryWidget()
          ],
        ));
    tabController = TabController(length: tabs.length, vsync: this); //初始化tab控制器

  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PersonalProvider>(builder: (_, provider, __) {
      final PeoplesNewBean? model = provider.personalDetailsBean;
      return Scaffold(
          backgroundColor: Colours.bg_color,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(isShowTopBar ? 100.h : 45.h),
            child: ScrollShowAppBar(
              tabTitles: tabs,
              tabController: tabController,
              isShowAppBar: isShowTopBar,
              tabTapCallBack: (int value) {
                print('点了===$value');
                itemScrollController.scrollTo(
                    index: value, duration: const Duration(milliseconds: 200));
              },
              logo: '${model?.info?.avatar}',
              name: '${model?.info?.name}',
              phone: '',
              detailId: '${model?.info?.id}',
              title: '${widget.title}',
              itemPositionsListener: itemPositionsListener,
            ),
          ),
          body: ConstrainedBox(
              constraints: const BoxConstraints.expand(),
              child: Stack(children: [
                // Container(
                //   height: 200.h,
                //   color: Colours.app_main,
                // ),

                OrientationBuilder(
                    builder: (context, orientation) => Column(
                          children: [
                            positionsView((int index){
                              print('滚动到了===$index');
                              if(mounted){
                                tabController.animateTo(index,
                                    duration: const Duration(microseconds: 2));
                              }

                            }),
                            Expanded(
                                child: NotificationListener<ScrollNotification>(
                                    onNotification:
                                        (ScrollNotification notification) {
                                      //print(notification.metrics.pixels);
                                      if (notification.metrics.pixels.h >=
                                              0.0 &&
                                          notification.metrics.pixels.h >
                                              225.0.h) {
                                        if (mounted) {

                                          setState(() {
                                            isShowTopBar = true;
                                          });
                                        }
                                      } else {
                                        if (mounted) {
                                          setState(() {
                                            isShowTopBar = false;
                                          });
                                        }
                                      }
                                      return true;
                                    },
                                    child: list(orientation))),
                          ],
                        )),
                Positioned(
                  bottom: 0,
                  child: Container(
                    height: MediaQuery.of(context).padding.bottom + 60,
                    // alignment: Alignment.topLeft,
                    color: Colours.material_bg,
                    width: Screen.width(context),
                    child: BrandBottomBarWidget(
                        // isCollect: widget.model!.isCollect ?? false,
                        // followId: widget.model!.id ?? '',
                        isCollect: false,
                        isShowFollow: false,
                        followId: '',
                        indexType: 0,
                        onTapReviews: () {
                          if (!(SpUtil.getBool(Constant.isLogin,
                                  defValue: false) ??
                              false)) {
                            showDialog<void>(
                                context: context,
                                barrierDismissible: true,
                                builder: (_) => LoginToastDialog(onPressed: () {
                                      Navigator.pop(context);
                                      NavigatorUtils.push(
                                          context, LoginRouter.smsLoginPage);
                                    }));
                            return;
                          }
                          NavigatorUtils.push(
                              context, CompanyRouder.companyRateReviewsPage);
                        },
                        onTapContact: () {
                          //关键联系人
                          AnalyticEventUtil.analyticsUtil
                              .sendAnalyticsEvent('Contact_Click');
                          showModalBottomSheet<void>(
                              context: context,
                              backgroundColor: Colors.transparent,
                              builder: (BuildContext context) {
                                //  构建弹框中的内容
                                return PeopleContact(
                                  model: model,
                                  onTap: (PeoplesNewBean? model) {
                                     widget.callBack!();
                                  },
                                );
                              });
                        },
                        collectSuccessful: (StatusModel isCollect) {
                        }),
                  ),
                ),
              ])));
    });
  }



  Widget list(Orientation orientation) => ScrollablePositionedList.builder(
        itemCount: tabs.length,
        itemBuilder: (context, index) => contentList[index],
        itemScrollController: itemScrollController,
        itemPositionsListener: itemPositionsListener,
        reverse: false,
        padding: EdgeInsets.only(bottom: 70.h),
        physics: const BouncingScrollPhysics(),
        addAutomaticKeepAlives: true,
        minCacheExtent: 8000.h,
        addRepaintBoundaries: true,
        scrollDirection: Axis.vertical,
      );

  Widget positionsView(Function callBack) {
   return ValueListenableBuilder<Iterable<ItemPosition>>(
      valueListenable: itemPositionsListener.itemPositions,
      builder: (context, positions, child) {
        int? min;
        if (positions.isNotEmpty) {
          min = positions
              .where((ItemPosition position) => position.itemTrailingEdge > 0)
              .reduce((ItemPosition min, ItemPosition position) =>
          position.itemTrailingEdge < min.itemTrailingEdge
              ? position
              : min)
              .index;
          // tabController.animateTo(min,
          //     duration: const Duration(microseconds: 2));
          callBack(min);
        }

        return Gaps.empty;
      },
    );

  }

}
