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
import 'package:flashinfo/company/presenter/company_detial_presenter.dart';
import 'package:flashinfo/company/widget/details/company_details_album.dart';
import 'package:flashinfo/company/widget/details/company_details_corporate.dart';
import 'package:flashinfo/company/widget/details/company_details_news.dart';
import 'package:flashinfo/company/widget/details/company_details_org_chart.dart';
import 'package:flashinfo/company/widget/details/company_details_product_widget.dart';
import 'package:flashinfo/company/widget/details/company_details_topbar.dart';
import 'package:flashinfo/login/login_router.dart';
import 'package:flashinfo/mvp/status_model.dart';
import 'package:flashinfo/res/resources.dart';
import 'package:flashinfo/routers/fluro_navigator.dart';
import 'package:flashinfo/util/image_utils.dart';
import 'package:flashinfo/util/screen_utils.dart';
import 'package:flashinfo/util/send_analytics_event.dart';
import 'package:flashinfo/widgets/icon_font.dart';
import 'package:flashinfo/widgets/login_toast_dialog.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:screenshot/screenshot.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/rendering.dart';

class BrandScrollPage extends StatefulWidget {
  final BrandBean? model;
  final BrandDetailPresenter brandDetailPresenter;

  const BrandScrollPage({
    Key? key,
    this.model,
    required this.brandDetailPresenter,
  }) : super(key: key);

  @override
  _BrandScrollPageState createState() => _BrandScrollPageState();
}

class _BrandScrollPageState extends State<BrandScrollPage>
    with SingleTickerProviderStateMixin {
  final ItemScrollController itemScrollController = ItemScrollController();
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();
  double alignment = 0;
  late TabController tabController;
  late ScrollController topScroll;
  bool bottomCanScroll = false;
  final CompanyDetailPresenter _companyDetailPresenter =
      new CompanyDetailPresenter();

  List<String> contentTabData = [
    'Summary',
    'Organization',
    'Finance',
    'Business',
    'News',
    'Events',
    'Photos'
  ]; //'Organization','Finance','Business',

  List<Widget> contentList = [];
  bool showTopBar = false;
  ScreenshotController screenshotController = ScreenshotController();

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

  @override
  void initState() {
    super.initState();

    getAllContentWidget(); //获取所有页面
    // WidgetsBinding.instance!.addPostFrameCallback((_) async {
    //
    //   });
  }

  void showBottomSheet(
    BuildContext context,
    String? companyId,
  ) {
    if (!(SpUtil.getBool(Constant.isLogin, defValue: false) ?? false)) {
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
    NavigatorUtils.push(context,
        '${CompanyRouder.companyEmployeePage}?companyId=$companyId&contact_limit=1 ');
  }

  void getAllContentWidget() {
    contentList.add(Column(
      children: [
        const BrandDetailsHeader(),
        CompanyDetailTopBarWidget(
          tabDatas: contentTabData,
          itemPositionsListener: itemPositionsListener,
          callBack: (int value) {
            //查看分支事件统计
            _companyDetailPresenter.sendAnalyticsEvent('Branch_click');
            // if (value != null) {
            //   scrollTo(value);
            // }
          },
        ),
        Gaps.vGap12,
        const CompanyDetailsCorporate(),
      ],
    ));

    contentList.add(CompanyDetailsOrgChart(
        brandDetailPresenter: widget.brandDetailPresenter));

    contentList.add(const BrandFinanceWidget());
    //
    contentList.add(const CompanyDetailsProductWidget());
    // contentList.add(Container(
    //   height: 500,
    //   color: Colours.yellow,));
    contentList.add(const CompanyDetailsNews());
    contentList.add(const BrandEventsPage());
    contentList.add(const CompanyDetailsAlbum());
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
        key: rootWidgetKey,
        child: Scaffold(
            backgroundColor: Colours.bg_color,
            appBar: getTopAppBar(showTopBar, () {
              //截屏
              print('点击截屏了');
              // _capturePng();
            },
                widget.model!.info!.id ?? '',
                widget.model!.summary!.contactInfo!.phoneNumber ?? '',
                widget.model!.info!.name ?? ''),
            body: ConstrainedBox(
                constraints: const BoxConstraints.expand(),
                child: Stack(children: [
                  NotificationListener<ScrollNotification>(
                      onNotification: (ScrollNotification notification) {
                        print(notification.metrics.pixels.h);
                        if (notification.metrics.pixels.h >= 0.0 &&
                            notification.metrics.pixels.h > 245.0.h) {
                          if (mounted) {
                            setState(() {
                              showTopBar = true;
                            });
                          }
                        } else {
                          if (mounted) {
                            setState(() {
                              showTopBar = false;
                            });
                          }
                        }
                        return true;
                      },
                      child: ScrollablePositionedList.builder(
                        itemCount: contentTabData.length,
                        padding: EdgeInsets.only(
                          bottom: 70.h,
                        ),
                        itemBuilder: (context, index) => item(index),
                        itemScrollController: itemScrollController,
                        itemPositionsListener: itemPositionsListener,
                        reverse: false,
                        scrollDirection: Axis.vertical,
                      )),
                  Positioned(
                    bottom: 0,
                    child: Container(
                      height: MediaQuery.of(context).padding.bottom + 50.h,
                      // alignment: Alignment.topLeft,
                      color: Colours.material_bg,
                      width: Screen.width(context),
                      child: BrandBottomBarWidget(
                          // isCollect: widget.model!.isCollect ?? false,
                          // followId: widget.model!.id ?? '',
                          isCollect: false,
                          followId: '',
                          indexType: 0,
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
                            // widget.model!.isCollect = isCollect;
                            // if (widget.model != null) {
                            //   widget.model?.isCollect = isCollect;
                            // }
                          }),
                    ),
                  ),
                ]))));
  }

  void scrollTo(int index) => itemScrollController.scrollTo(
      index: index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOutCubic,
      alignment: alignment);

  void jumpTo(int index) =>
      itemScrollController.jumpTo(index: index, alignment: alignment);

  Widget item(int i) {
    return contentList[i];
  }

  //头部渐变appbar
  PreferredSizeWidget getTopAppBar(bool isShowTopBar, Function callBackImage,
      String id, String phoneNum, String name) {
    return AppBar(
      backgroundColor: isShowTopBar ? Colours.material_bg : Colours.app_main,
      centerTitle: isShowTopBar ? false : true,
      leading: Padding(
          padding: EdgeInsets.only(left: 20.w),
          child: InkWell(
            onTap: () => NavigatorUtils.goBack(context),
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
                Visibility(
                    visible: isShowTopBar,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.r),
                      child: Image(
                        width: 22.w,
                        height: 22.w,
                        fit: BoxFit.fill,
                        image: ImageUtils.getImageProvider(
                            '${widget.model!.info!.logo}'),
                      ),
                    )),
                Gaps.hGap8,
                Expanded(
                  child: Text(
                    '${widget.model!.info!.name}',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyles.textBold16.copyWith(
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
                  decoration: const BoxDecoration(
                      border: Border(
                          top: BorderSide(width: 1, color: Colours.line),
                          bottom: BorderSide(width: 1, color: Colours.line))),
                  child: CompanyDetailTopBarWidget(
                    tabDatas: contentTabData,
                    itemPositionsListener: itemPositionsListener,
                    callBack: (int value) {
                      //查看分支事件统计
                      _companyDetailPresenter
                          .sendAnalyticsEvent('Branch_click');
                      // if (value != null) {
                      //   scrollTo(value);
                      // }
                    },
                  )),
            )
          : null,
    );
  }
}
