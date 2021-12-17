import 'package:flashinfo/dashboard/widgets/dashboard_search_widget.dart';
import 'package:flashinfo/home/model/initialize_model.dart';
import 'package:flashinfo/profile/profile_router.dart';
import 'package:flashinfo/provider/common_provider.dart';
import 'package:flashinfo/res/resources.dart';
import 'package:flashinfo/routers/fluro_navigator.dart';
import 'package:flashinfo/search/search_router.dart';
import 'package:flashinfo/util/toast_utils.dart';
import 'package:flashinfo/widgets/icon_font.dart';
import 'package:flashinfo/widgets/load_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flashinfo/util/screen_utils.dart';
import 'package:provider/provider.dart';

class DashboardTopWidget extends StatelessWidget {
  const DashboardTopWidget({Key? key, required this.itemIconArray})
      : super(key: key);
  final List<dynamic> itemIconArray;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
            bottom: 0,
            child: Container(
              color: Colours.bg_color,
              width: context.width,
              height: 95.h,
            )),
        Container(
          padding: EdgeInsets.symmetric(horizontal: Dimens.gap_dp16),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Gaps.vGap20,
                LoadAssetImage(
                  'dashboard/dashboard_logo',
                  width: 168.w,
                  height: 38.5.h,
                  fit: BoxFit.contain,
                ),
                Gaps.vGap16,
                DashboardSearchWidget(
                  callBack: () => NavigatorUtils.push(
                      context, SearchRouter.searchCachePage),
                ),
                Gaps.vGap8,
                Consumer<CommonProvider>(builder: (_, provider, __) {
                  return Visibility(
                    visible: provider.hotWordsModel != null &&
                        provider.hotWordsModel?.hotWords != null &&
                        provider.hotWordsModel!.hotWords!.isNotEmpty,
                    child: Container(
                      color: Colors.transparent,
                      height: 24.h,
                      child: ListView.builder(
                        itemCount: provider.hotWordsModel?.hotWords?.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          final HotWordsItemModel? itemModel =
                              provider.hotWordsModel?.hotWords?[index];
                          final String indexType = itemModel?.type == 'company'
                              ? '0'
                              : (itemModel?.type == 'people' ? '1' : '2');
                          return HotTextBtn(
                              title: itemModel?.name ?? '',
                              onTap: () => NavigatorUtils.push(context,
                                  '${SearchRouter.searchPage}?indexType=$indexType&searchValue=${itemModel?.name}'));
                        },
                      ),
                    ),
                  );
                }),
                Gaps.vGap8,
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: Dimens.gap_dp15),
                    decoration: BoxDecoration(
                      color: Colours.material_bg,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: itemIconArray
                          .map(
                            (dynamic item) => ItemIcon(
                              title: item['title'].toString(),
                              iconName: item['iconName'] as int,
                              index: int.parse(item['index'].toString()),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ),
                Gaps.vGap50,
                Gaps.vGap5,
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class ItemIcon extends StatelessWidget {
  const ItemIcon({
    Key? key,
    required this.title,
    required this.iconName,
    required this.index,
  }) : super(key: key);
  final String title;
  final int iconName;
  final int index;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        switch (index) {
          case 0:
            NavigatorUtils.push(context,
                '${SearchRouter.searchPage}?indexType=1&otherString=all');
            break;
          case 1:
            NavigatorUtils.push(context,
                '${SearchRouter.searchPage}?indexType=0&otherString=all');
            break;
          case 2:
            Toast.show('This feature is under development...');
            break;
          case 3:
            NavigatorUtils.push(context, ProfileRouter.businessCenterPage);
            break;
          default:
        }
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              color: const Color(0xFF5398F5).withAlpha(30),
              borderRadius: BorderRadius.circular(22.w),
            ),
            width: 44.w,
            height: 44.w,
            child: IconFont(
              name: iconName,
              size: 22.sp,
              color: const Color.fromRGBO(50, 112, 237, 0.6),
            ),
          ),
          Gaps.vGap5,
          Text(
            title,
            style:
                TextStyle(fontSize: Dimens.font_sp9, color: Colours.text_gray),
          )
        ],
      ),
    );
  }
}

class HotTextBtn extends StatelessWidget {
  const HotTextBtn({Key? key, this.title, this.onTap}) : super(key: key);
  final String? title;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          // color: Colours.bg_color,
          borderRadius: BorderRadius.circular(4.w),
        ),
        // margin: EdgeInsets.only(right: Dimens.gap_dp5),
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: Dimens.gap_dp8),
        height: 24.h,
        child: Text(
          title ?? '',
          style: TextStyles.textSize12.copyWith(
              color: Colours.material_bg, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
