import 'package:flashinfo/common/common.dart';
import 'package:flashinfo/company/company_rouder.dart';
import 'package:flashinfo/company/models/company_details_bean.dart';
import 'package:flashinfo/company/page/reviews/company_reviews_item_widget.dart';
import 'package:flashinfo/company/presenter/company_detial_presenter.dart';
import 'package:flashinfo/company/widget/details/company_details_item_header.dart';
import 'package:flashinfo/login/login_router.dart';
import 'package:flashinfo/res/resources.dart';
import 'package:flashinfo/routers/fluro_navigator.dart';
import 'package:flashinfo/widgets/card_widget.dart';
import 'package:flashinfo/widgets/icon_font.dart';
import 'package:flashinfo/widgets/login_toast_dialog.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CompanyDetailsReviews extends StatefulWidget {
  const CompanyDetailsReviews(
      {Key? key,
      this.comments,
      required this.relatedId,
      this.pageType = 'company'})
      : super(key: key);
  final Reviews? comments;
  final String? relatedId;
  final String? pageType;
  @override
  @override
  _CompanyDetailsReviewsState createState() => _CompanyDetailsReviewsState();
}

class _CompanyDetailsReviewsState extends State<CompanyDetailsReviews> {
  List<ReviewsModel> list = [];
  int addReviews = 0;
  final CompanyDetailPresenter _companyDetailPresenter =
      CompanyDetailPresenter();
  @override
  void initState() {
    list = widget.comments?.data ?? [];
    addReviews = widget.comments?.total ?? 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding:
            EdgeInsets.only(left: 16.w, right: 16.w, bottom: 8.h, top: 8.h),
        child: CardWidget(
            radius: 12.0.r,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(12.r)),
                color: Colours.material_bg,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 16.w, right: 16.w),
                    child: CompanyDetailsItemHeader(
                        iconName: 0xe674,
                        name: 'Reviews',
                        count: addReviews,
                        onTap: addReviews <= 5
                            ? null
                            : () {
                                NavigatorUtils.pushResult(context,
                                    '${CompanyRouder.companyReviewsPage}?relatedId=${widget.relatedId}&pageType=${widget.pageType}',
                                    (value) {
                                  if (value != null) {
                                    final ReviewsModel model =
                                        value as ReviewsModel;
                                    list.insert(0, model);
                                    addReviews++;
                                    setState(() {});
                                  }
                                });
                              }),
                  ),
                  Gaps.line,
                  Gaps.vGap10,
                  if (addReviews == 0)
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 16.w, vertical: 12.h),
                      child: Text(
                        'There are no Reviews for this company.',
                        style: TextStyles.textGray12,
                      ),
                    )
                  else
                    ListView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.only(bottom: 0.h, top: 0),
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: list.length > 5 ? 5 : list.length,
                      itemBuilder: (BuildContext context, int index) {
                        return CompanyReviewsItemWidget(
                          model: list[index],
                          onTap: () {
                            NavigatorUtils.pushResult(context,
                                '${CompanyRouder.companyReviewsDetailsPage}?relatedId=${widget.relatedId}&pageType=${widget.pageType}',
                                (value) {
                              if (value != null) {
                                final ReviewsModel model =
                                    value as ReviewsModel;
                                list.insert(0, model);
                                addReviews++;
                                setState(() {});
                              }
                            }, arguments: list[index]);
                          },
                        );
                      },
                    ),
                  GestureDetector(
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
                        if (value != null) {
                          final ReviewsModel model = value as ReviewsModel;
                          list.insert(0, model);
                          addReviews++;
                          setState(() {});
                        }
                      });
                    },
                    child: Center(
                      child: Container(
                          width: 151.w,
                          height: 44.h,
                          margin: EdgeInsets.only(bottom: 16.h, top: 16.h),
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
                  )
                ],
              ),
            )));
  }
}
