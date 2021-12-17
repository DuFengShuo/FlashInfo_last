import 'package:flashinfo/common/common.dart';
import 'package:flashinfo/company/company_rouder.dart';
import 'package:flashinfo/company/iview/company_detail_iview.dart';
import 'package:flashinfo/company/models/company_details_bean.dart';
import 'package:flashinfo/company/page/reviews/company_reviews_item_widget.dart';
import 'package:flashinfo/company/presenter/company_detial_other_presenter.dart';
import 'package:flashinfo/company/presenter/company_detial_presenter.dart';
import 'package:flashinfo/login/login_router.dart';
import 'package:flashinfo/mvp/base_page.dart';
import 'package:flashinfo/mvp/power_presenter.dart';
import 'package:flashinfo/provider/base_list_provider.dart';
import 'package:flashinfo/provider/user_info_provider.dart';
import 'package:flashinfo/res/resources.dart';
import 'package:flashinfo/routers/fluro_navigator.dart';
import 'package:flashinfo/widgets/icon_font.dart';
import 'package:flashinfo/widgets/login_toast_dialog.dart';
import 'package:flashinfo/widgets/my_app_bar.dart';
import 'package:flashinfo/widgets/my_refresh_list.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CompanyReviewsPage extends StatefulWidget {
  const CompanyReviewsPage(
      {Key? key, required this.relatedId, this.pageType = 'company'})
      : super(key: key);
  final String? relatedId;
  final String? pageType;
  @override
  _CompanyReviewsPageState createState() => _CompanyReviewsPageState();
}

class _CompanyReviewsPageState extends State<CompanyReviewsPage>
    with BasePageMixin<CompanyReviewsPage, PowerPresenter>
    implements CompanyReviewsIMvpView {
  @override
  BaseListProvider<ReviewsModel> companyReviewsProvider =
      BaseListProvider<ReviewsModel>();
  final CompanyDetailPresenter _companyDetailPresenter =
      CompanyDetailPresenter();
  late CompanyReviewsPresenter _companyReviewsPresenter;
  @override
  PowerPresenter createPresenter() {
    final PowerPresenter powerPresenter = PowerPresenter<dynamic>(this);
    _companyReviewsPresenter = CompanyReviewsPresenter();
    _companyReviewsPresenter.relatedId = widget.relatedId ?? '';
    _companyReviewsPresenter.pageType = widget.pageType ?? '';
    powerPresenter.requestPresenter([_companyReviewsPresenter]);
    return powerPresenter;
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      _companyReviewsPresenter.onRefresh();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<BaseListProvider<ReviewsModel>>(
            create: (_) => companyReviewsProvider),
      ],
      child: Scaffold(
          backgroundColor: Colours.bg_color,
          appBar: const MyAppBar(
            centerTitle: 'Reviews',
          ),
          body: Column(
            children: [
              Expanded(
                child:
                    Consumer2<BaseListProvider<ReviewsModel>, UserInfoProvider>(
                  builder: (_, provider, userInfoProvider, __) {
                    return DeerListView(
                      key: const Key('Reviews_list'),
                      itemCount: provider.list.length,
                      stateType: provider.stateType,
                      onRefresh: _companyReviewsPresenter.onRefresh,
                      loadMore: _companyReviewsPresenter.loadMore,
                      hasMore: provider.hasMore,
                      totalPages:
                          provider.metaModel?.pagination?.totalPages ?? 1,
                      isLogin: userInfoProvider.userInfoModel == null &&
                          (provider.metaModel?.pagination?.total ?? 0) > 3,
                      loginName: 'View all Reviews',
                      itemBuilder: (_, index) {
                        return CompanyReviewsItemWidget(
                          model: provider.list[index],
                          onTap: () {
                            NavigatorUtils.pushResult(context,
                                CompanyRouder.companyReviewsDetailsPage,
                                (value) {
                              print(value);
                            }, arguments: provider.list[index]);
                          },
                        );
                      },
                    );
                  },
                ),
              ),
              Container(
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
                        if (!(SpUtil.getBool(Constant.isLogin,
                                defValue: false) ??
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
                  ))
            ],
          )),
    );
  }
}
