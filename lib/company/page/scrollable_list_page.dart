import 'package:flashinfo/brand/page/brand_share_page.dart';
import 'package:flashinfo/common/common.dart';
import 'package:flashinfo/company/company_rouder.dart';
import 'package:flashinfo/company/models/company_bean.dart';
import 'package:flashinfo/company/models/company_details_bean.dart';
import 'package:flashinfo/company/models/company_subsidiary_model.dart';
import 'package:flashinfo/company/page/branches/company_detail_branches_page.dart';
import 'package:flashinfo/company/page/business/company_detail_business_page.dart';
import 'package:flashinfo/company/page/company_summary_page.dart';
import 'package:flashinfo/company/page/officers/company_detail_officers_page.dart';
import 'package:flashinfo/company/page/reviews/company_details_reviews.dart';
import 'package:flashinfo/company/presenter/company_detial_presenter.dart';
import 'package:flashinfo/company/widget/bottomSheet/company_details_contact.dart';
import 'package:flashinfo/company/widget/details/company_details_header.dart';
import 'package:flashinfo/company/widget/details/company_details_topbar.dart';
import 'package:flashinfo/company/widget/details/follow_contact_widget.dart';
import 'package:flashinfo/login/login_router.dart';
import 'package:flashinfo/mvp/status_model.dart';
import 'package:flashinfo/personal/model/peoples_bean.dart';
import 'package:flashinfo/res/resources.dart';
import 'package:flashinfo/routers/fluro_navigator.dart';
import 'package:flashinfo/util/image_utils.dart';
import 'package:flashinfo/util/screen_utils.dart';
import 'package:flashinfo/util/send_analytics_event.dart';
import 'package:flashinfo/widgets/icon_font.dart';
import 'package:flashinfo/widgets/login_toast_dialog.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rxdart/rxdart.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import 'dart:typed_data';
import 'dart:ui';
import 'package:flashinfo/brand/brand_rouder.dart';

class ScrollablePositionedListPage extends StatefulWidget {
  final CompanyDetailsBean? model;
  final PublishSubject<CompanySubsidiaryModel> subsidiarySubject;
  final CompanyDetailPresenter companyDetailPresenter;
  final CompanyModel? companyModel;
  final bool? isToOfficer;

  const ScrollablePositionedListPage({
    Key? key,
    this.model,
    required this.subsidiarySubject,
    required this.companyDetailPresenter,
    required this.companyModel,
    this.isToOfficer,
  }) : super(key: key);

  @override
  _ScrollablePositionedListPageState createState() =>
      _ScrollablePositionedListPageState();
}

class _ScrollablePositionedListPageState
    extends State<ScrollablePositionedListPage>
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
  ];

  List<Widget> contentList = [];
  bool showTopBar = false;

  @override
  void initState() {
    super.initState();
    getAllContentWidget(); //获取所有页面
    WidgetsBinding.instance!.addPostFrameCallback(
      (_) {
        if (widget.isToOfficer != null && widget.isToOfficer == true) {
          print('到这里了');
          //itemScrollController.scrollTo(index: 1, duration: Duration.zero);
          scrollTo(1); //跳转到组织架构
        }
      },
    );
  }

  void showBottomSheet(
      BuildContext context, String? companyId, List<PeoplesModel>? list) {
    if ((widget.model?.summary?.registrationInfo?.phoneNumber ?? '')
            .isNotEmpty ||
        (widget.model?.summary?.registrationInfo?.email ?? '').isNotEmpty) {
      if (!(SpUtil.getBool(Constant.isLogin, defValue: false) ?? false)) {
        _companyDetailPresenter
            .sendAnalyticsEvent('Company_Contact_Click_Login');

        showDialog<void>(
            context: context,
            barrierDismissible: true,
            builder: (_) => LoginToastDialog(onPressed: () {
                  Navigator.pop(context);
                  NavigatorUtils.push(context, LoginRouter.smsLoginPage);
                }));
        return;
      }
    }

    showModalBottomSheet<void>(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (BuildContext context) {
          //构建弹框中的内容
          return CompanyDetailsContact(
            registrationInfo: widget.model?.summary?.registrationInfo,
          );
        });
    // NavigatorUtils.push(context,
    //     '${CompanyRouder.companyEmployeePage}?companyId=$companyId&contact_limit=1 ');
  }

  void getAllContentWidget() {
    contentList.add(Column(
      children: [
        const CompanyDetailsHeader(),
        CompanyDetailTopBarWidget(
          tabDatas: contentTabData,
          itemPositionsListener: itemPositionsListener,
          callBack: (int value) {
            //查看分支事件统计
            _companyDetailPresenter.sendAnalyticsEvent('Branch_click');
            if (value != null) {
              scrollTo(value);
            }
          },
        ),
        CompanyDetailsSummaryPage(
          registrationInfo: widget.model!.summary!.registrationInfo,
          industryClassification: widget.model!.summary!.industryClassification,
        ),
      ],
    ));

    contentTabData.add('Officers/Directors');
    contentList.add(CompanyDetailsOfficersPage(
        companyDetailPresenter: widget.companyDetailPresenter));

    contentTabData.add('Branches');
    contentList.add(const CompanyDetailsBranchesPage());
    contentTabData.add('Business');
    contentList.add(const CompanyBusinessPage());

    contentTabData.add('Reviews');
    contentList.add(CompanyDetailsReviews(
      relatedId: widget.model?.info?.id ?? '',
      comments: widget.model?.reviews,
    ));
  }

  // //全局key
  final GlobalKey? rootCompanyWidgetKey = GlobalKey();

  Future<Uint8List?> _capturePng() async {
    try {
      final RenderRepaintBoundary boundary =
          // ignore: cast_nullable_to_non_nullable
          rootCompanyWidgetKey!.currentContext!.findRenderObject()
              as RenderRepaintBoundary;
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
  Widget build(BuildContext context) => RepaintBoundary(
      key: rootCompanyWidgetKey,
      child: Scaffold(
          backgroundColor: Colours.bg_color,
          appBar: getTopAppBar(showTopBar),
          body: ConstrainedBox(
              constraints: const BoxConstraints.expand(),
              child: Stack(children: [
                NotificationListener<ScrollNotification>(
                    onNotification: (ScrollNotification notification) {
                      if (notification.metrics.pixels.h >= 0.0 &&
                          notification.metrics.pixels.h > 215.0.h) {
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
                      physics: const BouncingScrollPhysics(),
                      addAutomaticKeepAlives: true,
                      minCacheExtent: 6000.h,
                      addRepaintBoundaries: true,
                      scrollDirection: Axis.vertical,
                    )),
                Positioned(
                  bottom: 0,
                  child: Container(
                    height: MediaQuery.of(context).padding.bottom + 60,
                    // alignment: Alignment.topLeft,
                    color: Colours.material_bg,
                    width: Screen.width(context),
                    child: FollowContactWidget(
                        isCollect: widget.model!.info!.isCollect ?? false,
                        followId: widget.model!.info!.id ?? '',
                        isReviews: false,
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

                          showBottomSheet(
                              context, widget.model!.info!.id, null);
                        },
                        collectSuccessful: (StatusModel statusModel) {
                          widget.model!.info!.isCollect =
                              !(widget.model!.info!.isCollect ?? false);
                          widget.companyModel?.isCollect =
                              widget.model!.info!.isCollect;
                          // print('---------------');
                          // print(widget.companyModel?.tagId);
                          // print(widget.companyModel?.id);
                          // print(statusModel.collectResult.toString());
                          // print('---------------');
                          // if (widget.model!.info!.isCollect ?? false) {
                          //   if (statusModel.collectResult != null &&
                          //       statusModel.collectResult!.isNotEmpty &&
                          //       statusModel.collectResult![
                          //               widget.companyModel?.tagId] !=
                          //           null) {
                          //     widget.companyModel?.isCollect =
                          //         widget.model!.info!.isCollect;
                          //   }
                          // } else {
                          //   widget.companyModel?.isCollect = false;
                          // }
                        }),
                  ),
                ),
              ]))));

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
  PreferredSizeWidget getTopAppBar(bool isShowTopBar) {
    return AppBar(
      backgroundColor: isShowTopBar ? Colours.material_bg : Colours.app_main,
      centerTitle: isShowTopBar ? false : true,
      leading: Padding(
          padding: EdgeInsets.only(left: 20.w),
          child: InkWell(
            onTap: () {
              if (widget.companyModel == null) {
                NavigatorUtils.goBack(context);
              } else {
                NavigatorUtils.goBackWithParams(context, widget.companyModel!);
              }
            },
            child: Icon(
              Icons.arrow_back_ios,
              color: isShowTopBar ? Colours.text : Colours.material_bg,
            ),
          )),
      actions: [
        IconButton(
            onPressed: () {
              showModalBottomSheet<void>(
                  backgroundColor: Colors.transparent, //重点
                  context: context,
                  builder: (BuildContext context) {
                    return BrandSharePage(
                      callBack: () {
                        _capturePng();
                      },
                      brandWebUrlId: '${widget.model?.info?.id ?? ''}',
                      phoneNum:
                          '${widget.model?.summary?.registrationInfo?.phoneNumber ?? ''}',
                      name: '${widget.model?.info?.name ?? ''}',
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
      titleSpacing: 1,
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
                    style: TextStyles.textBold18.copyWith(
                        color:
                            isShowTopBar ? Colours.text : Colours.material_bg),
                  ),
                ),
                Gaps.hGap18,
              ],
            )
          : Text(
              'Company Homepage',
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
                      if (value != null) {
                        scrollTo(value);
                      }
                    },
                  )),
            )
          : null,
    );
  }
}
