import 'dart:math';
import 'package:flashinfo/common/common.dart';
import 'package:flashinfo/company/models/company_detail_model.dart';
import 'package:flashinfo/company/models/company_subsidiary_model.dart';
import 'package:flashinfo/company/page/employee/company_details_employee.dart';
import 'package:flashinfo/company/presenter/company_detial_presenter.dart';
import 'package:flashinfo/company/widget/bottomSheet/company_people_contact.dart';
import 'package:flashinfo/company/widget/details/company_details_album.dart';
import 'package:flashinfo/company/widget/details/company_details_corporate.dart';
import 'package:flashinfo/company/widget/details/company_details_header.dart';
import 'package:flashinfo/company/widget/details/company_details_mand.dart';
import 'package:flashinfo/company/widget/details/company_details_news.dart';
import 'package:flashinfo/company/widget/details/company_details_product_widget.dart';
import 'package:flashinfo/company/widget/details/follow_contact_widget.dart';
import 'package:flashinfo/company/widget/details/sliver_header_delegate.dart';
import 'package:flashinfo/login/login_router.dart';
import 'package:flashinfo/mvp/status_model.dart';
import 'package:flashinfo/personal/model/peoples_bean.dart';
import 'package:flashinfo/res/resources.dart';
import 'package:flashinfo/routers/fluro_navigator.dart';
import 'package:flashinfo/util/screen_utils.dart';
import 'package:flashinfo/util/send_analytics_event.dart';
import 'package:flashinfo/widgets/login_toast_dialog.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import 'finance/company_details_finance.dart';

const numberOfItems = 5;
const minItemHeight = 100.0;
const maxItemHeight = 1000.0;
const scrollDuration = Duration(milliseconds: 700);
const randomMax = 1 << 32;

class CompanyDetailScrollableListPage extends StatefulWidget {
  final CompanyDetailModel? model;
  final CompanySubsidiaryModel? subsidiaryModel;

  const CompanyDetailScrollableListPage({
    Key? key,
    this.model,
    this.subsidiaryModel,
  }) : super(key: key);

  @override
  _CompanyDetailScrollableListPageState createState() =>
      _CompanyDetailScrollableListPageState();
}

class _CompanyDetailScrollableListPageState
    extends State<CompanyDetailScrollableListPage>
    with SingleTickerProviderStateMixin {
  /// Controller to scroll or jump to a particular item.
  final ItemScrollController itemScrollController = ItemScrollController();
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();
  late List<double> itemHeights;
  late List<Color> itemColors;
  bool reversed = false;
  double alignment = 0;
  late TabController tabController;
  late ScrollController topScroll;
  bool bottomCanScroll = false;
  final CompanyDetailPresenter _companyDetailPresenter =
      new CompanyDetailPresenter();
  List<String> contentTabData = [
    'Summary',
    // 'Products',
    // 'Finance',
    // 'Employee',
    // 'Album',
    // 'News',
    // 'Recommend',
    // 'Reviews'
  ];
  List<Widget> contentList = [
    const CompanyDetailsCorporate(),
    // const CompanyDetailsProductWidget(),
    // const CompanyDetailsFinance(),
    // const CompanyDetailsEmployee(),
    // const CompanyDetailsAlbum(),
    // const CompanyDetailsNews(),
    // const CompanyDetailsMand(),
    // // Gaps.lineV,
    // Consumer<CompanyProvider>(builder: (_, provider, __) {
    //   final CompanyDetailModel? companyDetailModel =
    //       provider.companyDetailModel;
    //   return CompanyDetailsReviews(
    //     comments: companyDetailModel?.comments,
    //     relatedId: companyDetailModel?.id,
    //     pageType: 'company',
    //   );
    // }),
  ];

  void showBottomSheet(
      BuildContext context, String? companyId, List<PeoplesModel>? list) {
    if (!(SpUtil.getBool(Constant.isLogin, defValue: false) ?? false)) {
      //查看关键联系人未登录
      _companyDetailPresenter.sendAnalyticsEvent('Company_Contact_Click_Login');

      showDialog<void>(
          context: context,
          barrierDismissible: true,
          builder: (_) => LoginToastDialog(onPressed: () {
                Navigator.pop(context);
                NavigatorUtils.push(context, LoginRouter.smsLoginPage);
              }));
      return;
    }
    //用于在底部打开弹框的效果
    showModalBottomSheet<void>(
        context: context,
        builder: (BuildContext context) {
          //构建弹框中的内容
          return CompanyPeopleContact(list: list ?? [], companyId: companyId);
        });
  }

  void getAllContentWidget() {
    if (widget.model!.product!.productModel!.isNotEmpty) {
      contentTabData.add('Products');
      contentList.add(const CompanyDetailsProductWidget());
    }
    contentTabData.add('Finance');
    contentList.add(const CompanyDetailsFinance());

    if (widget.model!.personnel!.personnelModel != null &&
        widget.model!.personnel!.personnelModel!.isNotEmpty) {
      contentTabData.add('Employee');
      contentList.add(
        const CompanyDetailsEmployee(),
      );
    }
    if (widget.subsidiaryModel != null &&
        widget.subsidiaryModel!.albums!.list!.isNotEmpty) {
      contentTabData.add('Album');
      contentList.add(const CompanyDetailsAlbum());
    }
    if (widget.subsidiaryModel != null &&
        widget.subsidiaryModel!.news!.list!.isNotEmpty) {
      contentTabData.add('News');
      contentList.add(const CompanyDetailsNews());
    }
    if (widget.subsidiaryModel != null &&
        widget.subsidiaryModel!.similarCompanies!.list!.isNotEmpty) {
      contentTabData.add('Recommend');
      contentList.add(const CompanyDetailsMand());
    }

    contentTabData.add('Reviews');
    // contentList.add(
    //   Consumer<CompanyProvider>(builder: (_, provider, __) {
    //     final CompanyDetailModel? companyDetailModel =
    //         provider.companyDetailModel;
    //     return CompanyDetailsReviews(
    //       comments: companyDetailModel?.comments,
    //       relatedId: companyDetailModel?.id,
    //       pageType: 'company',
    //     );
    //   }),
    // );
  }

  @override
  void initState() {
    super.initState();
    final heightGenerator = Random(328902348);
    final colorGenerator = Random(42490823);

    getAllContentWidget(); //获取所有页面

    itemHeights = List<double>.generate(
        numberOfItems,
        (int _) =>
            heightGenerator.nextDouble() * (maxItemHeight - minItemHeight) +
            minItemHeight);
    itemColors = List<Color>.generate(numberOfItems,
        (int _) => Color(colorGenerator.nextInt(randomMax)).withOpacity(1));
    tabController =
        new TabController(length: contentTabData.length, vsync: this);
    topScroll = new ScrollController();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      body: ConstrainedBox(
          constraints: const BoxConstraints.expand(),
          child: Stack(children: [
            CustomScrollView(
                shrinkWrap: true,
                controller: topScroll,
                physics: const ClampingScrollPhysics(),
                slivers: <Widget>[
                  SliverPersistentHeader(
                    // floating: true,
                    pinned: true,
                    delegate: SliverCustomHeaderDelegate(
                        title: '${widget.model!.name}',
                        collapsedHeight: 54.h,
                        expandedHeight: 240.h,
                        paddingTop: MediaQuery.of(context).padding.top,
                        sliverHeaderWidget: const CompanyDetailsHeader()),
                  ),
                  // new SliverAppBar(
                  //   backgroundColor: Colours.bg_color,
                  //   //默认状态栏高度和appbar高度
                  //   pinned: true,
                  //   automaticallyImplyLeading: false,
                  //
                  //   ///是否随着滑动隐藏标题
                  //   floating: false,
                  //   // snap: true,
                  //   forceElevated: true,
                  //   // padding.top上边距在 iPhoneX 上的值是 44， 在其他设备上的值是 20， 是包含了电池条的高度的。
                  //   // 下边距在iPhoneX 上的值是34，在其他设备上的值是 0。
                  //   // toolbarHeight: MediaQuery.of(context).padding.top>20.0?-10:0,
                  //   toolbarHeight:
                  //       MediaQuery.of(context).padding.top < 44.0 ? 10 : -5,
                  //   leading: Gaps.empty,
                  //   // backwardsCompatibility: false,
                  //   //  excludeHeaderSemantics: false,
                  //   flexibleSpace: Container(
                  //     color: Colours.bg_color,
                  //     // height: 50.h,
                  //     child: MyTabWidget(
                  //       tabDatas: contentTabData,
                  //       itemPositionsListener: itemPositionsListener,
                  //       callBack: (int value) {
                  //         //查看分支事件统计
                  //         _companyDetailPresenter.sendAnalyticsEvent('Branch_click');
                  //         if (value != null) {
                  //           jumpTo(value);
                  //         }
                  //       },
                  //     ),
                  //   ),
                  // ),
                  SliverFillRemaining(
                    child: NotificationListener<ScrollNotification>(
                        onNotification: (ScrollNotification notification) {
                          //重新构建
                          print('BottomEH: ${notification.metrics.pixels.h}');
                          if (notification.metrics.pixels.h == 0.0) {
                            // topScroll.jumpTo(notification.metrics.pixels.h / 3);
                            topScroll.jumpTo(0);
                          }
                          if (notification.metrics.pixels.h > 0.0 &&
                              notification.metrics.pixels.h < 240.h) {
                            // topScroll.jumpTo(notification.metrics.pixels.h / 3);
                            topScroll.jumpTo(0 + notification.metrics.pixels.h);
                          }
                          return false;
                        },
                        child: ScrollablePositionedList.builder(
                          itemCount: contentTabData.length,
                          physics: const BouncingScrollPhysics(),
                          padding: EdgeInsets.only(
                            bottom: 70.h,
                          ),
                          itemBuilder: (context, index) => item(index),
                          itemScrollController: itemScrollController,
                          itemPositionsListener: itemPositionsListener,
                          reverse: false,
                          scrollDirection: Axis.vertical,
                        )),
                  )
                ]),
            Positioned(
                bottom: 0,
                child: Container(
                  height: 60.h,
                  alignment: Alignment.center,
                  color: Colours.bg_color,
                  width: Screen.width(context),
                  child: FollowContactWidget(
                      isCollect: widget.model!.isCollect ?? false,
                      followId: widget.model!.id ?? '',
                      indexType: 0,
                      onTapContact: () {
                        //关键联系人
                        AnalyticEventUtil.analyticsUtil
                            .sendAnalyticsEvent('Contact_Click');
                        showBottomSheet(context, widget.model!.id,
                            widget.model!.personnel?.personnelModel);
                      },
                      collectSuccessful: (StatusModel statusModel) {
                        NavigatorUtils.goBack(context);
                        widget.model!.isCollect =
                            !(widget.model!.isCollect ?? false);
                      }),
                )),
          ])));

  // Widget list(Orientation orientation) => ScrollablePositionedList.builder(
  //       itemCount: numberOfItems,
  //        physics: ClampingScrollPhysics(),
  //       padding: EdgeInsets.only(bottom: 50.h),
  //       itemBuilder: (context, index) => item(index),
  //       itemScrollController: itemScrollController,
  //       itemPositionsListener: itemPositionsListener,
  //       // reverse: reversed,
  //       scrollDirection: Axis.vertical,
  //     );

  void scrollTo(int index) => itemScrollController.scrollTo(
      index: index,
      duration: scrollDuration,
      curve: Curves.easeInOutCubic,
      alignment: alignment);

  void jumpTo(int index) =>
      itemScrollController.jumpTo(index: index, alignment: alignment);

  /// Generate item number [i].
  Widget item(
    int i,
  ) {
    return contentList[i];
  }
}

class MyTabWidget extends StatefulWidget {
  final List? tabDatas;

  final Function? callBack;
  final ItemPositionsListener? itemPositionsListener;

  const MyTabWidget(
      {Key? key, this.tabDatas, this.itemPositionsListener, this.callBack})
      : super(key: key);

  @override
  _MyTabWidgetState createState() => _MyTabWidgetState();
}

class _MyTabWidgetState extends State<MyTabWidget> {
  late ScrollController tableScroll;

  @override
  void initState() {
    super.initState();
    tableScroll = new ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Iterable<ItemPosition>>(
      valueListenable: widget.itemPositionsListener!.itemPositions,
      builder: (context, positions, child) {
        //  int tabIndex = 0;

        int min = 0;
        // int max;
        if (positions.isNotEmpty) {
          min = positions
              .where((ItemPosition position) => position.itemTrailingEdge > 0)
              .reduce((ItemPosition min, ItemPosition position) =>
                  position.itemTrailingEdge < min.itemTrailingEdge
                      ? position
                      : min)
              .index;
          // tabIndex = min;

          // max = positions
          //     .where((ItemPosition position) => position.itemLeadingEdge < 1)
          //     .reduce((ItemPosition max, ItemPosition position) =>
          //         position.itemLeadingEdge > max.itemLeadingEdge
          //             ? position
          //             : max)
          // .index;
        }
        return Container(
          height: 50,
          width: Screen.width(context),
          color: Colours.bg_color,
          alignment: Alignment.center,
          child: ListView.builder(
            controller: tableScroll,
            scrollDirection: Axis.horizontal,
            itemCount: widget.tabDatas!.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                  onTap: () {
                    widget.callBack!(index);
                  },
                  child: Padding(
                    padding: EdgeInsets.only(top: 12, left: 8.w, right: 8.w),
                    child: Container(
                      color: Colours.bg_color,
                      child: Column(
                        children: [
                          Text(
                            "${widget.tabDatas![index] ?? ""}",
                            style: TextStyles.textSize12.copyWith(
                                color: min == index
                                    ? Colours.app_main
                                    : Colours.text,
                                fontWeight:
                                    min == index ? FontWeight.w600 : null),
                          ),
                          Gaps.vGap8,
                          Container(
                            width: 30.w,
                            height: 2,
                            color: min == index
                                ? Colours.app_main
                                : Colors.transparent,
                          ),
                          const Expanded(child: Gaps.empty)
                        ],
                      ),
                    ),
                  ));
            },
          ),
        );
      },
    );
  }
}

class OverScrollBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    switch (getPlatform(context)) {
      case TargetPlatform.iOS:
        return child;
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
        return GlowingOverscrollIndicator(
          child: child,
          //不显示头部水波纹
          showLeading: false,
          //不显示尾部水波纹
          showTrailing: false,
          axisDirection: axisDirection,
          color: Colours.app_main,
        );
      case TargetPlatform.linux:
        break;
      case TargetPlatform.macOS:
        break;
      case TargetPlatform.windows:
        break;
    }
    return Gaps.empty;
  }
}
