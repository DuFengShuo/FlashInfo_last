import 'package:flashinfo/common/common.dart';
import 'package:flashinfo/company/company_rouder.dart';
import 'package:flashinfo/company/models/company_details_bean.dart';
import 'package:flashinfo/company/presenter/company_detial_presenter.dart';
import 'package:flashinfo/login/login_router.dart';
import 'package:flashinfo/res/colors.dart';
import 'package:flashinfo/res/dimens.dart';
import 'package:flashinfo/res/resources.dart';
import 'package:flashinfo/routers/fluro_navigator.dart';
import 'package:flashinfo/widgets/icon_font.dart';
import 'package:flashinfo/widgets/login_toast_dialog.dart';
import 'package:flashinfo/widgets/my_app_bar.dart';
import 'package:flashinfo/widgets/my_card.dart';
import 'package:flashinfo/widgets/my_scroll_view.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'company_reviews_item_widget.dart';

class CompanyReviewsDetailsPage extends StatefulWidget {
  const CompanyReviewsDetailsPage(
      {Key? key,
      required this.model,
      this.pageType = 'company',
      this.relatedId})
      : super(key: key);
  final ReviewsModel model;
  final String pageType;
  final String? relatedId;
  @override
  _CompanyReviewsDetailsPageState createState() =>
      _CompanyReviewsDetailsPageState();
}

class _CompanyReviewsDetailsPageState extends State<CompanyReviewsDetailsPage> {
  final CompanyDetailPresenter _companyDetailPresenter =
      CompanyDetailPresenter();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colours.bg_color,
        appBar: const MyAppBar(
          centerTitle: 'Reviews',
        ),
        body: MyScrollView(
            isSafeArea: false,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: Dimens.gap_dp16, vertical: Dimens.gap_v_dp16),
                child: MyCard(
                    child: Padding(
                  padding: EdgeInsets.symmetric(vertical: Dimens.gap_v_dp16),
                  child: CompanyReviewsItemWidget(
                    model: widget.model,
                    isMaxLines: true,
                  ),
                )),
              ),
            ],
            bottomButton: Container(
                width: double.infinity,
                height: 80.h,
                color: Colours.material_bg,
                child: Padding(
                  padding: EdgeInsets.only(
                      left: Dimens.gap_dp16,
                      right: Dimens.gap_dp16,
                      bottom: 25.h,
                      top: Dimens.gap_v_dp10),
                  child: GestureDetector(
                    onTap: () {
                      if (!(SpUtil.getBool(Constant.isLogin, defValue: false) ??
                          false)) {
                        //写评论未登录
                        _companyDetailPresenter
                            .sendAnalyticsEvent('WriteReviewGoLogin');
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
                      final int indexType =
                          widget.pageType == 'company' ? 1 : 3;
                      NavigatorUtils.pushResult(context,
                          '${CompanyRouder.companyRateReviewsPage}?relatedId=${widget.relatedId}&indexType=$indexType',
                          (value) {
                        NavigatorUtils.goBackWithParams(context, value);
                      });
                    },
                    child: Container(
                        height: 20.h,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colours.app_main,
                          border: new Border.all(
                              color: Colours.app_main, width: 1.w),
                          //设置四周圆角 角度
                          borderRadius:
                              BorderRadius.all(Radius.circular(25.0.h)),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconFont(
                              name: 0xe63f,
                              color: Colours.material_bg,
                              size: 18.sp,
                            ),
                            Gaps.hGap5,
                            Text(
                              'Write Reviews',
                              style: TextStyles.textSize12
                                  .copyWith(color: Colours.material_bg),
                            ),
                          ],
                        )),
                  ),
                ))));
  }
}
