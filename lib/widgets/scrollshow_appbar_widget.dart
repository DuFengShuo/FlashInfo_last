import 'package:flashinfo/brand/page/brand_share_page.dart';
import 'package:flashinfo/company/widget/details/company_details_topbar.dart';
import 'package:flashinfo/res/resources.dart';
import 'package:flashinfo/routers/fluro_navigator.dart';
import 'package:flashinfo/widgets/icon_font.dart';
import 'package:flashinfo/widgets/load_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tab_indicator_styler/flutter_tab_indicator_styler.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class ScrollShowAppBar extends StatefulWidget {
  final bool isShowAppBar;
  final TabController tabController;
  final List<String> tabTitles;
  final Function tabTapCallBack;
  final ItemPositionsListener itemPositionsListener;
  final String title;
  final String? logo;
  final String? name;
  final String? phone;
  final String? detailId;

  const ScrollShowAppBar({
    Key? key,
    required this.title,
    required this.isShowAppBar,
    required this.tabController,
    required this.tabTitles,
    required this.tabTapCallBack,
    required this.itemPositionsListener,
    this.logo,
    this.name,
    this.phone,
    this.detailId,
  }) : super(key: key);

  @override
  _ScrollShowAppBarState createState() => _ScrollShowAppBarState();
}

class _ScrollShowAppBarState extends State<ScrollShowAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      // elevation: 0.8,
      backgroundColor:
          widget.isShowAppBar ? Colours.material_bg : Colours.app_main,
      foregroundColor: Colors.transparent,
      centerTitle: widget.isShowAppBar ? false : true,
      leading: Padding(
          padding: EdgeInsets.only(left: 20.w),
          child: InkWell(
            onTap: () => NavigatorUtils.goBackWithParams(context, ''),
            child: Icon(
              Icons.arrow_back_ios,
              color: widget.isShowAppBar ? Colours.text : Colours.material_bg,
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
                        //callBackImage();
                      },
                      brandWebUrlId: '${widget.detailId}',
                      phoneNum: '',
                      name: '${widget.name}',
                      isPersonnel: true,
                    );
                  });
            },
            icon: IconFont(
              isNewIcon: true,
              name: 0xe62c,
              color: widget.isShowAppBar ? Colours.text : Colours.material_bg,
              size: Dimens.font_sp24,
            ))
      ],
      title: widget.isShowAppBar
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                LoadBorderImage(
                  '${widget.logo}',
                  width: 22.w,
                  height: 22.w,
                  holderImg: 'company/company',
                  radius: 22.r,
                ),
                Gaps.hGap8,
                Expanded(
                  child: Text(
                    '${widget.name}',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyles.textBold18.copyWith(
                        color: widget.isShowAppBar
                            ? Colours.text
                            : Colours.material_bg),
                  ),
                ),
                Gaps.hGap18,
              ],
            )
          : Text(
              '${widget.title}',
              style: TextStyles.textBold16.copyWith(
                  color:
                      widget.isShowAppBar ? Colours.text : Colours.material_bg),
            ),
      bottom: widget.isShowAppBar
          ?
          // PreferredSize(
          //         child: CompanyDetailTopBarWidget(
          //           tabDatas: widget.tabTitles,
          //           itemPositionsListener: widget.itemPositionsListener,
          //           callBack: (int value) {
          //             //查看分支事件统计
          //             // _companyDetailPresenter.sendAnalyticsEvent('Branch_click');
          //             // if (value != null) {
          //             //   itemScrollController.scrollTo(
          //             //       index: value,
          //             //       duration: const Duration(milliseconds: 200));
          //             // }
          //             widget.tabTapCallBack(value);
          //           },
          //         ),
          //         preferredSize: Size.fromHeight(44.h))

          PreferredSize(
              preferredSize: Size.fromHeight(44.h),
              child:
              Container(
                decoration: const BoxDecoration(
                    border: Border(
                        top: BorderSide(width: 1, color: Colours.line),
                        bottom: BorderSide(width: 1, color: Colours.line))),
                height: 44.h,
                child:        Container(
                    margin: EdgeInsets.only(top: 8.h),
                    height: 44.h,
                    child: TabBar(
                      isScrollable: true,
                      controller: widget.tabController,
                      indicatorColor: Colours.app_main,
                      labelColor: Colours.app_main,
                      unselectedLabelColor: Colours.text_gray,
                      indicatorSize: TabBarIndicatorSize.label,
                      labelStyle: TextStyles.textBold14.copyWith(fontWeight: FontWeight.bold),
                      unselectedLabelStyle: TextStyles.textSize14,
                      indicatorWeight: 4,
                      indicator: MaterialIndicator(
                        color: Colours.app_main,
                        bottomLeftRadius: 8.r,
                        bottomRightRadius: 8.r,
                        topLeftRadius: 8.r,
                        topRightRadius: 8.r,
                        // distanceFromCenter: 16,
                        // radius: 6,
                        paintingStyle: PaintingStyle.fill,
                      ),
                      indicatorPadding:
                       EdgeInsets.symmetric(horizontal: 12.w),
                      onTap: (value) {
                        print(value);
                        widget.tabTapCallBack(value);
                        // itemScrollController.scrollTo(
                        //     index: value,
                        //     duration: const Duration(milliseconds: 200));
                      },
                      tabs: widget.tabTitles
                          .map((e) => Tab(
                        text: e,
                      ))
                          .toList(),
                    )),
              )

            )
          : null,
    );
  }
}
