import 'dart:typed_data';
import 'dart:ui';
import 'package:flashinfo/brand/brand_rouder.dart';
import 'package:flashinfo/brand/models/brand_bean.dart';
import 'package:flashinfo/brand/page/brand_event_page.dart';
import 'package:flashinfo/brand/page/brand_share_page.dart';
import 'package:flashinfo/brand/presenter/brand_detail_presenter.dart';
import 'package:flashinfo/brand/widget/brand_bottombar_widget.dart';
import 'package:flashinfo/brand/widget/brand_detail_header_widget.dart';
import 'package:flashinfo/brand/widget/brand_financial_widget.dart';
import 'package:flashinfo/common/common.dart';
import 'package:flashinfo/company/company_rouder.dart';
import 'package:flashinfo/company/widget/details/company_details_album.dart';
import 'package:flashinfo/company/widget/details/company_details_corporate.dart';
import 'package:flashinfo/company/widget/details/company_details_news.dart';
import 'package:flashinfo/company/widget/details/company_details_org_chart.dart';
import 'package:flashinfo/company/widget/details/company_details_product_widget.dart';
import 'package:flashinfo/company/widget/details/company_details_topbar.dart';
import 'package:flashinfo/favourites/model/collects_list_beam.dart';
import 'package:flashinfo/login/login_router.dart';
import 'package:flashinfo/mvp/status_model.dart';
import 'package:flashinfo/res/colors.dart';
import 'package:flashinfo/res/gaps.dart';
import 'package:flashinfo/res/resources.dart';
import 'package:flashinfo/routers/fluro_navigator.dart';
import 'package:flashinfo/util/screen_utils.dart';
import 'package:flashinfo/util/send_analytics_event.dart';
import 'package:flashinfo/widgets/icon_font.dart';
import 'package:flashinfo/widgets/load_image.dart';
import 'package:flashinfo/widgets/login_toast_dialog.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tab_indicator_styler/flutter_tab_indicator_styler.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class BrandDetailScrollView extends StatefulWidget {
  final BrandBean? model;
  final BrandDetailPresenter brandDetailPresenter;
  final BrandDetail? brandDetail;
  final bool? isToOfficer;
  const BrandDetailScrollView(
      {Key? key,
      this.model,
      required this.brandDetailPresenter,
      this.brandDetail, this.isToOfficer})
      : super(key: key);

  @override
  _BrandDetailScrollViewState createState() => _BrandDetailScrollViewState();
}

class _BrandDetailScrollViewState extends State<BrandDetailScrollView>
    with SingleTickerProviderStateMixin {
  List<String> tabs = [
    'Summary',
    'Organization',
    'Finance',
    'Business',
    'News',
    'Events',
    'Photos'
  ];
  List<Widget> contentList = [];
  late TabController tabController;
  late TabController tabTwoController;

  //positionScrollView
  final ItemScrollController itemScrollController = ItemScrollController();
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();
  bool reversed = false;
  bool isShowTopBar = false;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: tabs.length, vsync: this);
    contentList.add(Column(
      children: [
        const BrandDetailsHeader(),
        CompanyDetailTopBarWidget(
          tabDatas: tabs,
          itemPositionsListener: itemPositionsListener,
          callBack: (int value) {
            //查看分支事件统计
            // _companyDetailPresenter.sendAnalyticsEvent('Branch_click');
            if (value != null) {
              itemScrollController.scrollTo(
                  index: value, duration: const Duration(milliseconds: 200));
            }
          },
        ),
        Gaps.vGap12,
        const CompanyDetailsCorporate(),
      ],
    ));

    contentList.add(
      CompanyDetailsOrgChart(brandDetailPresenter: widget.brandDetailPresenter),
    );
    contentList.add(
      const BrandFinanceWidget(),
    );
    contentList.add(
      const CompanyDetailsProductWidget(),
    );
    contentList.add(
      const CompanyDetailsNews(),
    );
    contentList.add(
      const BrandEventsPage(),
    );
    contentList.add(
      const CompanyDetailsAlbum(),
    );

    WidgetsBinding.instance!.addPostFrameCallback(
          (_) {
        if (widget.isToOfficer != null && widget.isToOfficer == true) {
          print('到这里了');
          //itemScrollController.scrollTo(index: 1, duration: Duration.zero);
          // setState(() {
          //   isShowTopBar= true;
          // });
          itemScrollController.jumpTo(
              index: 1,
            );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
        key: rootWidgetKey,
        child: Scaffold(
            backgroundColor: Colours.bg_color,
            appBar: getTopAppBar(
                isShowTopBar,
                () {},
                '${widget.model!.info!.id ?? ''}',
                '${widget.model!.summary!.contactInfo!.phoneNumber ?? ''}',
                '${widget.model!.info!.name ?? ''}',
                '${widget.model!.info!.logo ?? ''}'),
            body: ConstrainedBox(
                constraints: const BoxConstraints.expand(),
                child: Stack(children: [
                  OrientationBuilder(
                      builder: (context, orientation) => Column(
                            children: [
                              positionsView,
                              Expanded(
                                  child: NotificationListener<
                                          ScrollNotification>(
                                      onNotification:
                                          (ScrollNotification notification) {
                                        print(notification.metrics.pixels);

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
                          isCollect: widget.model?.info?.isCollect ?? false,
                          followId: widget.model?.info?.id ?? '',
                          indexType: 1,
                          onTapReviews: () {
                            if (!(SpUtil.getBool(Constant.isLogin,
                                    defValue: false) ??
                                false)) {
                              showDialog<void>(
                                  context: context,
                                  barrierDismissible: true,
                                  builder: (_) =>
                                      LoginToastDialog(onPressed: () {
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

                            showBottomSheet(
                              context,
                              widget.model!.info!.id,
                            );
                          },
                          collectSuccessful: (StatusModel statusModel) {
                            if (widget.model != null) {
                              widget.model?.info?.isCollect =
                                  !(widget.model?.info?.isCollect ?? false);
                              widget.brandDetail?.isCollect =
                                  widget.model?.info?.isCollect ?? false;
                            }
                          }),
                    ),
                  ),
                ]))));
  }

  void showBottomSheet(
    BuildContext context,
    String? companyId,
  ) {
    // if (!(SpUtil.getBool(Constant.isLogin, defValue: false) ?? false)) {
    //   // _companyDetailPresenter.sendAnalyticsEvent('Company_Contact_Click_Login');
    //
    //   showDialog<void>(
    //       context: context,
    //       barrierDismissible: true,
    //       builder: (_) => LoginToastDialog(onPressed: () {
    //             Navigator.pop(context);
    //             NavigatorUtils.push(context, LoginRouter.smsLoginPage);
    //           }));
    //   return;
    // }
    NavigatorUtils.push(context,
        '${CompanyRouder.companyEmployeePage}?companyId=$companyId&contact_limit=1 ');
  }

  Widget list(Orientation orientation) => ScrollablePositionedList.builder(
        itemCount: tabs.length,
        itemBuilder: (context, index) => contentList[index],
        itemScrollController: itemScrollController,
        itemPositionsListener: itemPositionsListener,
        reverse: reversed,
        padding: EdgeInsets.only(bottom: 70.h),
        physics: const BouncingScrollPhysics(),
        addAutomaticKeepAlives: true,
        minCacheExtent: 10000.h,
        addRepaintBoundaries: true,
        scrollDirection: Axis.vertical,
      );

  Widget get positionsView => ValueListenableBuilder<Iterable<ItemPosition>>(
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
            //   print('下表$min');
            tabController.animateTo(min,
                duration: const Duration(microseconds: 2));
          }

          return Gaps.empty;
        },
      );

  //头部渐变appbar
  PreferredSizeWidget getTopAppBar(bool isShowTopBar, Function callBackImage,
      String id, String phoneNum, String name, String logo) {
    return AppBar(
      backgroundColor: isShowTopBar ? Colours.material_bg : Colours.app_main,
      centerTitle: isShowTopBar ? false : true,
      leading: Padding(
          padding: EdgeInsets.only(left: 20.w),
          child: InkWell(
            onTap: () {
              if (widget.brandDetail == null) {
                NavigatorUtils.goBack(context);
              } else {
                NavigatorUtils.goBackWithParams(context, widget.brandDetail!);
              }
            },
            child: Icon(
              Icons.arrow_back_ios,
              color: isShowTopBar ? Colours.text : Colours.material_bg,
            ),
          )),
      titleSpacing: 1,
      actions: [
        IconButton(
            onPressed: () {
              showModalBottomSheet<void>(
                  backgroundColor: Colors.transparent, //重点
                  context: context,
                  builder: (BuildContext context) {
                    return BrandSharePage(
                      callBack: () {
                        callBackImage();
                      },
                      brandWebUrlId: id,
                      phoneNum: phoneNum,
                      name: name,
                    );
                  });
            },
            icon: IconFont(
              isNewIcon: true,
              name: 0xe62c,
              color: isShowTopBar ? Colours.text : Colours.material_bg,
              size: Dimens.font_sp24,
            ))
      ],
      title: isShowTopBar
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                LoadBorderImage(logo,
                    width: 22.w, height: 22.w, holderImg: 'company/company'),
                Gaps.hGap8,
                Expanded(
                  child: Text(
                    '$name',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyles.textBold18.copyWith(
                        color:
                            isShowTopBar ? Colours.text : Colours.material_bg),
                  ),
                ),
                Gaps.hGap18,
              ],
            )
          : Text(
              'Brand HomePage',
              style: TextStyles.textBold16.copyWith(
                  color: isShowTopBar ? Colours.text : Colours.material_bg),
            ),
      bottom: isShowTopBar
          ? PreferredSize(
              preferredSize: Size.fromHeight(45.h),
              child: Container(
                  height: 44,
                  decoration: const BoxDecoration(
                      border: Border(
                          top: BorderSide(width: 1, color: Colours.line),
                          bottom: BorderSide(width: 1, color: Colours.line))),
                  child: TabBar(
                    isScrollable: true,
                    controller: tabController,
                    indicatorColor: Colours.app_main,
                    labelColor: Colours.app_main,
                    unselectedLabelColor: Colours.text_gray,
                    indicatorSize: TabBarIndicatorSize.label,
                    labelStyle: TextStyles.textBold14,
                    unselectedLabelStyle: TextStyles.textSize14,
                    indicatorWeight: 4,
                    indicator: MaterialIndicator(
                      color: Colours.app_main,
                      bottomLeftRadius: 5,
                      bottomRightRadius: 5,
                      // distanceFromCenter: 16,
                      // radius: 6,
                      paintingStyle: PaintingStyle.fill,
                    ),
                    indicatorPadding:
                        const EdgeInsets.symmetric(horizontal: 10),
                    onTap: (value) {
                      print(value);
                      itemScrollController.scrollTo(
                          index: value,
                          duration: const Duration(milliseconds: 200));
                    },
                    tabs: tabs
                        .map((e) => Tab(
                              text: e,
                            ))
                        .toList(),
                  )),
            )
          : null,
    );
  }

  // //全局key
  final GlobalKey? rootWidgetKey = GlobalKey();

  Future<Uint8List?> _capturePng() async {
    try {
      // ignore: cast_nullable_to_non_nullable
      final RenderRepaintBoundary boundary = rootWidgetKey!.currentContext!
          .findRenderObject() as RenderRepaintBoundary;
      final image = await boundary.toImage(pixelRatio: 3.0);
      final ByteData byteData =
          // ignore: cast_nullable_to_non_nullable
          await image.toByteData(format: ImageByteFormat.png) as ByteData;
      final Uint8List pngBytes = byteData.buffer.asUint8List();
      NavigatorUtils.push(context, BrandRouder.screenImageSave,
          arguments: pngBytes);

      return pngBytes; //这个对象就是图片数据
    } catch (e) {
      print(e);
    }
    return null;
  }
}
