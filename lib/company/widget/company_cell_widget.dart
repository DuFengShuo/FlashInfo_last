import 'package:flashinfo/common/common.dart';
import 'package:flashinfo/company/models/company_bean.dart';
import 'package:flashinfo/favourites/page/cancel_group_page.dart';
import 'package:flashinfo/favourites/page/group_dialog_page.dart';
import 'package:flashinfo/login/login_router.dart';
import 'package:flashinfo/mvp/status_model.dart';
import 'package:flashinfo/provider/common_provider.dart';
import 'package:flashinfo/res/dimens.dart';
import 'package:flashinfo/res/resources.dart';
import 'package:flashinfo/routers/fluro_navigator.dart';
import 'package:flashinfo/util/other_utils.dart';
import 'package:flashinfo/widgets/hight_light_text_widget.dart';
import 'package:flashinfo/widgets/icon_font.dart';
import 'package:flashinfo/widgets/load_image.dart';
import 'package:flashinfo/widgets/login_toast_dialog.dart';
import 'package:flashinfo/widgets/my_card.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:flashinfo/util/screen_utils.dart';

class CompanyCellWidget extends StatelessWidget {
  const CompanyCellWidget(
      {Key? key,
      this.isLead = false,
      this.onTap,
      this.companyModel,
      this.collectSuccessful,
      this.highlightText = '',
      this.isCancelAll = true})
      : super(key: key);
  final bool isLead;
  final void Function()? onTap;
  final CompanyModel? companyModel;
  final void Function(StatusModel)? collectSuccessful;
  final bool isCancelAll;
  final String? highlightText;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.only(
          left: Dimens.gap_dp16,
          right: Dimens.gap_dp16,
          bottom: Dimens.gap_v_dp8,
        ),
        child: MyCard(
          child: Column(
            children: [
              _topWidget(context),
              _cententWidget(context),
              if (isLead) _leadWidget(context) else _bottomWidget(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _topWidget(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: Dimens.gap_dp10,
          right: Dimens.gap_dp10,
          top: Dimens.gap_v_dp10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LoadBorderImage(companyModel?.logo ?? '',
              width: 29.w, height: 29.h, holderImg: 'company/company'),
          Gaps.hGap10,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      constraints: BoxConstraints(
                        maxWidth: Screen.width(context) - 170.w,
                      ),
                      child: HighlightTextWidget(
                          name: companyModel?.name ?? '-',
                          highlightText: highlightText ?? ''),
                    ),
                    Gaps.hGap4,
                    Visibility(
                      visible: companyModel?.countryImg?.imgName != null &&
                          (companyModel?.countryImg?.imgName ?? '').isNotEmpty,
                      child: Consumer<CommonProvider>(
                        builder: (_, commonProvider, __) {
                          final Map<String, String>? nationalFlag =
                              commonProvider
                                  .initializeModel?.icon?.nationalFlag;
                          return LoadImage(
                            nationalFlag?[companyModel?.countryImg?.imgName] ??
                                '',
                            width: 18.0.w,
                            height: 12.0.h,
                            fit: BoxFit.fitHeight,
                          );
                        },
                      ),
                    ),
                    const Spacer(),
                  ],
                ),
                Gaps.vGap10,
                Wrap(
                  spacing: 10.w, //主轴上子控件的间距
                  runSpacing: 5.0.h, //交叉轴上子控件之间的间距
                  children: _industryWidget(), //要显示的子控件集合
                ),
              ],
            ),
          ),
          Gaps.hGap10,
          InkWell(
            onTap: () => _showFavouritesDialog(context),
            child: Container(
              padding: EdgeInsets.symmetric(
                  horizontal: Dimens.gap_dp5, vertical: Dimens.gap_v_dp5),
              child: IconFont(
                  name: 0xe611,
                  size: 16.h,
                  color: (companyModel?.isCollect ?? false)
                      ? Colours.app_main
                      : Colours.unselected_item_color),
            ),
          ),
          Gaps.hGap5,
        ],
      ),
    );
  }

  List<Widget> _industryWidget() {
    final List<Widget> arr = [];
    int i = 0;
    arr.add(_borderText(false, companyModel?.companyStatus ?? ''));
    for (final Industry item in companyModel?.industry ?? <Industry>[]) {
      arr.add(_borderText(true, item.name ?? ''));
      i++;
      if (i == 3) {
        break;
      }
    }
    return arr;
  }

  Widget _cententWidget(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: Dimens.gap_dp10, vertical: Dimens.gap_v_dp20),
      child: Row(
        children: [
          _cententText(
              context,
              'Founded Date',
              companyModel?.foundTime == null
                  ? '-'
                  : (companyModel?.foundTime.toString() ?? '-'),
              true),
          _cententText(context, 'Num.of Employee',
              companyModel?.peopleNumber ?? '-', true),
          _cententText(context, 'Founder', companyModel?.founder ?? '-', false),
        ],
      ),
    );
  }

  Widget _bottomWidget(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 7.0.h),
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border(
          top: Divider.createBorderSide(context, width: 1.w),
        ),
      ),
      child: Row(
        children: <Widget>[
          IconFont(
              name: 0xe625, size: Dimens.font_sp14, color: Colours.app_main),
          Gaps.hGap12,
          Expanded(
            child: InkWell(
              onTap: () {},
              child: Text(
                companyModel?.mobile ?? '-',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyles.textSize12.copyWith(color: Colours.app_main),
              ),
            ),
          ),
          Gaps.hGap12,
          Visibility(
            visible: true,
            child: RichText(
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              text: TextSpan(
                text: 'more',
                style: TextStyles.textGray12,
                children: <TextSpan>[
                  TextSpan(
                    text: '${companyModel?.mobileCount}',
                    style:
                        TextStyles.textGray12.copyWith(color: Colours.app_main),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _leadWidget(BuildContext context) {
    final List<String> leads = [];
    if (companyModel?.products != null && companyModel!.products!.isNotEmpty) {
      companyModel?.products!.forEach((Product item) {
        leads.add(item.name ?? '');
      });
    }
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 7.0.h),
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border(
          top: Divider.createBorderSide(context, width: 1.w),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          IconFont(name: 0xe627, size: 14.sp, color: const Color(0xff3F7FF0)),
          Gaps.hGap12,
          Expanded(
              child: Text(
            leads.join('、') == '' ? '一' : leads.join('、'),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ))
        ],
      ),
    );
  }

  Widget _borderText(bool isIndustry, String text) {
    return Visibility(
      visible: text.isNotEmpty,
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: Dimens.gap_dp5, vertical: Dimens.gap_v_dp2),
        // constraints: BoxConstraints(maxWidth: 120.w),
        decoration: BoxDecoration(
          color: isIndustry
              ? const Color.fromRGBO(50, 112, 237, 0.2)
              : Colors.white,
          //设置四周圆角 角度
          borderRadius: BorderRadius.all(Radius.circular(3.0.w)),
          //设置四周边框
          border: new Border.all(
            width: isIndustry ? 0 : 0.6.w,
            color: isIndustry
                ? const Color.fromRGBO(50, 112, 237, 0.2)
                : Colours.app_main,
          ),
        ),
        child: Text(
          text,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: const Color(0xff3777EE),
            fontSize: Dimens.font_sp10,
          ),
        ),
      ),
    );
  }

  Widget _cententText(
      BuildContext context, String title, String text, bool isShowBorder) {
    return Expanded(
      child: Column(
        children: <Widget>[
          Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyles.textGray12,
          ),
          Container(
            alignment: Alignment.center,
            width: double.infinity,
            padding: EdgeInsets.only(top: 8.0.h),
            decoration: BoxDecoration(
              border: Border(
                right: Divider.createBorderSide(context,
                    width: isShowBorder ? 1.w : 0, color: Colours.bg_color),
              ),
            ),
            child: Text(
              text.isEmpty ? '一' : text,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyles.textBold12,
            ),
          ),
        ],
      ),
    );
  }

  void _showFavouritesDialog(BuildContext context) {
    if (!(SpUtil.getBool(Constant.isLogin, defValue: false) ?? false)) {
      showDialog<void>(
          context: context,
          barrierDismissible: true,
          builder: (_) => LoginToastDialog(onPressed: () {
                Navigator.pop(context);
                NavigatorUtils.push(context, LoginRouter.smsLoginPage);
              }));
      return;
    }
    if (!isCancelAll) {
      final StatusModel statusModel = StatusModel();
      collectSuccessful!(statusModel);
      return;
    }
    if (companyModel?.isCollect ?? false) {
      showElasticDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return CancelGroupPage(
            indexType: 0,
            relatedTd: companyModel?.id,
            collectCancel: collectSuccessful,
          );
        },
      );
    } else {
      showElasticDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return GroupDialogPage(
            indexType: 0,
            relatedTd: companyModel?.id,
            collectSuccessful: collectSuccessful,
          );
        },
      );
    }
  }
}
